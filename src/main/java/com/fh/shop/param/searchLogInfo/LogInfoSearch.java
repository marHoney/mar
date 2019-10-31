package com.fh.shop.param.searchLogInfo;

import com.fh.shop.common.Page;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class LogInfoSearch extends Page {
    private String userName;
    private String realName;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date minCurrDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date maxCurrDate;
    private String info;
    private Integer status;


    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }


    public Date getMinCurrDate() {
        return minCurrDate;
    }

    public void setMinCurrDate(Date minCurrDate) {
        this.minCurrDate = minCurrDate;
    }

    public Date getMaxCurrDate() {
        return maxCurrDate;
    }

    public void setMaxCurrDate(Date maxCurrDate) {
        this.maxCurrDate = maxCurrDate;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}
