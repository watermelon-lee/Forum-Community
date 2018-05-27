package com.web;

import static com.cons.CommonConstant.*;
import com.domain.User;
import com.service.UserService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;

@Controller
public class LoginController extends BaseController {
    @Autowired
    private UserService userService;

    public UserService getUserService() {
        return userService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    //用户登录
    @RequestMapping("/login/doLogin")
    public ModelAndView login(HttpServletRequest request,User user){
        User dbUser=userService.getUserByUserName(user.getUserName());
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("forward:/login.jsp");
        if(!dbUser.getPassword().equals(user.getPassword())){
            modelAndView.addObject("errorMsg","密码不正确");
        }else if(dbUser==null){
            modelAndView.addObject("errorMsg","用户名不存在");
        }else if(dbUser.getLocked()==User.USER_LOCK) {
            modelAndView.addObject("errorMsg","用户被锁定，无法登陆");
        }else {
            dbUser.setLastIp(request.getRemoteAddr());
            dbUser.setLastVisit(new Date());
            userService.loginSuccess(dbUser);
            setSessionUser(request,dbUser);
            String toUrl=(String)request.getSession().getAttribute(LOGIN_TO_URL);
            request.getSession().removeAttribute(LOGIN_TO_URL);

            //如果会话没有保存之前请求的URL，直接跳转主页
            if(StringUtils.isEmpty(toUrl)){
                toUrl="/index.html";
            }
            modelAndView.setViewName("redirect:"+toUrl);
        }
        return modelAndView;
    }
    //登录注销
    @RequestMapping("/login/doLogout")
    public String logout(HttpSession session){
        session.removeAttribute(USER_CONTEXT);
        return "forward:/index.jsp";
    }
}
