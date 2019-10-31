package com.fh.shop.vo.role;


import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class RoleVo implements Serializable {
    private Long id;
    private String roleName;
    private List<Long> resourceId=new ArrayList<>();

    public List<Long> getResourceId() {
        return resourceId;
    }

    public void setResourceId(List<Long> resourceId) {
        this.resourceId = resourceId;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

}
