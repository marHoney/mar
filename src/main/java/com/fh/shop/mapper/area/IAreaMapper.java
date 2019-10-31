package com.fh.shop.mapper.area;

import com.fh.shop.po.area.Area;

import java.util.List;

public interface IAreaMapper {

    public List<Area> queryAreaList();

    public void addArea(Area area);

    public void deleteArea(List<Long> arr);

    public void updateArea(Area area);
}
