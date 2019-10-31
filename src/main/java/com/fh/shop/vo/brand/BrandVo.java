package com.fh.shop.vo.brand;

import java.io.Serializable;

public class BrandVo implements Serializable {
    private  Long id;
    private  String brandName;
    private  String brandPhoto;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
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
