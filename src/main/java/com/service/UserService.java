package com.service;

import com.domain.LoginLog;
import com.exception.UserExistException;
import com.dao.LoginLogDao;
import com.dao.UserDao;
import com.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

//用户管理
@Service
public class UserService {
    @Autowired
    private UserDao userDao;
    @Autowired
    private LoginLogDao loginLogDao;

    public UserDao getUserDao() {
        return userDao;
    }

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    public LoginLogDao getLoginLogDao() {
        return loginLogDao;
    }

    public void setLoginLogDao(LoginLogDao loginLogDao) {
        this.loginLogDao = loginLogDao;
    }

    //注册一个新的用户,如果用户名存在,抛出UserExistException异常
    public void register(User user) throws UserExistException{
        User user1=userDao.getUserByUserName(user.getUserName());
        if(user1!=null){
            throw new UserExistException("用户名存在");
        }
        else{
            user.setCredit(100);
            user.setUserType(1);
            userDao.save(user);
        }
    }

    //根据用户名/密码查询User对象
    public User getUserByUserName(String userName){
        return userDao.getUserByUserName(userName);
    }

    //根据UserId加载用户对象
    public User getUserById(int userId){
        return userDao.get(userId);
    }
    //将用户锁定,锁定的用户无法登陆
    public void lockUser(String userName){
        User user=userDao.getUserByUserName(userName);
        user.setLocked(User.USER_LOCK);
        userDao.update(user);
    }
    //解除用户锁定
    public void unLockUser(String userName){
        User user=userDao.getUserByUserName(userName);
        user.setLocked(User.USER_UNLOCK);
        userDao.update(user);
    }
    //根据用户名模糊查询
    public List<User> queryUserByUserName(String userName){
        return userDao.queryUserByUserName(userName);
    }
    //获取所有用户
    public List<User> getAllUsers(){
        return userDao.loadAll();
    }
    //登陆成功,更新状态
    public void loginSuccess(User user){
        user.setCredit(user.getCredit()+5);
        LoginLog loginLog=new LoginLog();
        loginLog.setUser(user);
        loginLog.setIp(user.getLastIp());
        loginLog.setLoginDate(new Date());
        userDao.update(user);
        loginLogDao.save(loginLog);
    }
}
