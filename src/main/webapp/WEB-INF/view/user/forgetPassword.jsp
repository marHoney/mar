<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/9/11
  Time: 17:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>忘記密碼</title>
<jsp:include page="/common/commonCSS.jsp"></jsp:include>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading"><center>找回密碼</center></div>
                <div class="panel-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label  class="col-sm-4 control-label">找回密碼</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="Forget_findMail" placeholder="請輸入賬號/郵箱/手機號...找回">
                            </div>
                        </div>
                    </form>
                    <div style="text-align: center">
                        <button class="btn btn-primary" type="button" onclick="findPasswordMail()" ><font class="glyphicon glyphicon-search">找回..</font></button>
                        <button class="btn btn-default" type="reset"> <font class="glyphicon glyphicon-refresh">重置</font></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="/common/commonJS.jsp"></jsp:include>
<script>
    function findPasswordMail() {
             var findMail= $("#Forget_findMail").val();
             $.ajax({
                 url:"/user/findPasswordMail.do",
                 type:"post",
                 data:{"findMail":findMail},
                 success:function (result) {
                     if(result.code == 200){
                         bootbox.alert({
                             message: '密碼找回成功，請查看您的郵箱！',
                             className: 'rubberBand animated'
                         });
                     }
                 }
             });
    }
</script>
</body>
</html>
