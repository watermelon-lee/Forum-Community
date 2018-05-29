package com.web;

import com.cons.CommonConstant;
import com.dao.Page;
import com.domain.Board;
import com.domain.User;
import com.service.ForumService;
import com.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
        modelAndView.addObject("boards",boards);
        return modelAndView;
    }

    @RequestMapping("/forum/searchTopic")
    public ModelAndView searchPost(@RequestParam("topicName")String topicName,@RequestParam(value = "pageNo",required = false) Integer pageNo){
        ModelAndView modelAndView=new ModelAndView();
        pageNo=pageNo==null?1:pageNo;
        Page pageTopic=forumService.queryTopicByTitle(topicName,pageNo, CommonConstant.PAGE_SIZE);

        modelAndView.addObject("pageTopics",pageTopic);
        modelAndView.setViewName("/listSearchTopics");
        return modelAndView;

    }
    //添加一个版块
    @RequestMapping("/forum/addBoardPage")
    public String addBoardPage(){
        return "/addBoard";
    }

    //添加一个版块成功
    @RequestMapping("/forum/addBoard")
    public String addBoard(Board board){
        forumService.addBoard(board);
        return "/addBoardSuccess";
    }
    //指定管理员页面
    @RequestMapping("/forum/setBoardManagerPage")
    public ModelAndView setBoardManagerPage(){
        ModelAndView modelAndView=new ModelAndView();
        List<Board>boards=forumService.getAllBoards();
        List<User>users=userService.getAllUsers();
        modelAndView.addObject("boards",boards);
        modelAndView.addObject("users",users);
        modelAndView.setViewName("/setBoardManager");
        return modelAndView;
    }

    //指定论坛的管理员
    @RequestMapping("/forum/setBoardManager")
    public ModelAndView setBoardManager(
            @RequestParam("userName")String userName,
            @RequestParam("boardId")String boardId){
        ModelAndView modelAndView=new ModelAndView();
        User user=userService.getUserByUserName(userName);
        if(user==null){
            modelAndView.addObject("errorMsg","用户名不存在");
        }else{
            Board board=new Board();
            board=forumService.getBoardByBoardId(Integer.parseInt(boardId));
            user.getManBoards().add(board);
            userService.update(user);
            modelAndView.setViewName("/success");
        }
        return modelAndView;
    }

    //用户锁定解锁管理页面
    @RequestMapping("/forum/userLockManagePage")
    public ModelAndView userLockManagePage(){
        ModelAndView modelAndView=new ModelAndView();
        List<User>users=userService.getAllUsers();
        modelAndView.addObject("users",users);
        modelAndView.setViewName("/userLockManage");
        return modelAndView;
    }

    //用户管理锁定
    @RequestMapping("/forum/userLockManage")
    public ModelAndView userLockManage(@RequestParam("userName")String userName,@RequestParam("locked")String locked){
        ModelAndView modelAndView=new ModelAndView();
        User user=userService.getUserByUserName(userName);
        if(user==null){
            modelAndView.addObject("errorMsg","用户名”"+userName+"不存在");
            modelAndView.setViewName("/fail");
        }else {
            userService.lockUser(userName);
            modelAndView.setViewName("/success");
        }
        return modelAndView;
    }
}



















