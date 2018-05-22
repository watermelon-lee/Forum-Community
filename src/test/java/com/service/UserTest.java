package com.service;

import com.domain.User;
import com.exception.UserExistException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.testng.annotations.Test;

@Test
public class UserTest {
    ApplicationContext context=new ClassPathXmlApplicationContext("ThisIsUsCommunity-service.xml");

    ForumService forumService=(ForumService) context.getBean("forumService");

    UserService userService=(UserService)context.getBean("userService");
    public void register()throws UserExistException{
        User user = new User();
        user.setUserName("testwww");
        user.setPassword("1234");

        userService.register(user);

    }

    public void setUserLock(){
        userService.lockUser("testwww");
    }

    public void unlockUser(){
        userService.unLockUser("testwww");
    }

    public void success(){
        User user=userService.getUserByUserName("ggg");
        user.setLastIp("39.107.93.107");
        userService.loginSuccess(user);
    }


}
