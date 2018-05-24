package com.web;

import com.domain.Board;
import com.service.ForumService;
import com.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class ForumManagerController extends BaseController {

    @Autowired
    private ForumService forumService;
    @Autowired
    private UserService userService;

    public ForumService getForumService() {
        return forumService;
    }

    public void setForumService(ForumService forumService) {
        this.forumService = forumService;
    }

    public UserService getUserService() {
        return userService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }
    //列出论坛所有模块
    @RequestMapping("/index")
    public ModelAndView listAllBoards(){
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("/listAllBoards");
        List<Board> boards= forumService.getAllBoards();
        modelAndView.addObject(boards);
        return modelAndView;
    }

    //添加一个主题帖页面
    @RequestMapping("/forum/addBoardPage")
    public String addBoardPage(){
        return "/forum/addBoard";
    }
    //添加一个主题帖
    //指定论坛的管理员页面
}
