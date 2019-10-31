package com.fh.shop.biz.resource;

import com.fh.shop.po.resource.Resource;
import com.fh.shop.vo.resource.ResourceVo;

import java.util.List;

public interface IResourceService {
    List<ResourceVo> queryResourceList();

    void addResource(Resource resource);

    void updateResource(Resource resource);

    void deleteResource(List<Long> arr);

    Resource queryUserByID(Long id);

}
