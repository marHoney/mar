package com.fh.shop.utils;

import com.fh.shop.common.MyFinals;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.Serializable;
import java.util.Properties;

public   class   MailUtils implements Serializable {


    public static void   setSendmail(String to,String subject,String content){
        Properties prop = new Properties();
        prop.setProperty("mail.host", MyFinals.MAIL_HOST);
        prop.setProperty("mail.transport.protocol", "smtp");
        prop.setProperty("mail.smtp.auth", "true");

        //1、创建session
        Session session = Session.getInstance(prop);
        //2、通过session得到transport对象
        Transport ts = null;
        try {
             ts = session.getTransport();
            //3、使用邮箱的用户名和密码连上邮件服务器，发送邮件时，发件人需要提交邮箱的用户名和密码给smtp服务器，用户名和密码都通过验证之后才能够正常发送邮件给收件人。
            ts.connect(MyFinals.MAIL_HOST, MyFinals.SENDMAIL_USER, MyFinals.SENDMAIL_PASSWORD);
            //4、创建邮件
            //创建邮件对象
            MimeMessage message = new MimeMessage(session);
            //指明邮件的发件人
            message.setFrom(new InternetAddress(MyFinals.SENDMAIL_USER));
            //指明邮件的收件人，现在发件人和收件人是一样的，那就是自己给自己发
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
            //邮件的标题
            message.setSubject(subject);
            //邮件的文本内容
            message.setContent(content, "text/html;charset=UTF-8");
            //5、发送邮件
            ts.sendMessage(message, message.getAllRecipients());

        } catch (MessagingException e) {
            e.printStackTrace();
        } finally {
            if(ts!= null){
                try {
                    ts.close();
                    ts=null;
                } catch (MessagingException e) {
                    e.printStackTrace();
                }
            }
        }
    }


}
