package com.fh.shop.test;

import java.io.Serializable;

public class Test  implements Serializable {

    public static void main(String[] args) {

        //Test.set(4);
        //System.out.println("two："+Test.foo(6));
    }



    public static int foo(int i) {//使用递归求出第n位数
        if (i <= 0) {
            return 0;
        } else if (i > 0 && i <= 2)
            return 1;
        return foo(i - 1) + foo(i - 2);//??
    }

    public static void set(int s) {//使用for循环求出第n位数
        int a = 1;
        int b = 1;
        int c = 0;
        for (int i = 2; i < s; i++) {
            c = b;
            b = a + b;
            a = c;
            System.out.print(b + " ");
        }
    }


}
