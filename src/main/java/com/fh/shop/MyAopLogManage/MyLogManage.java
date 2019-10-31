package com.fh.shop.MyAopLogManage;

import com.fh.shop.biz.logInfo.ILogInfoService;
import com.fh.shop.common.MyFinals;
import com.fh.shop.po.logInfo.LogInfo;
import com.fh.shop.po.user.User;
import org.apache.commons.lang.StringUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;

public class MyLogManage {
    @Resource(name="logInfoService")
    private ILogInfoService iLogInfoService;
    private static final Logger LOG= LoggerFactory.getLogger(MyLogManage.class);

    public Object outLog(ProceedingJoinPoint pjp){
        //獲取類名
        String leiName = pjp.getTarget().getClass().getCanonicalName();
        //獲取方法名
        String fangName = pjp.getSignature().getName();
         //獲取request
        HttpServletRequest request = WebConText.getRequest();
        User user = (User) request.getSession().getAttribute(MyFinals.LANDING_USER_KEY);
        //獲取參數
        Map<String, String[]> parameterMap = request.getParameterMap();
        StringBuffer strbuf = getStringBuffer(parameterMap);
         //獲取自定義注解
        MethodSignature methodSignature= (MethodSignature) pjp.getSignature();
        Method method = methodSignature.getMethod();
         String value= getMyAnnotation(method);
        Object proceed=null;
        try {
             LOG.info(user.getRealName()+"執行了"+leiName+"類的"+fangName+"方法成功");  //log4j 打印
             //增加方法
            addSure(leiName, fangName, user, strbuf, "方法成功", "", MyFinals.LOG_STATUS_SUCCESS,value);
            proceed = pjp.proceed();
        } catch (Throwable throwable) {
            throwable.printStackTrace();
            LOG.info(user.getUserName()+"執行了"+leiName+"類的"+fangName+"方法失敗");//log4j 打印
            //增加方法
            addSure(leiName, fangName, user, strbuf, "方法失敗", throwable.getMessage(),MyFinals.LOG_STATUS_ERROR,value);

            //這個抛出異常是爲了 我們 統一異常的正常接收  如果不抛 統一異常就接受不了
            throw new  RuntimeException(throwable);
        }
        return proceed;
    }

    private String getMyAnnotation(Method method) {
        String value="";
        if(method.isAnnotationPresent(Log.class)){
            Log annotation = method.getAnnotation(Log.class);
             value = annotation.value();
        }
        return value;
    }

    //從request中 獲取 執行方法的參數
    private StringBuffer getStringBuffer(Map<String, String[]> parameterMap) {
        StringBuffer strbuf= new StringBuffer();
        Iterator<Map.Entry<String, String[]>> iterator = parameterMap.entrySet().iterator();
        while (iterator.hasNext()){
            Map.Entry<String, String[]> next = iterator.next();
            String key = next.getKey();
            String[] value = next.getValue();
            strbuf.append("/").append(key).append(":").append(StringUtils.join(value, ","));
        }
        return strbuf;
    }
    // 存儲 類 時間    方法信息
    private void addSure(String leiName, String fangName, User user, StringBuffer strbuf, String 方法成功, String s, Integer logStatusSuccess,String value) {
        LogInfo logInfo = new LogInfo();
        logInfo.setUserName(user.getUserName());
        logInfo.setRealName(user.getRealName());
        logInfo.setCurrDate(new Date());
        logInfo.setInfo("執行了" + leiName + "類的" + fangName + 方法成功);
        logInfo.setErrorMsg(s);
        logInfo.setStatus(logStatusSuccess);
        logInfo.setDetail(strbuf.toString());
        logInfo.setContent(value);
        iLogInfoService.addLogInfo(logInfo);
    }
}
