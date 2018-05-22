package com.service;


import com.dao.BoardDao;
import com.dao.PostDao;
import com.domain.*;
import org.hibernate.Session;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.Date;

import static org.unitils.orm.hibernate.HibernateUnitils.getSession;

@org.testng.annotations.Test
public class Test {
    ApplicationContext context=new ClassPathXmlApplicationContext("ThisIsUsCommunity-service.xml");

    ForumService forumService=(ForumService) context.getBean("forumService");

    UserService userService=(UserService)context.getBean("userService");
    private static User user=new User();

    public void addBoard(){

        Board board=new Board();
        board.setTopicNum(0);
        board.setBoardId(40);
        board.setBoardName("篮球");
        board.setBoardDesc("专业的篮球社区");
        forumService.addBoard(board);
    }

    public void addTopic(){
        Topic topic=new Topic();
        topic.setBoardId(13);
        topic.setLastPost(new Date());
        topic.setReplies(0);
        topic.setCreateTime(new Date());
        topic.setTopicTitle("热火总冠军");
        user.setUserId(1);
        user=forumService.getUserDao().get(user.getUserId());
        MainPost mainPost=new MainPost();
        topic.setMainPost(mainPost);
        mainPost.setPostText("韦德厉害");
        topic.setUser(user);
        forumService.addTopic(topic);

    }

    public void removeTopic(){
        forumService.removeTopic(39);
    }

    // TODO: 18-5-22 还有问题
    // a different object with the same identifier value was already associated with the session: [com.domain.User#1]

    public void addPost(){
        Topic topic=new Topic();
        topic.setTopicId(38);
        user=userService.getUserByUserName("tom");
        Post post=new Post();
        post.setUser(user);
        post.setTopic(topic);
        post.setCreateTime(new Date());
        post.setPostTitle("韦德");
        post.setPostText("good");
        forumService.addPost(post);
    }

    public void removePost(){
       forumService.removePost(52);

    }

    public void makeDigestTopic(){
        forumService.makeDigestTopic(38);
    }

    public void addBoardManager(){
        forumService.addBoardManager(2,"ggg");
    }
}
