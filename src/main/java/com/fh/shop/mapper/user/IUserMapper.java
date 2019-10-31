package com.fh.shop.mapper.user;

import com.fh.shop.param.searchUser.UserSearch;
import com.fh.shop.po.resource.Resource;
import com.fh.shop.po.role.Role;
import com.fh.shop.po.user.User;
import com.fh.shop.po.user.UserRole;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface IUserMapper {

    public  void addUser(User user);

    public  Long queryUserCount(UserSearch userSearch);
    public List<User> queryUserList(UserSearch userSearch);

    public  void deleteUserById(Long id);

    public User queryUserById(Long id);

    public void updateUser(User user);

    void addUserRole(UserRole userRole);

    public List<Role> queryUserRole(Long userId);

    public void deleteUserRoleByUserId(Long id);

    void deleteUserBatch(List<Long> arrUserIds);

    void deleteUserRoleBatch(List<Long> arrUserIds);

    User queryUserByUserName(String userName);

    void updateUserOperation(User userObj);


    public List<User> queryUserByFile(User user);

    List<Resource> queryUserResourceByUserId (Long id);

    List<Resource> queryInterceptorsResourceList();

    List<Resource> queryUserMenuByUserId(Long id);

    void updateUserLockDate(@Param("id") Long id,@Param("date") Date date);

    void updateUserErrorJJ(@Param("id") Long id,@Param("date") Date date);

    void updateUserErrorCount(Long id);

    void updateUserIsLock(@Param("id") Long id,@Param("errorCount") Long errorCount);

    void UpdatePassword(@Param("id") Long id,@Param("young") String young);

    void resetPassword(@Param("v")Long id,@Param("password") String password);

    User byTextContentFindUser(String findMail);
}
