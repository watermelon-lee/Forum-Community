package com.web;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;

@WebFilter(filterName = "ForumFilter")
public class ForumFilter implements Filter {
    
    private static final String FILTERED_REQUEST="@@session_context_filtered_request";

    // TODO: 18-5-22 没写完
    private static final String[] INHERENT_ESCAPE_URIS={"/index.html","/index.jsp","/login.html","/login.jsp","/login/doLogin.html","/register.jsp","register.html"};
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        chain.doFilter(req, resp);
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
