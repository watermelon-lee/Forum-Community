package com.dao;

import com.domain.Board;
import org.springframework.stereotype.Repository;

import java.util.Iterator;

@Repository
public class BoradDao extends BaseDao<Board> {
    private static final String GET_BOARD_NUM="select count(f.boardId) from Board f";
    //获取社区版块数
    public long getBoardNum(){
        Iterator num=getHibernateTemplate().iterate(GET_BOARD_NUM);
        return ((Long)num.next());
    }
}
