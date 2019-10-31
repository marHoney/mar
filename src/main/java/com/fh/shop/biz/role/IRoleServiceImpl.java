package com.fh.shop.biz.role;

import com.fh.shop.common.DateTableResult;
import com.fh.shop.mapper.role.IRoleMapper;
import com.fh.shop.param.searchRole.RoleSearch;
import com.fh.shop.po.role.Role;
import com.fh.shop.po.role.RoleResource;
import com.fh.shop.po.user.User;
import com.fh.shop.vo.role.RoleVo;
import com.fh.shop.vo.user.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("roleService")
public class IRoleServiceImpl implements IRoleService {
    @Autowired
    private IRoleMapper roleMapper;

    /* user 的複選框查詢 */
    @Override
    public List<Role> queryUserCheckbox() {
        return roleMapper.queryUserCheckbox();
    }



    @Override
    public DateTableResult queryRoleList(RoleSearch roleSearch) {
        Long roleLong = roleMapper.queryRoleCount(roleSearch);
        List<Role> roleList = roleMapper.queryRoleList(roleSearch);
        // 將po 轉vo
        List<RoleVo> roleVoList = buildRoleTurnRoleVo(roleList);
        DateTableResult dateTableResult = new DateTableResult(roleSearch.getDraw(), roleLong, roleLong, roleVoList);
        return dateTableResult;
    }



    private List<RoleVo> buildRoleTurnRoleVo(List<Role> roleList) {
        List<RoleVo> roleVoList = new ArrayList<>();
        for (Role roleInfo : roleList) {
            RoleVo roleVo = new RoleVo();
            roleVo.setId(roleInfo.getId());
            roleVo.setRoleName(roleInfo.getRoleName());
            roleVoList.add(roleVo);
        }
        return roleVoList;
    }

    @Override
    public void addRole(Role role ,List<Long> idsArr) {
        roleMapper.addRole(role);

        List<RoleResource> roleAreaList = AddResourceIdArr(role, idsArr);
        roleMapper.addResourceIdArr(roleAreaList);
    }

    private List<RoleResource> AddResourceIdArr(Role role, List<Long> idsArr) {
        List<RoleResource> roleAreaList=new ArrayList<>();
        for (Long arrids : idsArr) {
            RoleResource roleResource=new RoleResource();
            roleResource.setRoleId(role.getId());
            roleResource.setResourceId(arrids);
            roleAreaList.add(roleResource);
        }
        return roleAreaList;
    }

    @Override
    public void deleteRole(Long id) {
        roleMapper.deleteRole(id);
        roleMapper.deleteUserRole(id);
        roleMapper.deleteRoleResourceId(id);
    }

    @Override
    public void updateUser(Role role,List<Long> idsArr) {
        roleMapper.updateUser(role);

        roleMapper.deleteRoleResourceId(role.getId());

        AddResourceIdArr(role,idsArr);
        List<RoleResource> roleAreaList = AddResourceIdArr(role, idsArr);
        roleMapper.addResourceIdArr(roleAreaList);
    }

    @Override
    public RoleVo queryResourceIdByRoleId(Long roleId) {
       List<Long> roleResourceList= roleMapper.queryResourceIdByRoleId(roleId);
        RoleVo roleVo = new RoleVo();
        roleVo.setResourceId(roleResourceList);
        return roleVo;
    }



}
