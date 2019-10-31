<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/8/24
  Time: 15:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>role table</title>
    <jsp:include page="/common/commonCSS.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/common/test.jsp"></jsp:include>
<div class="container">
    <%--第一行  條件查詢--%>
    <div class="row">
        <div class="panel panel-info">
            <div class="panel-heading">角色查詢</div>
            <div class="panel-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">角色</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="Search_roleName" placeholder="請輸入角色...">
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
    <%--//第二行  批量刪--%>
    <div class="row">
        <div style="background-color: #a6b4cd;width: 100%;" >
            <div class="btn-group" role="group" aria-label="...">
                <button type="button" class="btn btn-primary" onclick="addRole()"><font class="glyphicon glyphicon-plus">增加</font> </button>
                <button type="button" class="btn btn-danger" onclick="deleteBatches()"><font class="glyphicon glyphicon-trash">批量刪</font></button>
            </div>
        </div>
    </div>
    <%--datatable--%>
    <div class="row">
        <div class="panel panel-info">
            <div class="panel-heading">角色列表</div>
            <div class="panel-body">
                <table id="table_id_role" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                    <tr>
                        <th>id</th>
                        <th>角色</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tfoot>
                    <tr>
                        <th>id</th>
                        <th>角色</th>
                        <th>操作</th>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>

    <div id="AddRoleFormDiv" style="display: none;">
        <form class="form-horizontal" >
            <div class="form-group">
                <label  class="col-sm-2 control-label">角色名</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="Add_roleName"  placeholder="請輸入角色名...">
                </div>
            </div>
            <div class="form-group">
                <label  class="col-sm-2 control-label">地區名</label>
                <div class="col-sm-4">
                    <ul id="treeDemorole" class="ztree"></ul>
                </div>
            </div>
        </form>
    </div>
    <div id="UpdateRoleFormDiv" style="display: none;">
         <form class="form-horizontal" >
             <div class="form-group">
                 <label  class="col-sm-2 control-label">角色名</label>
                 <div class="col-sm-4">
                     <input type="text" class="form-control" id="Update_roleName"  placeholder="請修改角色名...">
                     <input type="hidden" class="form-control" id="Update_id" >
                 </div>
             </div>
             <div class="form-group">
                 <label  class="col-sm-2 control-label">地區名</label>
                 <div class="col-sm-4">
                     <ul id="Update_treeDemorole" class="ztree"></ul>
                 </div>
             </div>
         </form>
        </div>
</div>
</body>
<jsp:include page="/common/commonJS.jsp"></jsp:include>
<script>
     var BFAddRoleFormDiv;
     var BFUpdateRoleFormDiv;
    $(function () {
        /* 初始化 datatable 表格 */
        initDataTable();
       BFAddRoleFormDiv=  $("#AddRoleFormDiv").html();
       BFUpdateRoleFormDiv=  $("#UpdateRoleFormDiv").html();

    })
   // ajax  全局事件
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


        /* ztree*/
     function initAreaZtree() {
         $.ajax({
             url:"/resource/toResourceTable.do",
             async:false,
             type:"post",
             success:function (result) {
                 var setting = {
                     check: {
                         enable: true,
                         chkboxType:{ "Y" : "ps", "N" : "s" }
                     },
                     data: {
                         simpleData: {
                             enable: true,
                             idKey: "id",
                             pIdKey: "fatherId"
                         },key: {
                             name: "name"
                         }
                     }
                 };
                 $.fn.zTree.init($("#treeDemorole"), setting, result.data);
             }
         });
     }
     function U_initAreaZtree() {
         $.ajax({
             url:"/resource/toResourceTable.do",
             async:false,
             type:"post",
             success:function (result) {
                 var setting = {
                     check: {
                         enable: true,
                         chkboxType:{ "Y" : "ps", "N" : "s" }
                     },
                     data: {
                         simpleData: {
                             enable: true,
                             idKey: "id",
                             pIdKey: "fatherId"
                         },key: {
                             name: "name"
                         }
                     }
                 };
                 $.fn.zTree.init($("#Update_treeDemorole"), setting, result.data);
                 var treeObj = $.fn.zTree.getZTreeObj("Update_treeDemorole");
                 treeObj.expandAll(true);
             }
         });
     }
     /* 條件查詢 */
     function search() {
        var roleName= $("#Search_roleName").val();
         var V_Search = {};
         V_Search.roleName=roleName;
         roleTableOne.settings()[0].ajax.data = V_Search;
         roleTableOne.ajax.reload();
     }
    /* 刪除*/
    function deleteRole(id) {
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
                if(result){
                    $.ajax({
                        url:"/role/deleteRole.do",
                        type:"post",
                        data:{"id":id},
                        success:function (resultRole) {
                            if(resultRole.code  == 200){
                                search();
                                console.log(resultRole.message);
                            }

                        }
                    });//ajax
                }
            }
        });
    }
    /* 批量刪除*/
    function  deleteBatches() {
    }
    /* 增加 */
     var HTaddRole;
    function addRole() {
        initAreaZtree();
       HTaddRole= bootbox.dialog({
            title: '角色添加',
            message: $("#AddRoleFormDiv form"),
            size: 'large',
            buttons: {
                cancel: {
                    label: "取消",
                    className: 'btn-danger',
                },
                ok: {
                    label: "確定",
                    className: 'btn-info',
                    callback: function(){
                        var roleName=$("#Add_roleName",HTaddRole).val();
                        var treeObj = $.fn.zTree.getZTreeObj("treeDemorole");
                        var nodes = treeObj.getCheckedNodes(true);
                        var idArr =[];
                        $(nodes).each(function () {
                            //console.log(this.id);
                            idArr.push(this.id);
                        })
                        if(idArr.length > 0){
                            $.ajax({
                                url:"/role/addRole.do",
                                type:"post",
                                data:{"roleName":roleName,"idsArr":idArr},
                                success:function (result) {
                                    search();
                                    if(result.code == 200){
                                       // console.log(result.message)
                                    }
                                }
                            });
                        }//判斷  權限的id  大於1
                    }
                }
            }
        });
        $("#AddRoleFormDiv").html(BFAddRoleFormDiv);
    }
    /* 修改 */
     var HTupdateRole;
    function updateRole(huixain) {
        U_initAreaZtree();
        var roleName=$("#Update_roleName").val(huixain.roleName);
        var id=$("#Update_id").val(huixain.id);
          $.ajax({
              url:"/role/queryResourceIdByRoleId.do",
              type:"post",
              data:{"roleId":huixain.id},
              success:function (result) {
                  if(result.code ==200) {
                      // console.log(result.data.resourceId);
                      var zx = result.data.resourceId
                      for (var i = 0; i < zx.length; i++) {
                          var treeObj = $.fn.zTree.getZTreeObj("Update_treeDemorole");
                          var node = treeObj.getNodeByParam("id", zx[i], null);
                          ;
                          treeObj.checkNode(node, true);
                          //console.log(node);
                      }
                  }
              }
          });
        HTupdateRole= bootbox.dialog({
            title: '角色修改',
            message: $("#UpdateRoleFormDiv form"),
            size: 'large',
            buttons: {
                cancel: {
                    label: "取消",
                    className: 'btn-danger',
                },
                ok: {
                    label: "確定",
                    className: 'btn-info',
                    callback: function(){

                       var roleName= $("#Update_roleName",HTupdateRole).val();
                       var id = $("#Update_id",HTupdateRole).val();
                        var treeObj = $.fn.zTree.getZTreeObj("Update_treeDemorole");
                        var nodes = treeObj.getCheckedNodes(true);
                        var idArr =[];
                        $(nodes).each(function () {
                            //console.log(this.id);
                            idArr.push(this.id);
                        });

                        $.ajax({
                            url:"/role/updateRole.do",
                            type:"post",
                            data:{"roleName":roleName,"id":id,"idsArr":idArr},
                            success:function (result) {
                                if(result.code == 200){
                                    search();
                                   // console.log(result.message)

                                }
                            }
                        });
                    }
                }
            }
        });
        $("#UpdateRoleFormDiv").html(BFUpdateRoleFormDiv)
    }
    /* datatable 表格 */
     var roleTableOne;
    function initDataTable(){
        roleTableOne= $('#table_id_role').DataTable( {
            "lengthMenu":[5,9,3,-1],
            "language": {
                "url": "/js/bootstrap-3.3.7-dist/css/Chinese.json"
            },
            "searching":false,
            "processing": true,
            "serverSide": true,
            ajax: {
                url: "/role/toRoleTable.do",
                type: "POST"
            },
            "columns": [
                { "data": "id" },
                { "data": "roleName" },
                {  "data": "id","render": function ( data, type, row, meta ) {
                        var huixain = JSON.stringify(row)
                        var  deleteUserById='<button type="button"  class="btn btn-danger"  onclick="deleteRole('+data+');"><font class="glyphicon glyphicon-trash">刪除</font></button>';
                        var  updateUser="<button type='button'  class='btn btn-primary'  onclick='updateRole("+huixain+")'><font class='glyphicon glyphicon-plus'>修改</font></button>";
                        var common=deleteUserById+updateUser;
                        return common;
                    } }
            ]
        } );
    }
</script>
</html>
