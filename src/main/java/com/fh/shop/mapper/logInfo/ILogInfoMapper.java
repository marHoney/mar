package com.fh.shop.mapper.logInfo;

import com.fh.shop.param.searchLogInfo.LogInfoSearch;
import com.fh.shop.po.logInfo.LogInfo;

import java.util.List;

public interface ILogInfoMapper {

     List<LogInfo> queryLogInfoList(LogInfoSearch logInfoSearch);

     Long queryLogInfoCount(LogInfoSearch logInfoSearch);

     void  addLogInfo(LogInfo logInfo);

    void deleteLogInfo(Long id);
}
