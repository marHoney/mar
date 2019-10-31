package com.fh.shop.biz.user;

import com.fh.shop.common.DateTableResult;
import com.fh.shop.param.searchUser.UserSearch;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring/spring-common.xml"})
public class TestUserService extends AbstractJUnit4SpringContextTests {

    /*
    @Resource的作用相当于@Autowired，只不过@Autowired按byType自动注入，而@Resource默认按 byName自动注入罢了
    * */
    @Resource(name = "userService")
    private IUserService userService;


    /*
    * 單元測試  必須沒有返回值  和 參數 否者會報錯
    *
    * 運行需要  @Test   放在一個方法名上就表示 運行該方法 如果放在
    *
    * 其他地方或者類名上  就表示類裏面的全部方法都執行
    * */
    @Test
    public void testDeleteUser(){
        userService.deleteUserById(75l);
    }

    @Test
    public void queryUserList(){
        UserSearch search=new UserSearch();
        search.setDraw(0);
        search.setStart(1);
        search.setLength(5);
        DateTableResult dateTableResult = userService.queryUserList(search);
        System.out.println(dateTableResult);
    }


}
