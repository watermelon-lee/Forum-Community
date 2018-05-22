package com.dao;

import com.domain.User;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserDao extends BaseDao<User> {
    private static final String GET_USER_BY_USERNAME="from User t where t.userName=?";
    private static final String QUERY_USER_BU_USERNAME="from User t where t.userName like ?";

    //根据用户名查询对象
    public User getUserByUserName(String useName){
        List<User> users=(List<User>) getHibernateTemplate().find(GET_USER_BY_USERNAME,useName);

        if(users.size()==0){
            return null;
        }else{
            return users.get(0);
        }
    }

    public List<User> queryUserByUserName(String userName){
        List<User> users=(List<User>)getHibernateTemplate().find(QUERY_USER_BU_USERNAME,userName+"%");
        return users;
    }
    //根据用户名模糊查询前缀匹配对象
}
