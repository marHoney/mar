package com.fh.shop.biz.area;

import com.fh.shop.mapper.area.IAreaMapper;
import com.fh.shop.po.area.Area;
import com.fh.shop.vo.area.AreaVo;
import com.qcloud.cos.model.Tier;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("areaService")
public class IAreaServiceImpl implements IAreaService {
    @Autowired
    private IAreaMapper areaMapper;

    @Override
    public List<AreaVo> queryAreaList() {
        List<Area> areaPoList = areaMapper.queryAreaList();
        List<AreaVo> areaVoList = getAreaPoZVo(areaPoList);
        return areaVoList;
    }
   //地區Po 轉  Vo
    private List<AreaVo> getAreaPoZVo(List<Area> areaPoList) {
        List<AreaVo> areaVoList= new ArrayList<>();
        for (Area areavos : areaPoList) {
            AreaVo areaVo = new AreaVo();
            areaVo.setId(areavos.getId());
            areaVo.setFatherId(areavos.getPid());
            areaVo.setName(areavos.getAreaName());
            areaVoList.add(areaVo);
        }
        return areaVoList;
    }

    @Override
    public void addArea(Area area) {
        areaMapper.addArea(area);
    }

    @Override
    public void deleteArea(List<Long> arr) {
        areaMapper.deleteArea(arr);
    }


    @Override
    public void updateArea(Area area) {
        areaMapper.updateArea(area);
    }


}
