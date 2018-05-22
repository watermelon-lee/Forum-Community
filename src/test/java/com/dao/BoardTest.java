package com.dao;

import com.dao.BoardDao;
import com.domain.Board;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.testng.annotations.Test;

public class BoardTest {
    @Test
    public void test(){
        ApplicationContext context=new ClassPathXmlApplicationContext("ThisIsUsCommunity-dao.xml");
        BoardDao boardDao=(BoardDao)context.getBean("boardDao");
        Board board=new Board();
        board.setBoardName("watermelon");
        board.setBoardDesc("i love you");
        boardDao.save(board);
        System.out.println(boardDao.getBoardNum());
    }
}
