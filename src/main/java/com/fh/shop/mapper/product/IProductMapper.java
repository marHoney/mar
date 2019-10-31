package com.fh.shop.mapper.product;

import com.fh.shop.param.searchProduct.ProductSearch;
import com.fh.shop.po.product.Product;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IProductMapper {

    public List<Product> queryProductList(ProductSearch productSearch);

    public  void addProduct(Product product);

    public  void deleteProduct(Long id);

    public void updateProduct(Product product);

    public Long queryProductCount(ProductSearch productSearch);

    void updateProductIsUp(@Param("id") Long id,@Param("isUp") Integer isUp);
}
