package com.dao;

import com.domain.Topic;
import org.springframework.stereotype.Repository;

@Repository
public class TopicDao extends BaseDao<Topic> {
    private static final String GET_BOARD_DIGEST_TOPICS="from Topic t where t.boardId = ? and digest>0 order by t.lastPost desc,t.digest desc ";
    private static final String GET_PAGED_TOPICS="from Topic where boardId = ? order by lastPost desc";
    //private static final String QUERY_TOPIC_BY_TITLE="from Topic t where t.topicTitle like ? order by t.lastPost";

    //获取社区某一页的精华帖子,按照最后回复时间以及精华级别
    public Page getBoardDigestTopics(int pageSize,int pageNo,int boardId){
        return pageQuery(GET_BOARD_DIGEST_TOPICS,pageNo,pageSize,boardId);
    }
    //获取社区版块某一页的帖子
    public Page getPagedTopics(int pageSize,int pageNo,int boardId){
        return pageQuery(GET_PAGED_TOPICS,pageNo,pageSize,boardId);
    }

    //获取与帖子标题模糊匹配的主题帖子
    public Page queryTopicByTitle(int pageSize,int pageNo,String title){
        return searchQuery(pageNo,pageSize,title);
    }

}
