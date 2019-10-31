package com.fh.shop.mapper.brand;

import com.fh.shop.param.searchBrand.BrandSearch;
import com.fh.shop.po.brand.Brand;

import java.util.List;

public interface IBrandMapper {
    public Long queryBrandCount(BrandSearch brandSearch);

    public List<Brand> queryBrandList(BrandSearch brandSearch);

    public void addProduct(Brand brand);

    public void deleteBrand(Long id);

    public void updateBrand(Brand brand);
}
