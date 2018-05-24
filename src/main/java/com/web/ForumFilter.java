package com.web;

import com.domain.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang.StringUtils;
import static com.cons.CommonConstant.*;


@WebFilter(filterName = "ForumFilter")
public class ForumFilter implements Filter {
    
    private static final String FILTERED_REQUEST="@@session_context_filtered_request";

    private static final String[] INHERENT_ESCAPE_URIS={"/index.html","/index.jsp","/login.html","/login.jsp","/login/doLogin.html","/register.jsp","/register.html","/board/listBoardTopics-","/board/listTopicPosts-"};

    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        if(req!=null&&req.getAttribute(FILTERED_REQUEST)!=null){
            chain.doFilter(req,resp);
        }else {
            //设置标识符，防止一次请求多次过滤
            req.setAttribute(FILTERED_REQUEST,Boolean.TRUE);
            HttpServletRequest request=(HttpServletRequest)req;
            User user=getSessionUser(request);

            //用户未登录，当前的URI资源需要登录才可以访问。
            if(user==null&&!isURILogin(request.getRequestURI().toString(),request)){
                String toUrl=request.getRequestURL().toString();
                if(!StringUtils.isEmpty(request.getQueryString())){
                    toUrl=toUrl+"?"+request.getQueryString();
                }
                //将用户请求的URL保存在Session中，用于登陆之后跳转到目标页面
                request.getSession().setAttribute(LOGIN_TO_URL,toUrl);
                //转发到登录页面
                request.getRequestDispatcher("/login.jsp").forward(req,resp);
            }
            chain.doFilter(req,resp);
        }
    }

    public void init(FilterConfig config) throws ServletException {

    }

    private boolean isURILogin(String requestURI,HttpServletRequest request){
        if(request.getContextPath().equalsIgnoreCase(requestURI)||(request.getContextPath()+"/").equalsIgnoreCase(requestURI)){
            return true;
        }
        for (String uri:INHERENT_ESCAPE_URIS){
            if(request!=null&&requestURI.indexOf(uri)>=0){
                return true;
            }
        }
        return false;
    }

    protected User getSessionUser(HttpServletRequest request) {
        return (User) request.getSession().getAttribute(USER_CONTEXT);
    }

}
