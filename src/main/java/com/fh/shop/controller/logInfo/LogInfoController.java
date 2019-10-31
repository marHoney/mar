package com.fh.shop.controller.logInfo;

import com.fh.shop.biz.logInfo.ILogInfoService;
import com.fh.shop.common.DateTableResult;
import com.fh.shop.common.MyCtrlResponseView;
import com.fh.shop.param.searchLogInfo.LogInfoSearch;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

@Controller
@RequestMapping("/logInfo")
public class LogInfoController {

    @Resource(name = "logInfoService")
    private ILogInfoService iLogInfoService;

    @RequestMapping("/jumpLogInfoTable")
    public String jumpLogInfoTable(){
        return "/logInfo/logInfoTable";
    }

    @RequestMapping("/toLogInfoTable")
    public @ResponseBody DateTableResult toLogInfoTable(LogInfoSearch logInfoSearch){
        DateTableResult dateTableResult = iLogInfoService.queryLogInfoList(logInfoSearch);
        return dateTableResult ;
    }

    @RequestMapping("/deleteLogInfo")
    public @ResponseBody MyCtrlResponseView deleteLogInfo(Long id){
        iLogInfoService.deleteLogInfo(id);
        return MyCtrlResponseView.success();
    }
}
