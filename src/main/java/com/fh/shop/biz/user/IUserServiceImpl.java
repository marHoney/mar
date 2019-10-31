package com.fh.shop.biz.user;

import com.fh.shop.common.DateTableResult;
import com.fh.shop.common.MyCtrlResponseView;
import com.fh.shop.common.MyEnum;
import com.fh.shop.common.MyFinals;
import com.fh.shop.mapper.user.IUserMapper;
import com.fh.shop.param.searchUser.UserSearch;
import com.fh.shop.po.resource.Resource;
import com.fh.shop.po.role.Role;
import com.fh.shop.po.user.User;
import com.fh.shop.po.user.UserRole;
import com.fh.shop.utils.DateTool;
import com.fh.shop.utils.MailUtils;
import com.fh.shop.utils.Md5Util;
import com.fh.shop.vo.user.UserVo;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service("userService")
public class IUserServiceImpl implements IUserService {
    @Autowired
    private IUserMapper userMapper;



    @Override
    public void addUser(User user) {
        user.setPassword(Md5Util.md5(user.getPassword()));
        userMapper.addUser(user);
        System.out.println(user.getId());
        addUserRole(user);
    }


    /* 添加用戶角色的中間表  公共方法 */
    private void addUserRole(User user) {
        Long id = user.getId();
        List<Long> roleIds = user.getRoleIds();
        for (int i = 0; i < roleIds.size(); i++) {
            UserRole userRole = new UserRole();
            userRole.setUserId(id);
            userRole.setRoleId(roleIds.get(i));
            userMapper.addUserRole(userRole);
        }
    }

    @Override
    public DateTableResult queryUserList(UserSearch userSearch) {
        List roleIdsList = userSearch.getRoleIds();
        if (roleIdsList != null && roleIdsList.size()>0) {
            userSearch.setRoleIds(roleIdsList);
            userSearch.setRoleIdsSize(roleIdsList.size());
        }
        Long aLong = userMapper.queryUserCount(userSearch);
        List<UserVo> userVos = getUserPoZRoleVo(userSearch);
        DateTableResult dateTableResult = new DateTableResult(userSearch.getDraw(),aLong,aLong,userVos);
        return dateTableResult;
    }

    private List<UserVo> getUserPoZRoleVo(UserSearch userSearch) {
        List<UserVo> userVos = new ArrayList<>();
        List<User> userList = userMapper.queryUserList(userSearch);
        for (User u : userList) {
            UserVo userVo = bulidUserVo(u);
            userVos.add(userVo);
            Long id = u.getId();
            List<Role> roleNameStrList = userMapper.queryUserRole(id);
            if(roleNameStrList!= null && roleNameStrList.size()>0){
                StringBuffer temp = new StringBuffer();
                    for (Role roleName : roleNameStrList) {
                        if(roleName.getRoleName() != null && roleName.getId() != null){
                            temp.append(roleName.getRoleName()+",");
                        }
                }
                     temp.substring(0,temp.length()-1);
                    userVo.setRoleNames(temp.toString());
                }
        }
        return userVos;
    }

    /* po 轉  vo 的 公共方法 */
    private UserVo bulidUserVo(User u) {
        UserVo userVo=new UserVo();
        userVo.setId(u.getId());
        userVo.setUserName(u.getUserName());
        userVo.setRealName(u.getRealName());
        userVo.setAge(u.getAge());
        userVo.setSex(u.getSex());
        userVo.setPhone(u.getPhone());
        userVo.setEmall(u.getEmall());
        userVo.setSalary(u.getSalary());
        userVo.setEntryTime(DateTool.setTimeStr(u.getEntryTime(),DateTool.N_Y_R));
        userVo.setLock(u.getErrorCount() == MyFinals.LOG_USER_PASSWORD_ERROR);
        return userVo;
    }

    @Override
    public void deleteUserById(Long id) {
        userMapper.deleteUserById(id);
        userMapper.deleteUserRoleByUserId(id);
    }

    /* 回顯用戶 查詢角色 id */
    @Override
    public UserVo queryUserById(Long id) {
        User user = userMapper.queryUserById(id);
        UserVo userVo = bulidUserVo(user);

        List<Role> roleIds = userMapper.queryUserRole(id);
        if(roleIds != null && roleIds.size()>0){
            for (Role roleId : roleIds) {
                Long id1 = roleId.getId();
                userVo.getRoleIds().add(id1);
            }
        }
        return userVo;

    }

    @Override
    public void updateUser(User user) {
        Long id = user.getId();
        userMapper.deleteUserRoleByUserId(id);
        if(user.getRoleIds() != null){
            addUserRole(user);
        }

        user.setPassword(Md5Util.md5(user.getPassword()));
        userMapper.updateUser(user);

    }

    @Override
    public void deleteUserBatch(List<Long> arrUserIds) {
        userMapper.deleteUserBatch(arrUserIds);
        userMapper.deleteUserRoleBatch(arrUserIds);

    }

    @Override
    public User queryUserByUserName(String userName) {
        User name= userMapper.queryUserByUserName(userName);
        return name;
    }

    @Override
    public void updateUserOperation(User userObj) {
        userMapper.updateUserOperation(userObj);
    }

    public List<User> queryUserByFile(User user){
             return userMapper.queryUserByFile(user);
    }

    @Override
    public List<Resource> queryUserResourceByUserId(Long id) {
        List<Resource> resourceList= userMapper.queryUserResourceByUserId(id);
        return resourceList;
    }

    @Override
    public List<Resource> queryInterceptorsResourceList() {
        List<Resource>  queryInterceptorsResourceList= userMapper.queryInterceptorsResourceList();
        return queryInterceptorsResourceList;
    }

    @Override
    public List<Resource> queryUserMenuByUserId(Long id) {
        List<Resource> queryUserMenuByUserId = userMapper.queryUserMenuByUserId(id);
        return queryUserMenuByUserId;
    }

    @Override
    public void updateUserLockDate(Long id, Date date) {
        userMapper.updateUserLockDate(id,date);
    }

    @Override
    public void updateUserErrorJJ(Long id, Date date) {
        userMapper.updateUserErrorJJ(id,date);
    }

    @Override
    public void updateUserErrorCount(Long id) {
        userMapper.updateUserErrorCount(id);
    }

    @Override
    public void updateUserLock(Long id,Long errorCount) {
        userMapper.updateUserIsLock(id,errorCount);
    }


    @Override
    public MyCtrlResponseView updatePassword(Long id,String oldPassword, String youngPassword, String surePassword) {
        User user = userMapper.queryUserById(id);
        if(oldPassword.isEmpty() || youngPassword.isEmpty() || surePassword.isEmpty() ){
                  return MyCtrlResponseView.error(MyEnum.UPDATE_PASSWORD_IS_NULL);
          }
          //判斷原密碼 是否相等
        String password = user.getPassword();//數據庫的密碼
        String old = Md5Util.md5(oldPassword);//輸入的舊密碼
        if(!password.equals(old)){
            return MyCtrlResponseView.error(MyEnum.UPDATE_PASSWORD_IS_FALSE);
        }
        //判斷 新密碼不能和 老密碼一致
        if(youngPassword.equals(oldPassword)){
            return MyCtrlResponseView.error(MyEnum.UPDATE_PASSWORD_IS_OLD_YOUNG_ERROR);
        }

        //判斷 新密碼 和確認密碼是否相等
        if(!youngPassword.equals(surePassword)){
            return MyCtrlResponseView.error(MyEnum.UPDATE_PASSWORD_IS_OLD_SURE_ERROR);
        }
        String young = Md5Util.md5(youngPassword);//輸入的新密碼
        //獲取當前登陸的 用戶Id
        userMapper.UpdatePassword(id,young);
        return MyCtrlResponseView.success();
    }

    @Override
    public MyCtrlResponseView resetPassword(Long id) {
        //重置密碼
        User user = userMapper.queryUserById(id);
        if(user==null){
            return  MyCtrlResponseView.error( MyEnum.USERNAME_NO_EXIST);
        }
        String password=Md5Util.md5(MyFinals.RESET_PASSWORD);
        userMapper.resetPassword(id,password);
        return MyCtrlResponseView.success();
    }

    @Override
    public MyCtrlResponseView updateFindPasswordMail(String findMail) {
        if(!StringUtils.isNotEmpty(findMail)){
            return MyCtrlResponseView.error(MyEnum.MAIL_IS_NULL);
        }
        User user= userMapper.byTextContentFindUser(findMail);
        if(user == null){
            return MyCtrlResponseView.error(MyEnum.CONTENT_IS_NULL);
        }
        String password = RandomStringUtils.randomAlphanumeric(6);
        String psd = Md5Util.md5(password);
        Long id = user.getId();
        userMapper.UpdatePassword(id,psd);
        MailUtils.setSendmail(user.getEmall(),"找回密碼","您的新密碼為:"+password);
        return MyCtrlResponseView.success();
    }


}
