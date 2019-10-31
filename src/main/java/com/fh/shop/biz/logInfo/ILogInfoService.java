package com.fh.shop.biz.logInfo;

import com.fh.shop.common.DateTableResult;
import com.fh.shop.param.searchLogInfo.LogInfoSearch;
import com.fh.shop.po.logInfo.LogInfo;

public interface ILogInfoService {

    public DateTableResult  queryLogInfoList(LogInfoSearch logInfoSearch);

    public void addLogInfo(LogInfo logInfo);

    void deleteLogInfo(Long id);
}
