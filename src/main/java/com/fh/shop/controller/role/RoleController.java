package com.fh.shop.controller.role;

import com.fh.shop.MyAopLogManage.Log;
import com.fh.shop.biz.role.IRoleService;
import com.fh.shop.common.DateTableResult;
import com.fh.shop.common.MyCtrlResponseView;
import com.fh.shop.param.searchRole.RoleSearch;
import com.fh.shop.po.role.Role;
import com.fh.shop.vo.role.RoleVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/role")
public class RoleController {
    @Resource(name = "roleService")
    private IRoleService roleService;

    @RequestMapping("/jumpRoleTable")
    public String jumpUserTable(){
        return "/role/roleTable";
    }

    @RequestMapping("/toRoleTable")
    public  @ResponseBody DateTableResult toRoleTable(RoleSearch roleSearch){
        DateTableResult dateTableResult = roleService.queryRoleList(roleSearch);
        return dateTableResult;
    }

     /*  user 的 複選框 查詢 */
    @RequestMapping("/queryUserCheckbox")
    public   @ResponseBody MyCtrlResponseView queryUserCheckbox(){
            List<Role> roleList = roleService.queryUserCheckbox();
            return MyCtrlResponseView.success(roleList);
    }

    @RequestMapping("/addRole")
    @Log("角色表的增加")
    public @ResponseBody MyCtrlResponseView addRole(Role role , @RequestParam("idsArr[]") List<Long> idsArr){
            roleService.addRole(role ,idsArr);
            return MyCtrlResponseView.success();
    }

   @RequestMapping("/deleteRole")
   @Log("角色表的刪除")
    public @ResponseBody MyCtrlResponseView deleteRole(Long id){
            roleService.deleteRole(id);
            return  MyCtrlResponseView.success();
    }

    @RequestMapping("/updateRole")
    @Log("角色表的修改")
    public @ResponseBody MyCtrlResponseView updateRole(Role role,@RequestParam("idsArr[]") List<Long> idsArr){
            roleService.updateUser(role,idsArr);
            return MyCtrlResponseView.success();
    }

    @RequestMapping("/queryResourceIdByRoleId")
    @ResponseBody
    public MyCtrlResponseView queryResourceIdByRoleId (Long roleId){
             RoleVo roleVos= roleService.queryResourceIdByRoleId(roleId);
             return MyCtrlResponseView.success(roleVos);
    }

}
