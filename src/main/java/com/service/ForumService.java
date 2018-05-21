package com.service;

import com.dao.*;
import com.domain.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class ForumService {
    @Autowired
    private TopicDao topicDao;
    @Autowired
    private UserDao userDao;
    @Autowired
    private PostDao postDao;
    @Autowired
    private LoginLogDao loginLogDao;
    @Autowired
    private BoardDao boardDao;

    public TopicDao getTopicDao() {
        return topicDao;
    }

    public void setTopicDao(TopicDao topicDao) {
        this.topicDao = topicDao;
    }

    public UserDao getUserDao() {
        return userDao;
    }

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    public PostDao getPostDao() {
        return postDao;
    }

    public void setPostDao(PostDao postDao) {
        this.postDao = postDao;
    }

    public LoginLogDao getLoginLogDao() {
        return loginLogDao;
    }

    public void setLoginLogDao(LoginLogDao loginLogDao) {
        this.loginLogDao = loginLogDao;
    }

    public BoardDao getBoardDao() {
        return boardDao;
    }

    public void setBoardDao(BoardDao boardDao) {
        this.boardDao = boardDao;
    }

    //发表一个主题帖,用户积分+10,社区板块帖子加1
    public void addTopic(Topic topic){
        Board board=boardDao.get(topic.getBoardId());
        board.setTopicNum(board.getTopicNum()+1);
        topicDao.save(topic);

        //创建主题帖
        topic.getMainPost().setTopic(topic);
        MainPost mainPost=topic.getMainPost();
        mainPost.setCreateTime(new Date());
        mainPost.setUser(topic.getUser());
        mainPost.setPostTitle(topic.getTopicTitle());
        mainPost.setBoardId(topic.getBoardId());

        //持久化主题帖
        postDao.save(mainPost);

        //添加用户积分
        User user=topic.getUser();
        user.setCredit(user.getCredit()+10);
        userDao.update(user);
    }

    //删除一个帖子,用户积分减少50,社区板块帖子-1,删除所有相关的帖子
    public void removeTopic(int topicId){
        Topic topic=topicDao.get(topicId);
        Board board=boardDao.get(topic.getBoardId());
        board.setTopicNum(board.getTopicNum()-1);
        boardDao.update(board);

        postDao.deleteTopicPosts(topicId);
        topicDao.remove(topic);

        User user=topic.getUser();
        user.setCredit(user.getCredit()-50);
        userDao.update(user);

    }

    //添加一个回复帖子,用户积分加5,主题帖回复数+1,更新最后回复时间
    public void addPost(Post post){
        postDao.save(post);
        Topic topic=topicDao.get(post.getTopic());
        topic.setReplies(topic.getReplies()+1);
        topic.setLastPost(new Date());
        topicDao.update(topic);//topic收到Hibernate托管,可不用这句

        User user=post.getUser();
        user.setCredit(user.getCredit()+5);
        userDao.update(user);
    }
    //删除一个回复的帖子，发表回复帖子的用户积分减20主题帖的回复数减1
    public void removePost(int postId){
        Post post=postDao.get(postId);
        Topic topic=post.getTopic();
        topic.setReplies(topic.getReplies()-1);
        postDao.remove(post);
        topicDao.update(topic);
        User user=post.getUser();
        user.setCredit(user.getCredit()-20);
        userDao.update(user);
    }
    //创建一个新的板块
    public void addBoard(Board board){
        boardDao.save(board);
    }

    //删除一个板块
    public void removeBoard(int boardId){
        Board board=boardDao.get(boardId);
        boardDao.remove(board);
    }

    //将帖子设置为精华贴,用户加100分
    public void makeDigestTopic(int topicId){
        Topic topic=topicDao.get(topicId);
        topic.setDigest(Topic.DIGEST_TOPIC);
        topicDao.update(topic);

        User user=topic.getUser();
        user.setCredit(user.getCredit()+200);
        userDao.update(user);
    }

    //获取所有社区板块
    public List<Board> getAllBoards(){
        return boardDao.loadAll();
    }

    //获取社区板块某一页主题帖,以最后回复时间降序排列
    public Page getPageTopics(int boardId, int pageSize,int pageNo){
        return topicDao.getPagedTopics(pageSize,pageNo,boardId);
    }

    //获取同主题每一页的帖子,以最后回复时间降序排列
    public Page getPagePosts(int topicId,int pageSize,int pageNo){
        return postDao.getPagedPosts(pageSize,pageNo,topicId);
    }

    //查找所有标题包含title的主题帖
    public Page queryTopicByTitle(String title,int pageNo,int pageSize){
        return topicDao.queryTopicByTitle(pageSize,pageNo,title);
    }

    //根据BoardId获取Board对象
    public Board getBoardByBoardId(int boardId){
        return boardDao.get(boardId);
    }

    //根据topicId获取Topic对象
    public Topic getTopicByTopicId(int topicId){
        return topicDao.get(topicId);
    }

    //根据postId获取Post
    public Post getPostByPostId(int postId){
        return postDao.get(postId);
    }

    //将用户设置为管理员
    public void addBoardManager(int boardId,String userName){
        User user=userDao.getUserByUserName(userName);
        if(user!=null){
            Board board=boardDao.get(boardId);
            user.setUserType(User.FORUM_ADMIN);
            user.getManBoards().add(board);
            userDao.update(user);
        }else {
            throw new RuntimeException("用户:"+userName+"不存在");
        }
    }

    //更改主题帖
    public void updateTopic(Topic topic){
        topicDao.update(topic);
    }

    //更改回复帖子
    public void updatePost(Post post){
        postDao.update(post);
    }
}
