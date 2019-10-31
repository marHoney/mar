<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/9/10
  Time: 21:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改密碼</title>
    <jsp:include page="/common/commonCSS.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/common/test.jsp"></jsp:include>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading"><center>修改密碼</center></div>
                <div class="panel-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label  class="col-sm-4 control-label">請輸入原密碼</label>
                            <div class="col-sm-6">
                                <input type="password" class="form-control" id="Update_oldPassword" placeholder="oldPassword...">
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-4 control-label">請輸入新密碼</label>
                            <div class="col-sm-6">
                                <input type="password" class="form-control" id="Update_youngPassword" placeholder="youngPassword...">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-4 control-label">請確認新密碼</label>
                            <div class="col-sm-6">
                                <input type="password" class="form-control" id="Update_surePassword" placeholder="surePassword...">
                            </div>
                        </div>
                        <div style="text-align: center">
                            <button class="btn btn-primary" type="button" onclick="updatePasswordSure()" ><font class="glyphicon glyphicon-search">確定</font></button>
                            <button class="btn btn-default" type="reset"> <font class="glyphicon glyphicon-refresh">重置</font></button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="/common/commonJS.jsp"></jsp:include>
</body>
<script src="/js/jquery-3.3.1.min.js"></script>
<script>


    function updatePasswordSure() {
        var flag=true;
        var id='${user.id}';
        var oldPassword= $("#Update_oldPassword").val();
        var youngPassword= $("#Update_youngPassword").val();
        var surePassword= $("#Update_surePassword").val();
        if(oldPassword =="" ){
            bootbox.alert({
                size: "small",
                title: "Your Title",
                message: "Your message here…",
            });
           return flag=false;
        }
        if(youngPassword == ""){
            bootbox.alert({
                message:"新密碼爲空",
                className: 'rubberBand animated'
            });
            return flag=false;
        }
        if(surePassword == ""){
            bootbox.alert({
                message:"確認密碼爲空",
                className: 'rubberBand animated'
            });
            return flag=false;
        }
        if( youngPassword != surePassword ){
            bootbox.alert({
                message:"確認密碼不一致",
                className: 'rubberBand animated'
            });
            return flag=false;
        }
        $.ajax({
            url:"/user/UpdatePassword.do",
            type:"post",
            data:{"id":id,"oldPassword":oldPassword,"youngPassword":youngPassword,"surePassword":surePassword},
            success:function (result) {
                console.log(result)
                if(result.code == 200){
                    bootbox.alert({
                        message:"密碼修改成功！請從新登陸！！！",
                        className: 'rubberBand animated'
                    });
                    $("#Update_oldPassword").val("");
                    $("#Update_youngPassword").val("");
                    $("#Update_surePassword").val("");
                }
            }
        });

    }
</script>
</html>
