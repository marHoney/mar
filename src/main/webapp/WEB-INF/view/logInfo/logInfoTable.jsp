<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/9/8
  Time: 23:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Title</title>
    <jsp:include page="/common/commonCSS.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/common/test.jsp"></jsp:include>
<div class="container">
    <%--第一行  條件查詢--%>
    <div class="row">
        <div class="panel panel-info">
            <div class="panel-heading">日志查詢</div>
            <div class="panel-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">用戶賬號</label>
                        <div class="col-sm-4">
                            <input type="text" id="Search_userName" class="form-control" placeholder="請輸入用戶賬號...">
                        </div>
                        <label  class="col-sm-2 control-label">用戶姓名</label>
                        <div class="col-sm-4">
                                <input type="text" id="Search_realName" class="form-control" placeholder="最請輸入用戶姓名..." >
                         </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">操作時間</label>
                        <div class="col-sm-4">
                            <div class="input-group">
                                <input type="text" class="form-control" id="Search_minCurrDate" placeholder="最小日期...">
                                <span class="input-group-addon" ><font class="glyphicon glyphicon-yen"></font></span>
                                <input type="text" class="form-control" id="Search_maxCurrDate" placeholder="最大日期...">
                            </div>
                        </div>
                        <label  class="col-sm-2 control-label">狀態查詢</label>
                        <div class="col-sm-4">
                            <select class="form-control" id="Search_status">
                                  <option class="form-control"   value="0">請選擇</option>
                                  <option class="form-control"   value="1">正常</option>
                                 <option  class="form-control"   value="2">異常</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">操作信息</label>
                        <div class="col-sm-4">
                            <input type="text" id="Search_info" class="form-control" placeholder="請輸入操作信息...">
                        </div>
                    </div>
                    <div style="text-align: center">
                        <button class="btn btn-primary" type="button" onclick="search()"><font class="glyphicon glyphicon-search">查詢</font></button>
                        <button class="btn btn-default" type="reset"><font class="glyphicon glyphicon-refresh">重置</font></button>
                    </div>
                </form>
            </div>
        </div>
    </div>
<%--datatable--%>
<div class="row">
    <div class="panel panel-info">
        <div class="panel-heading">日志列表</div>
        <div class="panel-body">
            <table id="table_id_logInfo" class="table table-striped table-bordered" style="width:100%">
                <thead>
                <tr>
                    <th>id</th>
                    <th>用戶賬號</th>
                    <th>用戶姓名</th>
                    <th>時間</th>
                    <th>info</th>
                    <th>狀態</th>
                    <th>内容</th>
                    <th>具體參數</th>
                    <th>具體内容</th>
                </tr>
                </thead>
                <tfoot>
                <tr>
                    <th>id</th>
                    <th>用戶賬號</th>
                    <th>用戶姓名</th>
                    <th>時間</th>
                    <th>info</th>
                    <th>狀態</th>
                    <th>内容</th>
                    <th>具體參數</th>
                    <th>具體内容</th>
                </tr>
                </tfoot>
            </table>
        </div>
    </div>
</div>
</div>
<jsp:include page="/common/commonJS.jsp"></jsp:include>
</body>
<script>
    $(function () {
        initDataTable();
        initDate("Search_minCurrDate");
        initDate("Search_maxCurrDate");
    })

    /* 初始化 search 的時間插件 */
    function initDate(searchId) {
        $('#'+searchId).datetimepicker({
            format: 'YYYY-MM-DD HH:mm',
            locale: 'zh-CN',
            showClear: true
        });
        $('#'+searchId).datetimepicker({
            format: 'YYYY-MM-DD HH:mm',
            locale: 'zh-CN',
            showClear: true
        });
    }

    /* 查詢 */
    function search() {
     var s_userName=$("#Search_userName").val();
     var s_realName=$("#Search_realName").val();
     var s_minCurrDate=$("#Search_minCurrDate").val();
     var s_maxCurrDate=$("#Search_maxCurrDate").val();
     var s_info=$("#Search_info").val();
     var s_status=$("#Search_status").val();

     var V_Search={};
        V_Search.userName=s_userName;
        V_Search.realName=s_realName;
        V_Search.minCurrDate=s_minCurrDate;
        V_Search.maxCurrDate=s_maxCurrDate;
        V_Search.info=s_info;
        V_Search.status=s_status;
        logInfoTable.settings()[0].ajax.data = V_Search;
        logInfoTable.ajax.reload();

   }
    
    /*  刪除 */
 /*   function deleteLogInfo(id){
        bootbox.confirm({
            message: "你确定要删除这条数据吗?",
            buttons: {
                confirm: {
                    label: '<i class="glyphicon glyphicon-ok"></i> OK',
                    className: 'btn-success'
                },
                cancel: {
                    label: '<i class="glyphicon glyphicon-remove"></i> ON',
                    className: 'btn-danger'
                }
            },
            callback: function (result) {
                if(result==true){
                    $.ajax({
                        url:"/logInfo/deleteLogInfo.do",
                        type:"post",
                        data:{"id":id},
                        success:function (result) {
                            //刷新
                            search();
                            if(result.code == 200){
                                //刷新
                            }
                        }
                    });
                }
            }
        });
    }*/

    /* 初始化product 表格 */
    var logInfoTable;
    function initDataTable(){
        logInfoTable= $('#table_id_logInfo').DataTable( {
            "lengthMenu":[5,9,3,-1],
            "language": {
                "url": "/js/bootstrap-3.3.7-dist/css/Chinese.json"
            },
            "searching":false,
            "processing": true,
            "serverSide": true,
            ajax: {
                url: "/logInfo/toLogInfoTable.do",
                type: "POST"
            },
            "columns": [
                { "data": "id" },
                { "data": "userName" },
                { "data": "realName" },
                { "data": "currDate" },
                { "data": "info" },
                { "data": "status" ,
                    "render":function (a,b,c,d) {
                         return a==1?"正常":"異常";
                    }
                },
                { "data": "errorMsg"},
                { "data": "detail"},
                { "data": "content"}
            ]
        } );
    }
</script>
</html>
