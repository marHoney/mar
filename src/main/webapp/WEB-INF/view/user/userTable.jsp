<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/8/18
  Time: 19:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>用戶模板1</title>

<jsp:include page="/common/commonCSS.jsp"></jsp:include>

</head>
<body >
<jsp:include page="/common/test.jsp"></jsp:include>

<div class="container" >
    <%-- 第一行 用戶條件查詢  面板  --%>
        <div class="row">
        <div class="col-md-12">
            <div class="panel panel-info">
                <div class="panel-heading">用戶查詢</div>
                <div class="panel-body" >
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">用戶名</label>
                            <div class="col-sm-4">
                                <input type="text" id="Search_userName" class="form-control"  placeholder="請輸入用戶名...">
                            </div>
                            <label  class="col-sm-2 control-label">真實姓名</label>
                            <div class="col-sm-4">
                                <input type="text" id="Search_realName" class="form-control"  placeholder="請輸入您的真實姓名...">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">年齡範圍</label>
                            <div class="col-sm-4">
                                <div class="input-group">
                                    <input type="text" id="Search_minAge" class="form-control" placeholder="請輸入最小年齡..." >
                                    <span class="input-group-addon" ><font class="glyphicon glyphicon-transfer"></font></span>
                                    <input type="text" id="Search_maxAge" class="form-control" placeholder="請輸入最大年齡...">
                                </div>
                            </div>
                            <label  class="col-sm-2 control-label">薪資範圍</label>
                            <div class="col-sm-4">
                                <div class="input-group">
                                    <input type="text" id="Search_minSalary" class="form-control" placeholder="請輸入最小薪資..." >
                                    <span class="input-group-addon" ><font class="glyphicon glyphicon-yen"></font></span>
                                    <input type="text" id="Search_maxSalary" class="form-control" placeholder="請輸入最大薪資...">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">入職時間</label>
                            <div class="col-sm-4">
                                <div class="input-group">
                                    <input type="text" id="Search_minEntryTime" class="form-control" placeholder="請輸入開始時間..." >
                                    <span class="input-group-addon" ><font class="glyphicon glyphicon-calendar"></font></span>
                                    <input type="text" id="Search_maxEntryTime" class="form-control" placeholder="請輸入結束時間...">
                                </div>
                            </div>
                            <div class="form-group">
                            <label  class="col-sm-2 control-label">角色</label>
                            <div class="col-sm-4">
                                <div id="searchsDiv">
                                </div>
                            </div>
                        </div>
                        </div>
                        <div style="text-align: center">
                            <button class="btn btn-primary" type="button" onclick="search()" ><font class="glyphicon glyphicon-search">查詢</font></button>
                            <button class="btn btn-default" type="reset"> <font class="glyphicon glyphicon-refresh">重置</font></button>
                        </div>
                    </form>
                </div>
        </div>
    </div>
    </div>
    <%-- 第二行 用戶增加 ，批量刪除....  面板  --%>
        <div style="background-color: #2aabd2;width: 100%;">
            <button class="btn btn-primary" type="button" onclick="addUser()"><font class="glyphicon glyphicon-plus">增加</font></button>
            <button class="btn btn-danger" type="button" onclick="deleteUserBatch()"><font class="glyphicon glyphicon-trash">批量刪除</font></button>
            <button class="btn btn-danger" type="button" onclick="downloadPdf()"><font class="glyphicon glyphicon-trash">pdf導出</font></button>
        </div>
         <%-- 第三行 用戶展示數據  面板  --%>
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel panel-default">
                        <div class="panel-heading" >用戶列表</div>
                        <div class="panel-body">
                            <table id="table_id_example" class="display table table-bordered" cellspacing="0">
                                <thead>
                                <tr>
                                    <th>id</th>
                                    <th>用戶名</th>
                                    <th>真實名</th>
                                    <th>年齡</th>
                                    <th>性別</th>
                                    <th>手機號</th>
                                    <th>郵箱號</th>
                                    <th>薪資</th>
                                    <th>入職時間</th>
                                    <th>角色</th>
                                    <th>狀態</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tfoot>
                                <tr>
                                    <th>id</th>
                                    <th>用戶名</th>
                                    <th>真實名</th>
                                    <th>年齡</th>
                                    <th>性別</th>
                                    <th>手機號</th>
                                    <th>郵箱號</th>
                                    <th>薪資</th>
                                    <th>入職時間</th>
                                    <th>角色</th>
                                    <th>狀態</th>
                                    <th>操作</th>
                                </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
            </div>
        </div>
       </div>
        <%-- 添加表單 --%>
        <div id="AddUserFromDiv" style="display: none;">
            <form class="form-horizontal" >
                <div class="form-group">
                    <label  class="col-sm-2 control-label">用戶名</label>
                    <div class="col-sm-4">
                        <input type="email" class="form-control" id="Add_userName"  placeholder="請輸入用戶名...">
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-2 control-label">真實名</label>
                    <div class="col-sm-4">
                        <input type="email" class="form-control" id="Add_realName"  placeholder="請輸入真實名...">
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-2 control-label">密碼</label>
                    <div class="col-sm-4">
                        <input type="password" class="form-control" id="Add_password"  placeholder="請輸入密碼...">
                    </div>
                </div><div class="form-group">
                <label  class="col-sm-2 control-label">確認密碼</label>
                <div class="col-sm-4">
                    <input type="password" class="form-control" id="Add_passwordTwo"  placeholder="請確認密碼...">
                </div>
                <label  class="col-sm-2 control-label"><font id="font_Add_passwordTwo"></font></label>
            </div>
                <div class="form-group">
                    <label  class="col-sm-2 control-label">年齡</label>
                    <div class="col-sm-4">
                        <input type="email" class="form-control" id="Add_age"  placeholder="請輸入您的年齡...">
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-2 control-label">手機號</label>
                    <div class="col-sm-4">
                        <input type="email" class="form-control" id="Add_phone"  placeholder="請輸入您的手機號...">
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-2 control-label">郵箱號</label>
                    <div class="col-sm-4">
                        <input type="email" class="form-control" id="Add_emall"  placeholder="請輸入您的郵箱號...">
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-2 control-label">性別</label>
                    <div class="col-sm-2">
                        <input type="radio" name="sexA" value="0"   />男
                        <input type="radio" name="sexA" value="1"   />女
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-2 control-label">薪資</label>
                    <div class="col-sm-4">
                        <input type="email" class="form-control" id="Add_salary"  placeholder="請輸入您的薪資...">
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-2 control-label">入職時間</label>
                    <div class="col-sm-4">
                        <input type="text" id="Add_entryTime" class="form-control" id="Add_entryTime"  placeholder="請輸入您的入職時間...">
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-2 control-label">角色</label>
                    <div class="col-sm-6">
                          <div id="Add_roleDiv">
                          </div>
                    </div>
                </div>
            </form>
        </div>
        <%--  修改用戶 --%>
        <div id="UpdateUserFromDiv" style="display: none;">
            <form class="form-horizontal" >
                <input type="hidden" id="Update_id">
                <div class="form-group">
                    <label  class="col-sm-2 control-label">用戶名</label>
                    <div class="col-sm-4">
                        <input type="email" class="form-control" id="Update_userName"  placeholder="請輸入用戶名...">
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-2 control-label">真實名</label>
                    <div class="col-sm-4">
                        <input type="email" class="form-control" id="Update_realName"  placeholder="請輸入真實名...">
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-2 control-label">年齡</label>
                    <div class="col-sm-4">
                        <input type="email" class="form-control" id="Update_age"  placeholder="請輸入您的年齡...">
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-2 control-label">手機號</label>
                    <div class="col-sm-4">
                        <input type="email" class="form-control" id="Update_phone"  placeholder="請輸入您的手機號...">
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-2 control-label">郵箱號</label>
                    <div class="col-sm-4">
                        <input type="email" class="form-control" id="Update_emall"  placeholder="請輸入您的郵箱號...">
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-2 control-label">性別</label>
                    <div class="col-sm-2">
                        <input type="radio" name="sex" value="0"  />男
                        <input type="radio" name="sex" value="1"  />女
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-2 control-label">薪資</label>
                    <div class="col-sm-4">
                        <input type="email" class="form-control" id="Update_salary"  placeholder="請輸入您的薪資...">
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-2 control-label">入職時間</label>
                    <div class="col-sm-4">
                        <input type="text" id="Update_entryTime" class="form-control" id="Update_entryTime"  placeholder="請輸入您的入職時間...">
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-2 control-label">角色</label>
                    <div class="col-sm-6">
                        <div id="Update_roleDiv">
                        </div>
                    </div>
                </div>
            </form>
        </div>
</div>

<jsp:include page="/common/commonJS.jsp"></jsp:include>
</body>
<script>
    /* 頁面初始化 函數 */
    var HAddUserFromDiv;
    var HUpdateUserFromDiv;
    $(function () {
        initDataTable();
        /* 回填 添加的From 表單 */
        HAddUserFromDiv = $("#AddUserFromDiv").html();
        /* 回填 修改的From 表單 */
        HUpdateUserFromDiv = $("#UpdateUserFromDiv").html();
        /* 初始化 search 的時間插件 */
        initDate();
        /* form 表單的 初始化 */
        initFormDate();
        //角色複選框
        initRole('Add_roleDiv','add');
        initRole('Update_roleDiv','update');
        initRole('searchsDiv','searchs');
        /* 批量刪除 初始化  */
        initBatch();
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
    
    function downloadPdf() {
        location.href="/exportFile/downloadPdf.do";
    }

    /* 批量刪除 */
    var arrIds=[];
    function initBatch() {
            $('#table_id_example tbody').on('click','tr' ,function () {
                //console.log(this);
               var IsCheckbox =  $(this).find("input[type = 'checkbox']");
               var IsChecked= IsCheckbox.prop("checked");
               //console.log(IsChecked);
              if(IsChecked){
                  IsCheckbox.prop("checked",false);
                  $(this).css("background-color","");
                  for (var i=arrIds.length-1 ; i >= 0 ;i--) {
                        //console.log(IsCheckbox.val());
                      if(arrIds[i] == IsCheckbox.val()){
                          arrIds.splice(i,1)
                      }
                  }
                }else{
                    //alert(IsChecked)
                 var chedked= IsCheckbox.prop("checked",true);
                  $(this).css("background-color","#a6b4cd");
                     //  console.log(IsCheckbox);
                      arrIds.push(IsCheckbox.val());
                }
        });
    }
    function  deleteUserBatch() {
                  if(arrIds.length > 0){
              bootbox.confirm({
                  message: "你确定要删除吗?",
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
                      if(result){
                          $.ajax({
                              url:"/user/deleteUserBatch.do",
                              type:"post",
                              data:{"arrIds":arrIds},
                              success:function (result) {
                                  if(result.code == 200){
                                      arrIds=[];
                                      search();
                                  }
                              }
                          });//ajax
                      }
                  }
              });
           }else{
              bootbox.alert({
                  message: "至少選一項",
                  className: 'rubberBand animated'
              });
          }

  }
    function rolelist(id){
        $("input[name='Update_roleDiv']:checkbox").each(function () {
            if(this.value==id){
                this.checked=true;
                return;
            }
        })
    }
    /* 角色 查詢 */
    function initRole(roleDiv,selectid) {
        $.ajax({
            url:"/role/queryUserCheckbox.do",
            type:"post",
            success:function (result) {
                if(result.code == 200){
                    var data= result.data;
                    var rhtml = '<select id="'+selectid+'" multiple title="请选择角色" multiple>';
                    for (var i = 0; i < data.length; i++) {
                        rhtml +='<option value="'+data[i].id+'" data-id='+data[i].id+' >'+data[i].roleName+'</option>';
                    }
                     rhtml +='</select>';
                    $("#"+roleDiv).html(rhtml);
                    $("#"+selectid).selectpicker();
                }
                }
        });
    }
    function a(){
        alert(1);
    }
    /* 條件 查詢 */
    function  search() {
         var Search_userName= $("#Search_userName").val();
         var Search_realName= $("#Search_realName").val();
         var Search_minAge= $("#Search_minAge").val();
         var Search_maxAge= $("#Search_maxAge").val();
         var Search_minSalary= $("#Search_minSalary").val();
         var Search_maxSalary= $("#Search_maxSalary").val();
         var Search_minEntryTime= $("#Search_minEntryTime").val();
         var Search_maxEntryTime= $("#Search_maxEntryTime").val();
         var Search_RoleIds= $("#searchs").val().join(",");

        var V_Search = {};
         V_Search.userName =Search_userName;
         V_Search.realName =Search_realName;
         V_Search.minAge =Search_minAge;
         V_Search.maxAge =Search_maxAge;
         V_Search.minSalary =Search_minSalary;
         V_Search.maxSalary =Search_maxSalary;
         V_Search.minEntryTime =Search_minEntryTime;
         V_Search.maxEntryTime =Search_maxEntryTime;
         V_Search.roleIds=Search_RoleIds;
         userTableOne.settings()[0].ajax.data = V_Search;
         userTableOne.ajax.reload();


    }
    /* 時間插件 from 中的 */
    function initFormDate() {
        $('#Update_entryTime').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-CN',
            showClear: true
        });$('#Add_entryTime').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-CN',
            showClear: true
        });

    }
    /* 初始化 search 的時間插件 */
    function initDate() {
        $('#Search_minEntryTime').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-CN',
            showClear: true
        });
        $('#Search_maxEntryTime').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-CN',
            showClear: true
        });
    }
    function isExist(id) {
        for (var i = 0; i < arrIds.length; i++) {
            if (id == arrIds[i]) {
                return true;
            }
        }
        return false;
    }
    

    
    /* 初始化 用戶 頁面*/
    var userTableOne;
    function initDataTable(){
        userTableOne= $('#table_id_example').DataTable( {
            "lengthMenu":[5,9,3,-1],
            "language": {
                "url": "/js/bootstrap-3.3.7-dist/css/Chinese.json"
            },
            "bAutoWidth":true,
            "searching":false,
            "processing": true,
            "serverSide": true,
            ajax: {
                url: "/user/toUserTable.do",
                type: "POST"
            },
            drawCallback:function (s) {
                // 对比，将当前表格中出现的行的唯一标识和ids数组中的唯一标识对比，一致则回填
                $("#table_id_example tbody tr").each(function () {
                    var v_checkbox = $(this).find("input[type='checkbox']")[0];
                    if (v_checkbox) {
                        var id = v_checkbox.value;
                       // console.log(id);
                        if (isExist(id)) {
                            $(this).css("background-color", "#a6b4cd");
                            v_checkbox.checked = true;
                        }
                    }
                })
            },
            "columns": [
                { "data": "id",
                    render : function (data,type,row,meta) {
                        return '<input type="checkbox"  value="'+data+'" />';
                    }},
                { "data": "userName" },
                { "data": "realName" },
                { "data": "age" },
                { "data": "sex" ,render : function (data,type,row,meta) {
                        var sex=row.sex==1?"女":"男";
                        return sex;
                    }},
                { "data": "phone" },
                { "data": "emall" },
                { "data": "salary" },
                { "data": "entryTime" },
                { "data": "roleNames" },
                { "data": "lock",
                    render : function (data,type,row,meta) {
                        return data?"<font color='red'>鎖定</font>":"<font color='green'>正常</font>";
                    }
                },
                {  "data": "id","render": function ( data, type, row, meta ) {
                        var  Trow = JSON.stringify(row);

                        var  deleteUserById='<button class="btn btn-danger" type="submit" onclick="deleteUserById('+data+')"><font class="glyphicon glyphicon-trash">刪除</font></button>';
                        var  updateUser='<button class="btn btn-primary" type="button" onclick="updateUser('+data+')"><font class="glyphicon glyphicon-plus">修改</font></button>';
                        var  isLock="<button class='btn btn-warning' type='button' onclick='updateUserLock("+Trow+")'><font class='glyphicon glyphicon-remove'>狀態</font></button>";
                        var  resestPassword="<button class='btn btn-danger' type='button' onclick='resetPassword("+data+")'><font class='glyphicon glyphicon-refresh'>重置密碼</font></button>";

                        var common=deleteUserById+updateUser+isLock+resestPassword;
                        return common;
                    } }
            ]
        } );
    }
    
    function resetPassword(id) {
       event.stopPropagation();
          $.ajax({
              url:"/user/resetPassword.do",
              type:"post",
              data:{"id":id},
              success:function (result) {
                  if(result.code ==200){
                      bootbox.alert({
                          message:"重置密碼成功",
                          className: 'rubberBand animated'
                      });
                  }
              }
          });
    }

    function updateUserLock(row) {
        event.stopPropagation();
       var isLock= row.lock;
       console.log(row);
       if(isLock == true) {
           bootbox.confirm({
               message: "你确定要这把条数据給<font color='red'>解鎖</font>嗎？",
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
                       var errorCount = 0;
                       $.ajax({
                           url: "/user/updateUserLock.do",
                           type: "post",
                           data: {id: row.id, "errorCount": errorCount},
                           success: function (result) {
                               if (result.code == 200) {
                                   search();
                               }
                           }
                       });
                   }
               }
           });

       }
       if(isLock == false){
           bootbox.confirm({
               message: "你确定要这把条数据給<font color='red'>鎖定</font>嗎？",
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
                       var errorCount = 3;
                       $.ajax({
                           url:"/user/updateUserLock.do",
                           type:"post",
                           data:{id:row.id,"errorCount":errorCount},
                           success:function (result) {
                               if(result.code == 200){
                                   search();
                               }
                           }
                       });
                   }
               }
           });
       }
    }



     /*刪除用戶信息*/
    function deleteUserById(id) {
        event.stopPropagation();
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
                        url:"/user/deleteUserById.do",
                        type:"post",
                        data:{"id":id},
                        success:function (result) {
                            if(result.code == 200){
                                //刷新
                                arrIds=[];
                                search();
                            }
                        }
                    });
                }
            }
        });
    }
    /* 增加用戶信息 */
    var HuiTianAddUserFromDiv;
    function addUser() {
        HuiTianAddUserFromDiv = bootbox.dialog({
            title: '用戶添加',
            message: $("#AddUserFromDiv form"),
            size: 'large',
            buttons: {
                cancel: {
                    label: "取消",
                    className: 'btn-danger'
                },
                ok: {
                    label: "確認",
                    className: 'btn-info',
                    callback: function(result){
                        var Add_userName =  $("#Add_userName",HuiTianAddUserFromDiv).val();
                        var Add_realName =  $("#Add_realName",HuiTianAddUserFromDiv).val();
                        var Add_password =  $("#Add_password",HuiTianAddUserFromDiv).val();
                        var Add_passwordTwo =  $("#Add_passwordTwo",HuiTianAddUserFromDiv).val();
                        var Add_age =  $("#Add_age",HuiTianAddUserFromDiv).val();
                        var Add_phone =  $("#Add_phone",HuiTianAddUserFromDiv).val();
                        var Add_emall =  $("#Add_emall",HuiTianAddUserFromDiv).val();
                        var Add_sex = $(":radio[name=sexA]:checked").val();
                        var Add_salary =  $("#Add_salary",HuiTianAddUserFromDiv).val();
                        var Add_entryTime =  $("#Add_entryTime",HuiTianAddUserFromDiv).val();
                        var roleIds= $("#add",HuiTianAddUserFromDiv).val().join(",");
                        var data ={};
                        data.userName=Add_userName;
                        data.realName=Add_realName;
                        data.password=Add_password;
                        data.passwordTwo=Add_passwordTwo;
                        data.age=Add_age;
                        data.phone=Add_phone;
                        data.emall=Add_emall;
                        data.sex=Add_sex;
                        data.salary=Add_salary;
                        data.entryTime=Add_entryTime;
                        data.roleIds=roleIds;
                            $.ajax({
                                url:"/user/addUser.do",
                                type:"post",
                                data:data,
                                success:function (result) {
                                    //刷新
                                    if(result.code == 200){
                                        search();
                                    }
                                }
                            });
                    }
                }
            }
        });

        $("#AddUserFromDiv").html(HAddUserFromDiv);
        initFormDate();
        initRole('Add_roleDiv','add');
    }
    /*修改*/
    var HuiTianUpdateUserFromDiv;
    function updateUser(id) {
        event.stopPropagation();
        $.ajax({
            url:"/user/queryUserById.do",
            type:"post",
            data:{"id":id},
            async:true,
            success:function (result) {
                if(result.code == 200){
                    var data= result.data;
                    var userName= data.userName;
                    var realName=data.realName;
                    var age=data.age;
                    var phone=data.phone;
                    var emall=data.emall;
                    var salary=data.salary;
                    var entryTime=data.entryTime;
                    if(data.sex == 0){
                        $("input[type=radio][name='sex'][value='0']").attr("checked",'checked');
                    }else{
                        $("input[type=radio][name='sex'][value='1']").attr("checked",'checked');
                    }
                    var ids= data.roleIds;
                   // console.log(ids)
                    for (var i = 0; i < ids.length; i++) {
                             rolelist(ids[i]);
                    }

                    $("#Update_id",HuiTianUpdateUserFromDiv).val(id);
                    $("#Update_userName",HuiTianUpdateUserFromDiv).val(userName);
                    $("#Update_realName",HuiTianUpdateUserFromDiv).val(realName);
                    $("#Update_age",HuiTianUpdateUserFromDiv).val(age);
                    $("#Update_phone",HuiTianUpdateUserFromDiv).val(phone);
                    $("#Update_emall",HuiTianUpdateUserFromDiv).val(emall);
                    $("#Update_salary",HuiTianUpdateUserFromDiv).val(salary);
                    $("#Update_entryTime",HuiTianUpdateUserFromDiv).val(entryTime);
                    $("#update",HuiTianUpdateUserFromDiv).selectpicker("val",ids);
                }

            }//success
        });
        HuiTianUpdateUserFromDiv = bootbox.dialog({
            title: '用戶修改',
            message: $("#UpdateUserFromDiv form"),
            size: 'large',
            buttons: {
                cancel: {
                    label: "取消",
                    className: 'btn-danger',
                    callback: function () {
                        bootbox.alert({
                            message: "多謝手下留情！",
                            className: 'rubberBand animated'
                        });
                    }
                },
                ok: {
                    label: "修改",
                    className: 'btn-info',
                    callback: function () {
                        var Update_id = $("#Update_id",HuiTianUpdateUserFromDiv).val();
                        var Update_userName = $("#Update_userName", HuiTianUpdateUserFromDiv).val();
                        var Update_realName = $("#Update_realName", HuiTianUpdateUserFromDiv).val();
                        var Update_age = $("#Update_age", HuiTianUpdateUserFromDiv).val();
                        var Update_phone = $("#Update_phone", HuiTianUpdateUserFromDiv).val();
                        var Update_emall = $("#Update_emall", HuiTianUpdateUserFromDiv).val();
                        var Update_sex = $(":radio[name=sex]:checked", HuiTianUpdateUserFromDiv).val();
                        var Update_salary = $("#Update_salary", HuiTianUpdateUserFromDiv).val();
                        var Update_entryTime = $("#Update_entryTime", HuiTianUpdateUserFromDiv).val();
                        var roleIds= $("#update",HuiTianUpdateUserFromDiv).val().join(",");

                        var data = {};
                        data.id= Update_id;
                        data.userName = Update_userName;
                        data.realName = Update_realName;
                        data.age = Update_age;
                        data.phone = Update_phone;
                        data.emall = Update_emall;
                        data.sex = Update_sex;
                        data.salary = Update_salary;
                        data.entryTime = Update_entryTime;
                        data.roleIds=roleIds;
                        $.ajax({
                            url:"/user/updateUser.do",
                            type:"post",
                            data:data,
                            success:function (updateData) {
                                //刷新
                                if(updateData.code == 200 ){
                                    search();
                                }

                            }
                        });//ajax
                    }
                }, //ok
            },
        });
        /*  回填 */
        $("#UpdateUserFromDiv").html(HUpdateUserFromDiv);
        initFormDate();
        initRole('Update_roleDiv','update');
    }

</script>
</html>
