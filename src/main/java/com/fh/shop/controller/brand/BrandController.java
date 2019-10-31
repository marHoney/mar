package com.fh.shop.controller.brand;

import com.fh.shop.biz.brand.IBrandService;
import com.fh.shop.common.DateTableResult;
import com.fh.shop.common.MyCtrlResponseView;
import com.fh.shop.param.searchBrand.BrandSearch;
import com.fh.shop.po.brand.Brand;
import com.fh.shop.utils.FileUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/brand")
public class BrandController {
    @Resource(name = "brandService")
    private IBrandService brandService;

    @RequestMapping("/jumpBrandTable")
    public String jumpBrandTable(){
        return "/brand/brandTable";
    }

    @RequestMapping("/toBrandTable")
    public @ResponseBody DateTableResult toBrandTable(BrandSearch brandSearch){
            DateTableResult result = brandService.dateTableResult(brandSearch);
            return result;
    }

    @RequestMapping("/addBrandFileInput")
    @ResponseBody
    public Map addBrandFileInput(@RequestParam("ff") CommonsMultipartFile file){
        Map map = FileUtil.fileInput(file);
        return map;
    }

    @RequestMapping("/addBrand")
    public @ResponseBody MyCtrlResponseView addBrand(Brand brand){
            brandService.addProduct(brand);
            return  MyCtrlResponseView.success();
    }

    @RequestMapping("/deleteBrand")
    public @ResponseBody MyCtrlResponseView deleteBrand(Long id){
            brandService.deleteBrand(id);
            return MyCtrlResponseView.success();
    }

    @RequestMapping("/UpdateBrand")
    public  @ResponseBody  MyCtrlResponseView UpdateBrand(Brand brand){
            brandService.updateBrand(brand);
            return  MyCtrlResponseView.success();
    }


}
