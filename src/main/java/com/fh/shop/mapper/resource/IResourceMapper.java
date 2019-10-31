package com.fh.shop.mapper.resource;

import com.fh.shop.po.resource.Resource;

import java.util.List;

public interface IResourceMapper {
    List<Resource> queryResourceList();

    void addResource(Resource resource);

    void updateResource(Resource resource);

    void deleteResource(List<Long> arr);

    Resource queryUserByID(Long id);


}
