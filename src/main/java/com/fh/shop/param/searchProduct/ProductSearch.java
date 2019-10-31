package com.fh.shop.param.searchProduct;

import com.fh.shop.common.Page;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

public class ProductSearch extends Page implements Serializable {

    private String productName;
    private Double minPrice;
    private Double maxPrice;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date minProductDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date maxProductDate;

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Double getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(Double minPrice) {
        this.minPrice = minPrice;
    }

    public Double getMaxPrice() {
        return maxPrice;
    }

    public void setMaxPrice(Double maxPrice) {
        this.maxPrice = maxPrice;
    }

    public Date getMinProductDate() {
        return minProductDate;
    }

    public void setMinProductDate(Date minProductDate) {
        this.minProductDate = minProductDate;
    }

    public Date getMaxProductDate() {
        return maxProductDate;
    }

    public void setMaxProductDate(Date maxProductDate) {
        this.maxProductDate = maxProductDate;
    }
}
