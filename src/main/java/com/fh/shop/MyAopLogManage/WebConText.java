package com.fh.shop.MyAopLogManage;

import javax.servlet.http.HttpServletRequest;
import java.io.Serializable;

public class WebConText implements Serializable {
      private static ThreadLocal<HttpServletRequest> requestThreadLocal = new ThreadLocal<>();

      //存值當前 綫程wei  key
      public static void setRequest(HttpServletRequest request){
            requestThreadLocal.set(request);
      }
      //取值
      public static HttpServletRequest getRequest(){
            return requestThreadLocal.get();
      }

      public static void remove(){
            requestThreadLocal.remove();;
      }

}
