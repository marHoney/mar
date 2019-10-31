package com.fh.shop.biz.brand;

import com.fh.shop.common.DateTableResult;
import com.fh.shop.param.searchBrand.BrandSearch;
import com.fh.shop.po.brand.Brand;

public interface IBrandService {
    public void addProduct(Brand brand);

    public void deleteBrand(Long id);

    public void updateBrand(Brand brand);

    public DateTableResult dateTableResult(BrandSearch brandSearch);
}
