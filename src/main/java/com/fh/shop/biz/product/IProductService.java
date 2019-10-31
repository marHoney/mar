package com.fh.shop.biz.product;

import com.fh.shop.common.DateTableResult;
import com.fh.shop.param.searchProduct.ProductSearch;
import com.fh.shop.po.product.Product;


public interface IProductService {

    DateTableResult queryProductList(ProductSearch productSearch);

    void addProduct(Product product);

    void deleteProduct(Long id);

    void updateProduct(Product product);

    void updateProductIsUp(Long id,Integer isUp);
}
