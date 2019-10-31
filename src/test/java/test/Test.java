package test;


import javax.mail.*;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.Serializable;
import java.util.Properties;
import java.util.Timer;
import java.util.TimerTask;

public class Test implements Serializable {




    public static void main(String[] args) {
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
            to = new InternetAddress("1694130645@qq.com");
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
            message.setContent("<h1 style='color:red'>老大好 我是--孫攀龍</h1>", "text/html;charset=UTF-8");
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        // 最后当然就是发送邮件啦
        try {
            Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }


    public static MimeMessage createSimpleMail(Session session) throws Exception {
        // 创建邮件对象
        MimeMessage message = new MimeMessage(session);
        // 指明邮件的发件人
        message.setFrom(new InternetAddress("1737795375@qq.com"));
        // 指明邮件的收件人，现在发件人和收件人是一样的，那就是自己给自己发
        message.setRecipient(Message.RecipientType.TO, new InternetAddress("532028476@qq.com"));
        // 邮件的标题
        message.setSubject("许雪瑞");
        // 邮件的文本内容
        message.setContent("<h1 style='color:red'>老师你好啊，我是许雪瑞</h1>", "text/html;charset=UTF-8");
        // 返回创建好的邮件对象
        return message;
    }

}
