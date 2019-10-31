package com.fh.shop.param.searchBrand;

import com.fh.shop.common.Page;

import java.io.Serializable;

public class BrandSearch extends Page implements Serializable {
    private String brandName;

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }
}
