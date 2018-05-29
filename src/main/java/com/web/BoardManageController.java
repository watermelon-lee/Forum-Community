package com.web;

import com.cons.CommonConstant;
import com.dao.Page;
import com.domain.Board;
import com.domain.Post;
import com.domain.Topic;
import com.domain.User;
import com.service.ForumService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

@Controller
public class BoardManageController extends BaseController {
    @Autowired
    private ForumService forumService;

    public ForumService getForumService() {
        return forumService;
    }

    public void setForumService(ForumService forumService) {
        this.forumService = forumService;
    }


    //列出所有版块下所有的话题
    @RequestMapping("/board/listBoardTopics-{boardId}")
    public ModelAndView listBoardTopics(@PathVariable Integer boardId,@RequestParam(value = "pageNo",required = false)Integer pageNo){
        ModelAndView modelAndView=new ModelAndView();
        Board board=forumService.getBoardByBoardId(boardId);
        pageNo=pageNo==null?1:pageNo;
        Page pagedTopic=forumService.getPageTopics(boardId, CommonConstant.PAGE_SIZE,pageNo);
        modelAndView.addObject("board",board);
        modelAndView.addObject("pagedTopic",pagedTopic);
        modelAndView.setViewName("/listBoardTopics");
        return modelAndView;
    }

    //新增主题帖页面
    @RequestMapping("/board/addTopicPage-{boardId}")
    public ModelAndView addTopicPage(@PathVariable Integer boardId){
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("/addTopic");
        modelAndView.addObject("boardId",boardId);
        return modelAndView;
    }

    //新增主题
    @RequestMapping("/board/addTopic")
    public String  addTopic(HttpServletRequest request,Topic topic){
        User user= getSessionUser(request);
        topic.setUser(user);
        Date date=new Date();
        topic.setLastPost(date);
        topic.setCreateTime(date);
        forumService.addTopic(topic);
        String url="/board/listBoardTopics-"+topic.getBoardId()+".html";
        return "redirect:"+url;
    }

    //列出所有帖子
    @RequestMapping("/board/listTopicPosts-{topicId}")
    public ModelAndView listTopicPosts(@PathVariable Integer topicId,
                                       @RequestParam(value = "pageNo",required = false)Integer pageNo){
        ModelAndView modelAndView=new ModelAndView();
        Topic topic=forumService.getTopicByTopicId(topicId);
        pageNo=pageNo==null?1:pageNo;
        Page pagePost=forumService.getPagePosts(topicId,CommonConstant.PAGE_SIZE,pageNo);
        //为回复帖子表单做准备
        modelAndView.addObject("topic",topic);
        modelAndView.addObject("pagePost",pagePost);
        modelAndView.setViewName("/listTopicPosts");
        return modelAndView;
    }



    //回复主题
    @RequestMapping("/board/addPost")
    public String addPost(HttpServletRequest request,Post post){
        ModelAndView modelAndView=new ModelAndView();
        post.setCreateTime(new Date());
        post.setUser(getSessionUser(request));
        Topic topic=forumService.getTopicByTopicId(Integer.parseInt(request.getParameter("topicId")));
        post.setTopic(topic);
        forumService.addPost(post);
        String url="/board/listTopicPosts-"+post.getTopic().getTopicId()+".html";
        return "redirect:"+url;
    }

    /**
     * 删除版块
     */
    @RequestMapping(value = "/board/removeBoard", method = RequestMethod.GET)
    public String removeBoard(@RequestParam("boardIds") String boardIds) {
        String[] arrIds = boardIds.split(",");
        for (int i = 0; i < arrIds.length; i++) {
            forumService.removeBoard(new Integer(arrIds[i]));
        }
        String targetUrl = "/index.html";
        return "redirect:"+targetUrl;
    }

    /**
     * 删除主题
     */
    @RequestMapping(value = "/board/removeTopic", method = RequestMethod.GET)
    public String removeTopic(@RequestParam("topicIds") String topicIds,@RequestParam("boardId") String boardId) {
        String[] arrIds = topicIds.split(",");
        for (int i = 0; i < arrIds.length; i++) {
            forumService.removeTopic(new Integer(arrIds[i]));
        }
        String targetUrl = "/board/listBoardTopics-" + boardId + ".html";
        return "redirect:"+targetUrl;
    }

    /**
     * 设置精华帖
     */
    @RequestMapping(value = "/board/makeDigestTopic", method = RequestMethod.GET)
    public String makeDigestTopic(@RequestParam("topicIds") String topicIds,@RequestParam("boardId") String boardId) {
        String[] arrIds = topicIds.split(",");
        for (int i = 0; i < arrIds.length; i++) {
            forumService.makeDigestTopic(new Integer(arrIds[i]));
        }
        String targetUrl = "/board/listBoardTopics-" + boardId + ".html";
        return "redirect:"+targetUrl;
    }
}

