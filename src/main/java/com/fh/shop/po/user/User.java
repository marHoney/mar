package com.fh.shop.po.user;

import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class User  implements Serializable {
    private Long id;
    private String userName;
    private String realName;
    private String password;
    private Integer age;
    private Integer sex;
    private String phone;
    private String emall;
    private Integer salary;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date entryTime;
    private List<Long> roleIds;
    private Long loginCount;//用戶登陸次數
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date lasttime;//用戶退出時閒
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date logintime;//用戶登陸時間
    private Long errorCount;//用戶密碼錯誤的次數
    private Integer isLock;//判斷賬號 是否 鎖定  1未  0是
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date lockDate;// 鎖定時間

    public Integer getIsLock() {
        return isLock;
    }

    public void setIsLock(Integer isLock) {
        this.isLock = isLock;
    }

    public Date getLockDate() {
        return lockDate;
    }

    public void setLockDate(Date lockDate) {
        this.lockDate = lockDate;
    }

    public Long getErrorCount() {
        return errorCount;
    }

    public void setErrorCount(Long errorCount) {
        this.errorCount = errorCount;
    }

    public Date getLogintime() {
        return logintime;
    }

    public void setLogintime(Date logintime) {
        this.logintime = logintime;
    }

    public Long getLoginCount() {
        return loginCount;
    }

    public void setLoginCount(Long loginCount) {
        this.loginCount = loginCount;
    }

    public Date getLasttime() {
        return lasttime;
    }

    public void setLasttime(Date lasttime) {
        this.lasttime = lasttime;
    }

    public List<Long> getRoleIds() {
        return roleIds;
    }

    public void setRoleIds(List<Long> roleIds) {
        this.roleIds = roleIds;
    }

    public Integer getSalary() {
        return salary;
    }

    public void setSalary(Integer salary) {
        this.salary = salary;
    }

    public Date getEntryTime() {
        return entryTime;
    }

    public void setEntryTime(Date entryTime) {
        this.entryTime = entryTime;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public Integer getSex() {
        return sex;
    }

    public void setSex(Integer sex) {
        this.sex = sex;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmall() {
        return emall;
    }

    public void setEmall(String emall) {
        this.emall = emall;
    }
}
