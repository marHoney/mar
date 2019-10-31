<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>www.fffhhhh.cooooom</title>
    <jsp:include page="/common/commonCSS.jsp"></jsp:include>
    <style>
        #pattern{
                 margin-left: 600px;
                 margin-top: 60px;
        }
        #titleTop{
            margin-left: 730px;
            margin-top: 50px;
        }
        #button-loginDiv{
            margin-left: 150px;
        }
    </style>
    <style>
        ul { list-style-type: none;}
        li { display: inline-block;}
        li { margin: 0px 0;}
        input.labelauty + label { font: 2px "Microsoft Yahei";}
    </style>
    <script>
        function SetPwdAndChk() {
            //取用户名
            var usr = document.getElementById('Login_userName').value;
            //alert(usr);
            //将最后一个用户信息写入到Cookie
            SetLastUser(usr);
            //如果记住密码选项被选中
            if (document.getElementById('chkRememberPwd').checked == true) {
                //取密码值
                var pwd = document.getElementById('Login_password').value;
                //alert(pwd);
                var expdate = new Date();
                expdate.setTime(expdate.getTime() + 14 * (24 * 60 * 60 * 1000));
                //将用户名和密码写入到Cookie
                SetCookie(usr, pwd, expdate);
            } else {
                //如果没有选中记住密码,则立即过期
                ResetCookie();
            }
        }

        function SetLastUser(usr) {
            var id = "49BAC005-7D5B-4231-8CEA-16939BEACD67";
            var expdate = new Date();
            //当前时间加上两周的时间
            expdate.setTime(expdate.getTime() + 14 * (24 * 60 * 60 * 1000));
            SetCookie(id, usr, expdate);
        }
        //用户名失去焦点时调用该方法
        function GetPwdAndChk() {
            var usr = document.getElementById('Login_userName').value;
            var pwd = GetCookie(usr);
            if (pwd != null) {

                document.getElementById('chkRememberPwd').checked = true;
                document.getElementById('Login_password').value = pwd;
            } else {
                document.getElementById('chkRememberPwd').checked = false;
                document.getElementById('Login_password').value = "";
            }
        }
        //取Cookie的值
        function GetCookie(name) {
            var arg = name + "=";
            var alen = arg.length;
            var clen = document.cookie.length;
            var i = 0;
            while (i < clen) {
                var j = i + alen;
                //alert(j);
                if (document.cookie.substring(i, j) == arg) return getCookieVal(j);
                i = document.cookie.indexOf(" ", i) + 1;
                if (i == 0) break;
            }
            return null;
        }

        function getCookieVal(offset) {
            var endstr = document.cookie.indexOf(";", offset);
            if (endstr == -1) endstr = document.cookie.length;
            return unescape(document.cookie.substring(offset, endstr));
        }
        //写入到Cookie
        function SetCookie(name, value, expires) {
            var argv = SetCookie.arguments;
            //本例中length = 3
            var argc = SetCookie.arguments.length;
            var expires = (argc > 2) ? argv[2] : null;
            var path = (argc > 3) ? argv[3] : null;
            var domain = (argc > 4) ? argv[4] : null;
            var secure = (argc > 5) ? argv[5] : false;
            document.cookie = name + "=" + escape(value) + ((expires == null) ? "" : ("; expires=" + expires.toGMTString())) + ((path == null) ? "" : ("; path=" + path)) + ((domain == null) ? "" : ("; domain=" + domain)) + ((secure == true) ? "; secure" : "");
        }

        function ResetCookie() {
            var usr = document.getElementById('Login_userName').value;
            var expdate = new Date();
            SetCookie(usr, null, expdate);
        }
//=============================================================cookie


    </script>
<body>
<div id="titleTop">
    <h1>電商登陸</h1>
</div>
<div id="pattern">
<form class="form-horizontal">
    <div class="form-group" >
        <label  class="col-sm-1 control-label">賬號</label>
        <div class="col-sm-3">
            <input type="text"  onblur="GetPwdAndChk()"  id="Login_userName" class="form-control"   placeholder="Account...">
        </div>
    </div>
    <div class="form-group">
        <label  class="col-sm-1 control-label">密碼</label>
        <div class="col-sm-3">
            <input type="password" id="Login_password" class="form-control"  placeholder="Password...">
        </div>
    </div>
    <div class="form-group">
        <label  class="col-sm-1 control-label">密碼</label>
        <div class="col-sm-2">
            <input type="checkbox"  id="chkRememberPwd" >記住密碼
            &nbsp&nbsp&nbsp
            <a href="/user/jumpUpdatePasswordJsp.do">忘記密碼</a>
        </div>
    </div>
    <div class="form-group">
        <label  class="col-sm-1 control-label"></label>
        <div id="button-loginDiv">
            <button class="btn btn-default" type="button" onclick="login()">登陸...</button>
            <button class="btn btn-kv" type="submit">注冊..</button>
        </div>
    </div>
</form>
</div>

<jsp:include page="/common/commonJS.jsp"></jsp:include>
<script>
</script>
<script>
    function login() {
        var flag = true;
           var V_userName = $("#Login_userName").val();
           var V_password = $("#Login_password").val();
           if(V_userName == ""){
             return flag=false;
           }
           if(V_password == "" ){
               return  flag=false;
           }
           $.ajax({
               url:"/user/login.do",
               type:"post",
               data:{"userName":V_userName,"password":V_password},
               success:function (result) {
                   if(result.code == 200){
                       var usr = document.getElementById('Login_userName').value;
                       //alert(usr);
                       //将最后一个用户信息写入到Cookie
                       SetLastUser(usr);
                       //如果记住密码选项被选中
                       if (document.getElementById('chkRememberPwd').checked == true) {
                           //取密码值
                           var pwd = document.getElementById('Login_password').value;
                           // alert(pwd);
                           var expdate = new Date();
                           expdate.setTime(expdate.getTime() + 14 * (24 * 60 * 60 * 1000));
                           //将用户名和密码写入到Cookie
                           SetCookie(usr, pwd, expdate);
                       } else {
                           //如果没有选中记住密码,则立即过期
                           ResetCookie();
                       }

                       location.href="/greet/Greet.jsp";
                   }
                   if(result.code == 1002){//密碼錯誤
                       bootbox.alert({
                           message: '密碼錯誤',
                           className: 'rubberBand animated'
                       });
                   }
                   if(result.code==1004){//密碼次數 超過 五次 鎖定
                       bootbox.alert({
                           message: '您密碼錯誤次數過多，請明天再來',
                           className: 'rubberBand animated'
                       });
                   }
                   if(result.code == 1003){//賬號 不正塙
                       bootbox.alert({
                           message: '賬號不正塙',
                           className: 'rubberBand animated'
                       });
                   }
                   if(result.code == 1000){//賬號 或者密碼 不遜在
                       bootbox.alert({
                           message: '賬號 或者密碼 不遜在',
                           className: 'rubberBand animated'
                       });
                   }
                   if(result.code == 1005){
                       bootbox.alert({
                       message: '您的賬號已經被鎖頂，請明天再來',
                       className: 'rubberBand animated'
                   });
               }
               }
           });
    }
</script>
</body>
</html>
