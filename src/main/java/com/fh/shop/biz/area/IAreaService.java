package com.fh.shop.biz.area;

import com.fh.shop.po.area.Area;
import com.fh.shop.vo.area.AreaVo;

import java.util.List;

public interface IAreaService {

    public List<AreaVo> queryAreaList();

    public void addArea(Area area);

    public void deleteArea(List<Long> arr);

    public void updateArea(Area area);
}
