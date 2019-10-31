package com.fh.shop.param.searchRole;

import com.fh.shop.common.Page;

import java.io.Serializable;

public class RoleSearch extends Page implements Serializable {
    private String roleName;

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }
}
