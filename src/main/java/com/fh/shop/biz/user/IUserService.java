package com.fh.shop.biz.user;

import com.fh.shop.common.DateTableResult;
import com.fh.shop.common.MyCtrlResponseView;
import com.fh.shop.param.searchUser.UserSearch;
import com.fh.shop.po.resource.Resource;
import com.fh.shop.po.user.User;
import com.fh.shop.vo.user.UserVo;

import java.util.Date;
import java.util.List;

public interface IUserService {

    public  void addUser(User user);


    public DateTableResult queryUserList(UserSearch userSearch);

    public  void deleteUserById(Long id);

    public UserVo queryUserById(Long id);

    public void updateUser(User user);

    void deleteUserBatch(List<Long> arrUserIds);

    User queryUserByUserName(String userName);

    void updateUserOperation(User userObj);

    public List<User> queryUserByFile(User user);


    List<Resource> queryUserResourceByUserId(Long id);

    List<Resource> queryInterceptorsResourceList();

    List<Resource> queryUserMenuByUserId(Long id);

    void updateUserLockDate(Long id, Date date);

    void updateUserErrorJJ(Long id, Date date);

    void updateUserErrorCount(Long id);

    void updateUserLock(Long id,Long errorCount);

    MyCtrlResponseView updatePassword(Long id,String oldPassword, String youngPassword, String surePassword);

    MyCtrlResponseView resetPassword(Long id);

    MyCtrlResponseView updateFindPasswordMail(String findMail);
}
