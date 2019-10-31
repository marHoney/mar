package com.fh.shop.controller.resource;

import com.fh.shop.biz.resource.IResourceService;
import com.fh.shop.common.MyCtrlResponseView;
import com.fh.shop.vo.resource.ResourceVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.io.Serializable;
import java.util.List;

@Controller
@RequestMapping("/resource")
public class ResourceController implements Serializable {
    @Resource(name = "resourceService")
    private IResourceService resourceService;

    @RequestMapping("/jumpResourceTable")
    public String jumpResourceTable(){
        return "/resource/resourceTable";
    }

    @RequestMapping("/toResourceTable")
    public @ResponseBody MyCtrlResponseView toResourceTable(){
            List<ResourceVo> result=  resourceService.queryResourceList();
            return  MyCtrlResponseView.success(result);
    }

    @RequestMapping("/addResource")
    public @ResponseBody MyCtrlResponseView addResource(com.fh.shop.po.resource.Resource resource){
            resourceService.addResource(resource);
            return MyCtrlResponseView.success(resource.getId());
    }

    @RequestMapping("/updateResource")
    public @ResponseBody MyCtrlResponseView updateResource(com.fh.shop.po.resource.Resource resource){
            resourceService.updateResource(resource);
            return MyCtrlResponseView.success();
    }

    @RequestMapping("/deleteResource")
    public @ResponseBody MyCtrlResponseView deleteResource(@RequestParam("ids[]") List<Long> arr){
            resourceService.deleteResource(arr);
            return MyCtrlResponseView.success();
    }

    @RequestMapping("/queryUserByID")
    public @ResponseBody MyCtrlResponseView queryUserByID(Long id){
            com.fh.shop.po.resource.Resource resource= resourceService.queryUserByID(id);
            return MyCtrlResponseView.success(resource);
    }


}
