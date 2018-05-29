package com.dao;

import com.domain.Post;
import org.springframework.stereotype.Repository;

@Repository
public class PostDao extends BaseDao<Post>{
    private static final String GET_PAGED_POSTS="from Post where topic.topicId = ? order by createTime desc";
    private static final String DELETE_TOPIC_POST="delete from Post where topic.topicId=?";//不可以写 Post.topicId.post与topic只是关联,尽管数据库中Post有TopicId,但是post实体类中并没有TopicId.
    //查询某一主题下的某一回复,按创建时间排序
    public Page getPagedPosts(int pageSize,int pageNo,int topicId){
        return pageQuery(GET_PAGED_POSTS,pageNo,pageSize,topicId);
    }
    //删除主题下所有帖子
    public void deleteTopicPosts(int topicId){
        getHibernateTemplate().bulkUpdate(DELETE_TOPIC_POST,topicId);
    }
}
