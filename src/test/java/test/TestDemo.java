package test;

import org.junit.Test;

import javax.mail.*;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
import java.util.Timer;
import java.util.TimerTask;

public class TestDemo {

    public  TestDemo()
        {
            Timer timer = new Timer();
            int delay = 0;//ms
            int period = 500;//ms
            timer.schedule(new TimerTask() {
                String message = "";
                public void run() {
                    System.out.println("Task running: " + message);
                    message+=message;
                }
            }, delay, period);
        }

   String message="";

    @Test
    public static MimeMessage main() {
        // 创建Properties 类用于记录邮箱的一些属性
        Properties props = new Properties();
        // 表示SMTP发送邮件，必须进行身份验证
        props.put("mail.smtp.auth", "true");
        //此处填写SMTP服务器
        props.put("mail.smtp.host", "smtp.qq.com");
        //端口号，QQ邮箱给出了两个端口，但是另一个我一直使用不了，所以就给出这一个587
        props.put("mail.smtp.port", "587");
        // 此处填写你的账号
        props.put("2102555454", "2102555454@qq.com");
        // 此处的密码就是前面说的16位STMP口令
        props.put("leng0214", "ogbfxpqfybhwbhae");

        // 构建授权信息，用于进行SMTP进行身份验证
        Authenticator authenticator = new Authenticator() {

            protected PasswordAuthentication getPasswordAuthentication() {
                // 用户名、密码
                String userName = props.getProperty("2102555454");
                String password = props.getProperty("leng0214");
                return new PasswordAuthentication(userName, password);
            }
        };
        // 使用环境属性和授权信息，创建邮件会话
        Session mailSession = Session.getInstance(props, authenticator);
        // 创建邮件消息
        MimeMessage message = new MimeMessage(mailSession);
        // 设置发件人
        InternetAddress form = null;
        try {
            form = new InternetAddress(
                    props.getProperty("2102555454"));
        } catch (AddressException e) {
            e.printStackTrace();
        }
        try {
            message.setFrom(form);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        //波波 ：1694130645@qq.com
        //老于：  532028476@qq.com
        // 设置收件人的邮箱
        InternetAddress to = null;
        try {
            to = new InternetAddress("515365327@qq.com");
        } catch (AddressException e) {
            e.printStackTrace();
        }
        try {
            message.setRecipient(Message.RecipientType.TO, to);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        // 设置邮件标题
        try {
            message.setSubject("1902");
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        // 设置邮件的内容体
        try {
            message.setContent("<h1 style='color:red'>!!! mar</h1>", "text/html;charset=UTF-8");

        } catch (MessagingException e) {
            e.printStackTrace();
        }
        // 最后当然就是发送邮件啦
        try {
            Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        new TestDemo();
        return message;

    }


}

