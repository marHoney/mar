package com.fh.shop.MyException;

import com.fh.shop.common.MyCtrlResponseView;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

@ControllerAdvice
public class MyExceptions {
    @ExceptionHandler(Exception.class)
    @ResponseBody
    public static MyCtrlResponseView exception(Exception ex){
        ex.printStackTrace();
        return   MyCtrlResponseView.error();
    }
}
