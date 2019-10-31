package com.fh.shop.biz.product;

import com.fh.shop.common.DateTableResult;
import com.fh.shop.mapper.product.IProductMapper;
import com.fh.shop.param.searchProduct.ProductSearch;
import com.fh.shop.po.product.Product;
import com.fh.shop.utils.DateTool;
import com.fh.shop.vo.product.ProductVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("productService")
public class IProductServiceImpl  implements IProductService {
    @Autowired
    private IProductMapper productMapper;

    @Override
    public DateTableResult queryProductList(ProductSearch productSearch) {
        Long queryPdtCount = productMapper.queryProductCount(productSearch);
        List<Product> productList = productMapper.queryProductList(productSearch);
        List<ProductVo> productVoList = buildPoHVo(productList);
        DateTableResult dateTableResult = new DateTableResult(productSearch.getDraw(),queryPdtCount,queryPdtCount,productVoList);
        return dateTableResult;
    }

    private List<ProductVo> buildPoHVo(List<Product> productList) {
        List<ProductVo> productVoList = new ArrayList<>();
        for (Product product : productList) {

            ProductVo productVo = new ProductVo();
            productVo.setId(product.getId());
            productVo.setPrice(product.getPrice());
            productVo.setProductName(product.getProductName());
            productVo.setProductDate(DateTool.setTimeStr(product.getProductDate(),DateTool.N_Y_R));
            productVo.setProductPhoto(product.getProductPhoto());
            productVo.setProductCount(product.getProductCount());
            productVo.setIsHot(product.getIsHot());
            productVo.setIsUp(product.getIsUp());
            productVoList.add(productVo);
        }
        return productVoList;
    }

    public void addProduct(Product product){
        productMapper.addProduct(product);
    }

    @Override
    public void deleteProduct(Long id) {
        productMapper.deleteProduct(id);
    }

    @Override
    public void updateProduct(Product product) {
        productMapper.updateProduct(product);
    }

    @Override
    public void updateProductIsUp(Long id,Integer isUp) {
        productMapper.updateProductIsUp(id,isUp);
    }
}
