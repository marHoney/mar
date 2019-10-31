<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/28 0028
  Time: 上午 11:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="zh-CN">

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>www.fffhhhh.cooooom</title>
    <jsp:include page="/common/commonCSS.jsp"></jsp:include>
    <link rel="stylesheet" href="/js/jquery-pretty-radio-checkbox/css/jquery-labelauty.css">
<style>
    .container{
        width: 1500px;
    }

    .dropdown-submenu {
        position: relative;
    }

    .dropdown-submenu > .dropdown-menu {
        top: 0;
        left: 100%;
        margin-top: -6px;
        margin-left: -1px;
        -webkit-border-radius: 0 6px 6px 6px;
        -moz-border-radius: 0 6px 6px;
        border-radius: 0 6px 6px 6px;
    }

    .dropdown-submenu:hover > .dropdown-menu {
        display: block;
    }

    .dropdown-submenu > a:after {
        display: block;
        content: " ";
        float: right;
        width: 0;
        height: 0;
        border-color: transparent;
        border-style: solid;
        border-width: 5px 0 5px 5px;
        border-left-color: #ccc;
        margin-top: 5px;
        margin-right: -10px;
    }

    .dropdown-submenu:hover > a:after {
        border-left-color: #fff;
    }

    .dropdown-submenu.pull-left {
        float: none;
    }

    .dropdown-submenu.pull-left > .dropdown-menu {
        left: -100%;
        margin-left: 10px;
        -webkit-border-radius: 6px 0 6px 6px;
        -moz-border-radius: 6px 0 6px 6px;
        border-radius: 6px 0 6px 6px;
    }
</style >
<body style="padding-top: 90px;">
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">飞狐电商后台管理</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div>
            <div class="collapse navbar-collapse" id="iii">
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="#">上次登錄時間為：<fmt:formatDate value="${user.lasttime}" pattern="yyyy-MM-dd HH-mm-dd"></fmt:formatDate></a></li>
                    <li><a href="#">縂次數:${user.loginCount}</a></li>
                    <li><a href="#">欢迎<font size="5px;">${user.realName}</font>登录</a></li>
                    <li><a href="/user/logout.do"><font size="3px;">注銷</font></a></li>
                    <li><a href="/user/UpdatePasswordJsp.do"><font size="3px;">修改密碼</font></a></li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div>
    </div><!-- /.container-fluid -->
</nav>
    <script src="/js/jquery-3.3.1.min.js"></script>
</body>
<script>
    
    $(function () {
        getUserResources();

    })

    $.ajaxSetup({
        complete:function (result) {
            //console.log(result);
            var data=result.responseJSON;
            if(data.code == -100000){
                bootbox.alert({
                    message:data.message,
                    className: 'rubberBand animated'
                });
            }else if(result.code == -1){
                bootbox.alert({
                    message:"操作失敗",
                    className: 'rubberBand animated'
                });
            }
        }
    })

    var resourceData;
    function getUserResources() {
        $.ajax({
            url:"/getUserResource.do",
            type:"post",
            success:function(result) {
                if(result.code ==200){
                    resourceData=result.data;
                    initZtreeData(1,1);
                    $("#iii").append(NavHtml);
                }
            }
        });
    }
    var NavHtml= '';
    function initZtreeData(id,level) {
         var V_ChildrenId= getChildrenId(id);
         if(V_ChildrenId.length > 0){
             // 第一級
             if(level == 1){
                 NavHtml+= '<ul class="nav navbar-nav">';
             }else {
                 NavHtml+= '<ul class="dropdown-menu">';
             }

             for (var i = 0; i < V_ChildrenId.length; i++) {
                 var Mar=V_ChildrenId[i];

                 var hasChildren=hasChildrenId(Mar.id);//true \ false
                 if(level == 1){
                     if(hasChildren){//true  一級 有孩子
                         NavHtml+='<li><a href="#" data-toggle="dropdown">'+Mar.resourceName+'<span class="caret"></span></a>';
                     }else{//false  沒有孩子
                         NavHtml+='<li><a href="'+Mar.resourceUrl+'">'+Mar.resourceName+'</a>';
                     }
                 }else{
                     //console.log(Mar.resourceName)
                    // console.log(hasChildren)
                     if(hasChildren){ //不是 一級 而且 他還有孩子的話
                         NavHtml+='<li class="dropdown-submenu"><a  href="'+Mar.resourceUrl+'">'+Mar.resourceName+'</a>';
                     }else{
                         NavHtml+='<li><a href="'+Mar.resourceUrl+'">'+Mar.resourceName+'</a>';
                     }
                 }
                 initZtreeData(Mar.id,level+1);
                 NavHtml+='</li>';
             }
             NavHtml+='</ul>';
         }

    }
    // 獲取 子數據
    function getChildrenId(id) {
        var ChildrenId=[];
        for (var i = 0; i < resourceData.length; i++) {
            if(resourceData[i].pid == id ){
                ChildrenId.push(resourceData[i])
            }
        }
        return ChildrenId;
    }
    
    function hasChildrenId(id) {
        for (var i = 0; i < resourceData.length; i++) {
            if(resourceData[i].pid == id){
                return true;
            }
        }
        return false;
    }
</script>
</html>



