package com.dao;

import com.dao.BoardDao;
import com.dao.PostDao;
import com.domain.Board;
import com.domain.Post;
import com.domain.Topic;
import com.domain.User;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.testng.annotations.Test;

import java.util.Date;

public class PostTest {

    @Test
    public void test() {
        ApplicationContext context = new ClassPathXmlApplicationContext("ThisIsUsCommunity-dao.xml");
        PostDao postDao = (PostDao) context.getBean("postDao");
        Post post=new Post();
        post.setPostText("test post");
        post.setCreateTime(new Date());
        post.setPostTitle("post1");
        Topic topic=new Topic();
        topic.setTopicId(24);
        post.setTopic(topic);
        User user=new User();
        user.setUserId(1);
        post.setUser(user);
        postDao.save(post);
        postDao.remove(post);
    }
}