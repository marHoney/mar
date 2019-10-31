package com.fh.shop.biz.logInfo;

import com.fh.shop.common.DateTableResult;
import com.fh.shop.mapper.logInfo.ILogInfoMapper;
import com.fh.shop.param.searchLogInfo.LogInfoSearch;
import com.fh.shop.po.logInfo.LogInfo;
import com.fh.shop.utils.DateTool;
import com.fh.shop.vo.logInfo.LogInfoVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("logInfoService")
public class ILogInfoServiceImpl implements  ILogInfoService {
    @Autowired
    private ILogInfoMapper logInfoMapper;

    @Override
    public DateTableResult queryLogInfoList(LogInfoSearch logInfoSearch) {
        Long aLong = logInfoMapper.queryLogInfoCount(logInfoSearch);
        List<LogInfo> logInfos = logInfoMapper.queryLogInfoList(logInfoSearch);
        List<LogInfoVo> logInfoSearchList = getLogPozVo(logInfos);
        DateTableResult dateTableResult = new DateTableResult(logInfoSearch.getDraw(),aLong,aLong,logInfoSearchList);
        return dateTableResult;
    }

    private List<LogInfoVo> getLogPozVo(List<LogInfo> logInfos) {
        List<LogInfoVo> logInfoSearchList = new ArrayList<>();
        for (LogInfo logInfo : logInfos) {
            LogInfoVo logInfoVo= new LogInfoVo();
            logInfoVo.setId(logInfo.getId());
            logInfoVo.setUserName(logInfo.getUserName());
            logInfoVo.setRealName(logInfo.getRealName());
            logInfoVo.setInfo(logInfo.getInfo());
            logInfoVo.setErrorMsg(logInfo.getErrorMsg());
            logInfoVo.setStatus(logInfo.getStatus());
            logInfoVo.setCurrDate(DateTool.setTimeStr(logInfo.getCurrDate(),DateTool.N_Y_R_S_F_M));
            logInfoVo.setDetail(logInfo.getDetail());
            logInfoVo.setContent(logInfo.getContent());
            logInfoSearchList.add(logInfoVo);
        }
        return logInfoSearchList;
    }

    public void addLogInfo(LogInfo logInfo){
        logInfoMapper.addLogInfo(logInfo);
    }

    @Override
    public void deleteLogInfo(Long id) {
        logInfoMapper.deleteLogInfo(id);
    }
}
