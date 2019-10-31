package com.fh.shop.biz.resource;

import com.fh.shop.common.DateTableResult;
import com.fh.shop.mapper.resource.IResourceMapper;
import com.fh.shop.po.resource.Resource;
import com.fh.shop.vo.resource.ResourceVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("resourceService")
public class IResourceServiceImpl implements IResourceService {
    @Autowired
    private IResourceMapper resourceMapper;

    @Override
    public List<ResourceVo> queryResourceList() {
        List<Resource> resourcesList= resourceMapper.queryResourceList();
        List<ResourceVo> resourceVoList = buildPoTVo(resourcesList);
        return resourceVoList;
    }

    @Override
    public void addResource(Resource resource) {
        resourceMapper.addResource(resource);
    }

    @Override
    public void updateResource(Resource resource) {
        resourceMapper.updateResource(resource);
    }

    @Override
    public void deleteResource(List<Long> arr) {
        resourceMapper.deleteResource(arr);
    }

    @Override
    public Resource queryUserByID(Long id) {
        Resource resource=  resourceMapper.queryUserByID(id);
        return resource;
    }

    private List<ResourceVo> buildPoTVo(List<Resource> resourcesList) {
        List<ResourceVo> resourceVoList = new ArrayList<>();
        for (Resource resource : resourcesList) {
            ResourceVo resourceVo = new ResourceVo();
            resourceVo.setId(resource.getId());
            resourceVo.setFatherId(resource.getPid());
            resourceVo.setName(resource.getResourceName());
            resourceVoList.add(resourceVo);
        }
        return resourceVoList;
    }
}
