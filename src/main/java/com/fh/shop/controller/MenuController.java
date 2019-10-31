package com.fh.shop.controller;

import com.fh.shop.common.MyCtrlResponseView;
import com.fh.shop.common.MyFinals;
import com.fh.shop.po.resource.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class MenuController {
    @Autowired
    private HttpServletRequest request;

    @RequestMapping("/getUserResource")
    @ResponseBody
    public MyCtrlResponseView getUserResource(){
            List<Resource> attribute = (List<Resource>) request.getSession().getAttribute(MyFinals.JURISDICTION);
            return MyCtrlResponseView.success(attribute);
    }

    @RequestMapping("/jumpGreetJsp")
    public String  jumpGreetJsp(){
        return "greet";
    }

}
