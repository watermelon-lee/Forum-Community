package com.web;

import com.cons.CommonConstant;
import com.domain.User;
import org.springframework.util.Assert;

import javax.servlet.http.HttpServletRequest;

public class BaseController  {
    protected static final String ERROR_MSG_KEY="errorMsg";

    //获取保存在Session中的用户
    protected User getSessionUser(HttpServletRequest request){
        return (User)request.getSession().getAttribute(CommonConstant.USER_CONTEXT);
    }
    //将用户对象保存到Session中
    protected void setSessionUser(HttpServletRequest request,User user){
        request.getSession().setAttribute(CommonConstant.USER_CONTEXT,user);
    }
    //获取基于应用程序的url绝对路径
    public String getAppbaseUrl(HttpServletRequest request,String url){
        Assert.hasLength(url,"Url不可以为空");
        Assert.isTrue(url.startsWith("/"),"Url必须以/开头");
        return request.getContextPath()+url;
    }
}
