package com.fh.shop.controller.product;

import com.fh.shop.MyAopLogManage.Log;
import com.fh.shop.biz.product.IProductService;
import com.fh.shop.common.DateTableResult;
import com.fh.shop.common.MyCtrlResponseView;
import com.fh.shop.common.ReturnResultMap;
import com.fh.shop.param.searchProduct.ProductSearch;
import com.fh.shop.po.product.Product;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

@Controller
@RequestMapping("/product")
public class ProductController {
    @Resource(name = "productService")
    private IProductService productService;

    @RequestMapping("/jumpProductTable")
    public String jumpProductTable(){
        return "/product/productTable";
    }

    @RequestMapping("/toProductTable")
    public @ResponseBody DateTableResult toProductTable(ProductSearch productSearch){
        DateTableResult dateTableResult = productService.queryProductList(productSearch);
        return dateTableResult;
    }

    @RequestMapping("/addProduct")
    @Log("商品表的增加")
    public @ResponseBody MyCtrlResponseView addProduct(Product product){
            productService.addProduct(product);
            return MyCtrlResponseView.success();
    }

    @RequestMapping("/deleteProduct")
    @Log("商品表的刪除")
    public @ResponseBody MyCtrlResponseView deleteProduct(Long id){
            productService.deleteProduct(id);
            return MyCtrlResponseView.success();
    }

    @RequestMapping("/updateProduct")
    @Log("商品表的修改")
    public @ResponseBody MyCtrlResponseView updateProduct(Product product){
            productService.updateProduct(product);
            return MyCtrlResponseView.success();
    }
    @RequestMapping("/updateProductIsUp")
    @Log("商品表的下架上架")
    public @ResponseBody MyCtrlResponseView updateProductIsUp(Long id,Integer isUp){
        productService.updateProductIsUp(id,isUp);
        return MyCtrlResponseView.success();
    }

}
