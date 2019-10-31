package com.fh.shop.MyAopLogManage;


import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

public class WebConTextFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        //存值
        WebConText.setRequest((HttpServletRequest) request);
        try {
            chain.doFilter(request,response);
        }finally {
            //釋放資源
            WebConText.remove();
        }
    }

    @Override
    public void destroy() {

    }
}
