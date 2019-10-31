<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/8/19
  Time: 22:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Title</title>
    <jsp:include page="/common/commonCSS.jsp"></jsp:include>
    <style>
        .container{
            width: 1500px;
        }

    </style>
</head>
<body style="padding-top: 90px;">
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Fh商品後臺管理系統</a>
        </div>
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav" id="ulId">
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#">上次登錄時間為：<fmt:formatDate value="${user.lasttime}" pattern="yyyy-MM-dd HH-mm-dd"></fmt:formatDate></a></li>
                <li><a href="#">縂次數:${user.loginCount}</a></li>
                <li><a href="#">欢迎<font size="5px;">${user.realName}</font>登录</a></li>
                <li><a href="/user/logout.do"><font size="3px;">注銷</font></a></li>
                <li><a href="#"><font size="3px;"></font></a></li>

            </ul>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>
<script src="/js/jquery-3.3.1.min.js"></script>
<script>
    $(function () {
        getUserResources();
    })
  var resourceData;
  function getUserResources() {
       $.ajax({
           url:"/getUserResource.do",
           type:"post",
           success:function(result) {
               if(result.code ==200){
                   resourceData=result.data;
                   initResource(1,1);
               }
           }
       });
  }
  //level  代表第一級 \  限制
    var html='';
 function initResource(id,level) {
     console.log(resourceData);
     //獲取孩子 ID
     var children= getChildrenId(id);
     if(children.length > 0){
              if(level == 1){
                  html+='';
              }
         for (var i = 0; i < children.length; i++) {

         }
     }
 }
 function getChildrenId(id) {
     var children =[];
     for (var i = 0; i < resourceData.length; i++) {
           if(resourceData[i].pid == id){
               children.push(resourceData[i])
           }
     }
     return children;
 }

</script>
</body>
</html>
