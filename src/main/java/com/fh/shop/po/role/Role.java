package com.fh.shop.po.role;

import com.fh.shop.common.Page;

import java.io.Serializable;

public class Role  implements Serializable {
    private Long id;
    private String roleName;

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
