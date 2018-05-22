package com.dao;

import com.dao.UserDao;
import com.domain.User;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.testng.annotations.Test;

public class UserTest {
    @Test
    public void test(){
        ApplicationContext context=new ClassPathXmlApplicationContext("ThisIsUsCommunity-dao.xml");
        UserDao userDao=(UserDao)context.getBean("userDao");
        User user=userDao.getUserByUserName("tom");
        System.out.println(user);
    }
}
