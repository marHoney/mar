package com.fh.shop.mapper.role;

import com.fh.shop.common.DateTableResult;
import com.fh.shop.param.searchRole.RoleSearch;
import com.fh.shop.po.role.Role;
import com.fh.shop.po.role.RoleResource;

import java.util.List;


public interface IRoleMapper {
    public List<Role> queryUserCheckbox();//用戶 複選框查詢

    public Long queryRoleCount(RoleSearch roleSearch);

    public List<Role> queryRoleList(RoleSearch roleSearch);

    public void addRole(Role role);

    public void deleteRole(Long id);

    public void updateUser(Role role);

    void addResourceIdArr(List<RoleResource> roleAreaList);

    List<Long> queryResourceIdByRoleId(Long roleId);

    void deleteRoleResourceId(Long id);

    void deleteUserRoleBatch(List<Long> userId);


    void deleteUserRole(Long id);
}
