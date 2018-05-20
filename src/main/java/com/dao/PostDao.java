package com.dao;

import com.domain.Post;
import org.springframework.stereotype.Repository;

@Repository
public class PostDao extends BaseDao<Post>{
    private static final String GET_PAGED_POSTS="from Post t where t.topicId=? order by t.createTime desc";
    private static final String DELETE_TOPIC_POST="delete from Post t where t.topicId=?";
    //查询某一主题下的某一回复,按创建时间排序
    public Page getPagedPosts(int pageSize,int pageNo,int topicId){
        return pageQuery(GET_PAGED_POSTS,pageNo,pageSize,topicId);
    }
    //删除主题下所有帖子
    public void deleteTopicPosts(int topicId){
        getHibernateTemplate().bulkUpdate(DELETE_TOPIC_POST,topicId);
    }
}
