package com.fh.shop.controller.area;

import com.fh.shop.biz.area.IAreaService;
import com.fh.shop.common.MyCtrlResponseView;
import com.fh.shop.common.ReturnResultMap;
import com.fh.shop.po.area.Area;
import com.fh.shop.vo.area.AreaVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/area")
public class AreaController {
    @Resource(name = "areaService")
    private IAreaService areaService;

    @RequestMapping("/jumpAreaList")
    public String jumpAreaList(){
        return  "/area/areaTable";
    }

    @RequestMapping("/queryAreaList")
    @ResponseBody
    public MyCtrlResponseView queryAreaList(){
            List<AreaVo> areaList = areaService.queryAreaList();
            return MyCtrlResponseView.success(areaList);
    }

    @RequestMapping("/addArea")
    @ResponseBody
    public MyCtrlResponseView addArea (Area area){
            areaService.addArea(area);
            return MyCtrlResponseView.success();
    }

    @RequestMapping("/deleteArea")
    @ResponseBody
    public MyCtrlResponseView deleteArea(@RequestParam("idss[]") List<Long> arr){
            areaService.deleteArea(arr);
            return MyCtrlResponseView.success();
    }

    @RequestMapping("/updateArea")
    @ResponseBody
    public MyCtrlResponseView updateArea(Area area){
            areaService.updateArea(area);
            return MyCtrlResponseView.success();
    }

}
