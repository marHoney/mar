package com.fh.shop.Myinterceptors;

import com.fh.shop.common.MyFinals;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MyInterceptor extends HandlerInterceptorAdapter {

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
       // System.out.println("================登陸攔截器！");
        Object userObj = request.getSession().getAttribute(MyFinals.LANDING_USER_KEY);
        if(userObj != null){
            return true;
        }else{
            response.encodeRedirectURL("/");
            return  false;
        }


    }

}
