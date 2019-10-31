package com.fh.shop.Myinterceptors;

import com.alibaba.fastjson.JSONObject;
import com.fh.shop.common.MyFinals;
import com.fh.shop.po.resource.Resource;
import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MyMenuInterceptors extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
       // System.out.println("========權限攔截=");
        String requestURI = request.getRequestURI();
        System.out.println(requestURI);
        List<Resource> allResourceList = (List<Resource>) request.getSession().getAttribute(MyFinals.INTERCEPTORS_RESOURCE_LIST);
        //把公共資源放開
        boolean  isCommon = false;
        for (Resource resource : allResourceList) {
            if(StringUtils.isNotEmpty(resource.getResourceUrl()) &&  requestURI.contains(resource.getResourceUrl())){ // 包含了 説明 不是公共的資源
                isCommon=true;
                break;
            }
        }
        if(!isCommon){
            return  true;
        }

        List<Resource> userMenuList = (List<Resource>) request.getSession().getAttribute(MyFinals.INTERCEPTORS_MENU_LIST);
        boolean  isExist  = false;
        for (Resource resource : userMenuList) {
            if(StringUtils.isNotEmpty(resource.getResourceUrl()) && requestURI.contains(resource.getResourceUrl())){
                isExist = true;
                break;
            }
        }
        String header = request.getHeader("X-Requested-With");
        if(!isExist){
            if(StringUtils.isNotEmpty(header) && header.equals("XMLHttpRequest")){
                Map map = new HashMap();
                map.put("code","-100000");
                map.put("message","你沒有權限");
                String str = JSONObject.toJSONString(map);
                outResponseStr(str,response);
            }
            response.sendRedirect(MyFinals.ERROR_RESOURCE_JSP);
        }
        return isExist;
    }

    public void outResponseStr(String str , HttpServletResponse response){
        response.setContentType("application/json;charset=utf-8");
        PrintWriter writer = null;
        try {
            writer = response.getWriter();
            writer.write(str);
            writer.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            if(writer != null){
                writer.close();
            }
        }
    }

}
