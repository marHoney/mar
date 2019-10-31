package com.fh.shop.common;

import java.io.Serializable;

public class MyCtrlResponseView implements Serializable {

    private Integer code;

    private String message;

    private Object data;


    private MyCtrlResponseView(Integer code, String message, Object data) {
        this.code = code;
        this.message = message;
        this.data = data;
    }

    public static MyCtrlResponseView success(){
        return new MyCtrlResponseView(MyEnum.SUCCESS.getCode(),MyEnum.SUCCESS.getName(),null);
    }
    public static MyCtrlResponseView success(Object data){
        return new MyCtrlResponseView(MyEnum.SUCCESS.getCode(),MyEnum.SUCCESS.getName(),data);
    }
    public static MyCtrlResponseView error(){
        return new MyCtrlResponseView(MyEnum.ERROR.getCode(),MyEnum.ERROR.name(),null);
    }
    public static MyCtrlResponseView error(MyEnum myEnum){
        return new MyCtrlResponseView(myEnum.getCode(),myEnum.name(),null);
    }




    public Integer getCode() {
        return code;
    }
    public void setCode(Integer code) {
        this.code = code;
    }
    public String getMessage() {
        return message;
    }
    public void setMessage(String message) {
        this.message = message;
    }
    public Object getData() {
        return data;
    }
    public void setData(Object data) {
        this.data = data;
    }

}
