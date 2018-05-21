package com;

import com.dao.BoardDao;
import com.dao.Page;
import com.dao.TopicDao;
import com.domain.Board;
import com.domain.Topic;
import com.domain.User;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.testng.annotations.Test;

import java.util.Date;

public class TopicTest {
    @Test
    public void test() {
        ApplicationContext context = new ClassPathXmlApplicationContext("ThisIsUsCommunity-dao.xml");
        TopicDao topicDao=(TopicDao)context.getBean("topicDao");
        Topic topic=  new Topic();
        topic.setBoardId(12);
        topic.setDigest(0);
        topic.setTopicTitle("test topic");
        Date now=new Date();
        topic.setCreateTime(now);
        topic.setLastPost(now);
        User user=new User();
        user.setUserId(10);
        user.setUserName("wade");
        topic.setUser(user);
        topicDao.save(topic);
//        Page page=topicDao.getBoardDigestTopics(2,1,1);
//        System.out.println(page);
    }
}