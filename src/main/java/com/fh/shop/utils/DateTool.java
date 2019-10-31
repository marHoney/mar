package com.fh.shop.utils;

import javax.xml.crypto.Data;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;


public class DateTool {
    public static final String N_Y_R = "yyyy-MM-dd";
    public static final String N_Y_R_S_F_M = "yyyy-MM-dd HH-mm-ss";
    public static String setTimeStr(Date time , String param){
        if(time ==  null){
            return  "";
        }
            SimpleDateFormat sim = new SimpleDateFormat(param);
            String timeStr = sim.format(time);
            return  timeStr;

    }
    public static Date setTimeDate(String time ,String param)  {
        if (time ==null){
        }
        SimpleDateFormat sim = new SimpleDateFormat(param);
        Date timeDa = null;
        try {
            timeDa = sim.parse(time);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return  timeDa;
    }


}
