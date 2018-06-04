package com.web;

import com.domain.User;
import com.exception.UserExistException;
import com.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;

@Controller
public class RegisterController extends BaseController {
    @Autowired
    private UserService userService;

    public UserService getUserService() {
        return userService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }
    //用户登录
    @RequestMapping(value = "/register",method = RequestMethod.POST)
    public ModelAndView register(HttpServletRequest request, @RequestParam("avatar") MultipartFile avatar){

        User user=new User();
        user.setUserName(request.getParameter("userName"));
        user.setPassword(request.getParameter("password"));
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("/success");
        String fileName="/img/"+avatar.getOriginalFilename();
        String path= request.getSession().getServletContext().getRealPath("/")+fileName;//会放在编译的target文件夹的ThisIsUsCommunity根目录的img中
        user.setAvatar("/img/user.jpg");
        if(!avatar.isEmpty()){
            user.setAvatar(fileName);
            try{
                avatar.transferTo(new File(path));

            }catch (IOException ex){
                modelAndView.addObject("errorMsg1","上传图像失败");
                modelAndView.setViewName("forward:/register.jsp");
                return modelAndView;
            }
        }
        if(!request.getParameter("password").equals(request.getParameter("again"))){
            modelAndView.addObject("errorMsg2","两次输入密码不同");
            modelAndView.setViewName("forward:/register.jsp");
            return modelAndView;
        }

        try{
            userService.register(user);
        }catch (UserExistException e){
            modelAndView.addObject("errorMsg1","用户名已经存在，请更换用户名");
            modelAndView.setViewName("forward:/register.jsp");
            return modelAndView;
        }

        setSessionUser(request,user);
        return modelAndView;
    }

}
