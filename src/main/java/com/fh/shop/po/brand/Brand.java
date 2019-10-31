package com.fh.shop.po.brand;


import java.io.Serializable;

public class Brand   implements Serializable {
    private  long id;
    private String brandName;
    private String brandPhoto;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getBrandPhoto() {
        return brandPhoto;
    }

    public void setBrandPhoto(String brandPhoto) {
        this.brandPhoto = brandPhoto;
    }
}
