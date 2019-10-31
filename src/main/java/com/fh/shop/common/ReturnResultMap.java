package com.fh.shop.common;

import java.io.Serializable;
import java.util.List;

public class ReturnResultMap implements Serializable {
    private String code;
    private String message;
    private List data;
    private Object obj;

    public ReturnResultMap(){}

    public ReturnResultMap(String code, String message) {
        this.code = code;
        this.message = message;
    }

    public ReturnResultMap(String code, String message, Object obj) {
        this.code = code;
        this.message = message;
        this.obj = obj;
    }

    public ReturnResultMap(String code, String message, List data) {
        this.code = code;
        this.message = message;
        this.data = data;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public List getData() {
        return data;
    }

    public void setData(List data) {
        this.data = data;
    }
}
