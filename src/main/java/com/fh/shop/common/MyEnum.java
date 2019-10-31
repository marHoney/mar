package com.fh.shop.common;

public enum MyEnum {
    USER_IS_LOCK(1005,"您的用戶被鎖定，請明天再來"),
    ERROR_PASSWORD_LOCK(1004,"錯誤次數過的，請明天再來"),
    USERNAME_NO_EXIST(1003,"賬號不存在"),
    PASSWORD_ID_ERROR(1002,"密碼錯誤"),
    USERNAME_IS_EXIST(10001,"賬號以存在"),
    UPDATE_PASSWORD_IS_NULL(10006,"密碼為空"),
    UPDATE_PASSWORD_IS_FALSE(10007,"原密碼不正缺"),
    UPDATE_PASSWORD_OLD_YOUNG_ID_FALSE(10008,"新密碼和舊密碼不一致"),
    UPDATE_PASSWORD_IS_OLD_SURE_ERROR(10009,"確認密碼不一致"),
    UPDATE_PASSWORD_IS_OLD_YOUNG_ERROR(10010,"新密碼和舊密碼不能一樣"),
    MAIL_IS_NULL(10011,"你沒有輸入内容"),
    CONTENT_IS_NULL(10012,"找不到對應的數據，請查看輸入的是否正確"),
    USERNAME_PASSWORD_IS_NULL(1000,"賬號密碼爲空"),
    SUCCESS(200,"OK"),
    ERROR(-1,"ERROR");

    private Integer code;
    private String name;

    MyEnum(Integer code, String name) {
        this.code = code;
        this.name = name;
    }

    public Integer getCode() {
        return code;
    }

    public String getName() {
        return name;
    }
}
