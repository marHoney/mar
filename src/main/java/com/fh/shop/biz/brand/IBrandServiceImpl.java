package com.fh.shop.biz.brand;

import com.fh.shop.common.DateTableResult;
import com.fh.shop.mapper.brand.IBrandMapper;
import com.fh.shop.param.searchBrand.BrandSearch;
import com.fh.shop.po.brand.Brand;
import com.fh.shop.vo.brand.BrandVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("brandService")
public class IBrandServiceImpl implements IBrandService {
    @Autowired
    private IBrandMapper brandMapper;

    @Override
    public void addProduct(Brand brand) {
        brandMapper.addProduct(brand);
    }

    @Override
    public void deleteBrand(Long id) {
        brandMapper.deleteBrand(id);
    }

    @Override
    public void updateBrand(Brand brand) {
        brandMapper.updateBrand(brand);
    }


    @Override
    public DateTableResult dateTableResult(BrandSearch brandSearch) {
        Long brandLong = brandMapper.queryBrandCount(brandSearch);
        List<Brand> brands = brandMapper.queryBrandList(brandSearch);
        List<BrandVo> brandVos = buildBrandPoTurnBrandVo(brands);
        DateTableResult result = new DateTableResult(brandSearch.getDraw(),brandLong,brandLong,brandVos);
        return result;
    }

    private List<BrandVo> buildBrandPoTurnBrandVo(List<Brand> brands) {
        List<BrandVo> brandVos = new ArrayList<>();
        for (Brand brandpo : brands) {
            BrandVo brandVo = new BrandVo();
            brandVo.setId(brandpo.getId());
            brandVo.setBrandName(brandpo.getBrandName());
            brandVo.setBrandPhoto(brandpo.getBrandPhoto());
            brandVos.add(brandVo);
        }
        return brandVos;
    }
}
