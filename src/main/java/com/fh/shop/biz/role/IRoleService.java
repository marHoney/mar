package com.fh.shop.biz.role;

import com.fh.shop.common.DateTableResult;
import com.fh.shop.param.searchRole.RoleSearch;
import com.fh.shop.po.role.Role;
import com.fh.shop.vo.role.RoleVo;

import java.util.List;


public interface IRoleService {

    public List<Role> queryUserCheckbox();//用戶 複選框查詢

    public DateTableResult queryRoleList(RoleSearch roleSearch);

    public void addRole(Role role,List<Long> idsArr);

    public void deleteRole(Long id);

    public void updateUser(Role role,List<Long> idsArr);

    RoleVo queryResourceIdByRoleId(Long roleId);

}
