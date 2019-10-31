package com.fh.shop.controller.user;

import com.fh.shop.MyAopLogManage.Log;
import com.fh.shop.MyException.MyExceptions;
import com.fh.shop.biz.user.IUserService;
import com.fh.shop.common.DateTableResult;
import com.fh.shop.common.MyCtrlResponseView;
import com.fh.shop.common.MyEnum;
import com.fh.shop.common.MyFinals;
import com.fh.shop.param.searchUser.UserSearch;
import com.fh.shop.po.user.User;
import com.fh.shop.utils.DateTool;
import com.fh.shop.utils.MailUtils;
import com.fh.shop.utils.Md5Util;
import com.fh.shop.vo.user.UserVo;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
@RequestMapping("user")
public class UserController {
    @Resource(name="userService")
    private IUserService userService;
    @Autowired
    private HttpServletRequest request;


    @RequestMapping("/login")
    @ResponseBody
    public MyCtrlResponseView login(User user){
        System.out.println("==================登陸");
        Date time = new Date();
        String nowTimeStr=DateTool.setTimeStr(time,DateTool.N_Y_R);//把當前時間轉爲 字符串
        Date newDate = DateTool.setTimeDate(DateTool.setTimeStr(time, DateTool.N_Y_R), DateTool.N_Y_R);//把當前時間轉爲 字符串

        String userName = user.getUserName();
        String password = user.getPassword();
        if(userName == null ||  password==null){
            return  MyCtrlResponseView.error(MyEnum.USERNAME_PASSWORD_IS_NULL);
        }
        //查詢 用戶的 信息
       User userObj= userService.queryUserByUserName(userName);
       if( userObj == null){
             return  MyCtrlResponseView.error(MyEnum.USERNAME_NO_EXIST);
        }
        //密碼輸入  最後錯誤de時間
        Date lockTime = DateTool.setTimeDate(DateTool.setTimeStr(userObj.getLockDate(), DateTool.N_Y_R), DateTool.N_Y_R);
        if(userObj.getErrorCount() == MyFinals.LOG_USER_PASSWORD_ERROR){
            if(newDate.after(lockTime)){
                   userService.updateUserErrorCount(userObj.getId());
            }else{
                return MyCtrlResponseView.error(MyEnum.USER_IS_LOCK);
            }
        }
        // 密碼
        if( !Md5Util.md5(password).equals(userObj.getPassword())){
            //判單 一天内 密碼連續輸錯 3 此  就鎖定
            //第一次 時間爲空
            if(userObj.getLockDate() == null  ){
                //設置為當前時間  錯誤次數加1
                userService.updateUserLockDate(userObj.getId(),time);
            }else{//時間不爲空
                // 今天 和  明天的 對比
                if(newDate.after(lockTime)){
                    userService.updateUserLockDate(userObj.getId(),time);
                }else{
                    // 錯誤次數加加
                    if(userObj.getErrorCount() == MyFinals.LOG_USER_PASSWORD_ERROR-1){
                        MailUtils.setSendmail(userObj.getEmall(),"關於您的賬號","你的賬號密碼輸入錯誤次數過多，已被鎖定/請聯係。。。。");
                    }
                    userService.updateUserErrorJJ(userObj.getId(),time);
                }
            }
            return MyCtrlResponseView.error(MyEnum.PASSWORD_ID_ERROR);
        }


        //登陸成功 錯誤次數 重置
        userService.updateUserErrorCount(userObj.getId());
         //上次登錄時間
        userObj.setLasttime(userObj.getLogintime());
        userService.updateUserOperation(userObj);
        //判斷 這次登陸時  是否過了  00：00 點 入夥超過了 00:00 點 就刷新為0
        String timeStr=DateTool.setTimeStr(userObj.getLasttime(),DateTool.N_Y_R);
        System.out.println(timeStr);
        if(nowTimeStr.equals(timeStr)){//每天登陸 多少次  到凌晨 就 從新 計算
            userObj.setLoginCount(userObj.getLoginCount()+1);
        }else{
            userObj.setLoginCount(1l);
        }

            userObj.setLogintime(time);
        //保存用戶信息  後面前臺用到 就是 展示用戶的登陸次數，用戶名，上次登錄時間
        userService.updateUserOperation(userObj);
        //根據用戶ID  查詢這個用戶 擁有  菜單權限  然後在權限 攔截器中做判斷
        List<com.fh.shop.po.resource.Resource> resourcesList= userService.queryUserResourceByUserId(userObj.getId());
        //獲取 菜單的 所有信息
        List<com.fh.shop.po.resource.Resource> interceptorsResourceList =userService.queryInterceptorsResourceList();
        //根據用戶ID 查詢用戶是否  擁有  按鈕權限
        List<com.fh.shop.po.resource.Resource> menuList= userService.queryUserMenuByUserId(userObj.getId());
        //用戶信息
        request.getSession().setAttribute(MyFinals.LANDING_USER_KEY,userObj);
        //菜單  信息
        request.getSession().setAttribute(MyFinals.JURISDICTION,resourcesList);
        //資源 \ 菜單  的集合
        request.getSession().setAttribute(MyFinals.INTERCEPTORS_RESOURCE_LIST,interceptorsResourceList);
        //按鈕 信息
        request.getSession().setAttribute(MyFinals.INTERCEPTORS_MENU_LIST,menuList);
        return MyCtrlResponseView.success();
    }

    @RequestMapping("/logout")
    public String  logout(){
        request.getSession().invalidate();
        return "redirect:/index.jsp";
    }


    @RequestMapping("/addUser")
    @ResponseBody
    @Log("用戶表的增加")
    public MyCtrlResponseView addUser(User user){
            userService.addUser(user);
            return MyCtrlResponseView.success();
    }

    @RequestMapping("/jumpUserTable")
    public String jumpUserTable(){
        return "/user/userTable";
    }

    @RequestMapping("/toUserTable")
    @ResponseBody
    public DateTableResult toUserTable(UserSearch userSearch){
        DateTableResult dateTableResult = userService.queryUserList(userSearch);
        return dateTableResult;
    }

    @RequestMapping("/deleteUserById")
    @ResponseBody
    @Log("用戶表的刪除")
    public  MyCtrlResponseView deleteUserById(Long id){
            userService.deleteUserById(id);
            return MyCtrlResponseView.success();
    }

    @RequestMapping("/queryUserById")
    @ResponseBody
    public MyCtrlResponseView queryUserById(Long id){
            UserVo users = userService.queryUserById(id);
           return  MyCtrlResponseView.success(users);
    }

    @RequestMapping("/updateUser")
    @ResponseBody
    @Log("用戶表的修改")
    public MyCtrlResponseView updateUser(User user){
            userService.updateUser(user);
            return MyCtrlResponseView.success();
    }

    @RequestMapping("/deleteUserBatch")
    @Log("用戶表的批量刪除")
    public @ResponseBody MyCtrlResponseView deleteUserBatch(@RequestParam("arrIds[]") List<Long> arrUserIds){
            userService.deleteUserBatch(arrUserIds);
            return MyCtrlResponseView.success();
    }
    @RequestMapping("/updateUserLock")
    @Log("修改了 賬戶的狀態")
    public @ResponseBody MyCtrlResponseView updateUserLock(Long id,Long errorCount){
        userService.updateUserLock(id,errorCount);
        return MyCtrlResponseView.success();
    }

    @RequestMapping("/UpdatePasswordJsp")
    public String UpdatePasswordJsp(){
      return "user/updatePassword";
    }

    @RequestMapping("/UpdatePassword")
    @Log("修改了密碼")
    public @ResponseBody MyCtrlResponseView UpdatePassword(Long id,String oldPassword,String youngPassword,String surePassword){
        return userService.updatePassword(id,oldPassword,youngPassword,surePassword);
    }

    @RequestMapping("/resetPassword")
    @Log("重置了密碼")
    public @ResponseBody MyCtrlResponseView resetPassword(Long id){
        return   userService.resetPassword(id);
    }

    @RequestMapping("/jumpUpdatePasswordJsp")
    public String jumpUpdatePasswordJsp(){
        return "/user/forgetPassword";
    }

    @RequestMapping("/findPasswordMail")
    public @ResponseBody MyCtrlResponseView findPasswordMail(String findMail){
        return userService.updateFindPasswordMail(findMail);
    }


}
