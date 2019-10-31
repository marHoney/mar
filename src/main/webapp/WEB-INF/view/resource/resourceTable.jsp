<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/8/29
  Time: 20:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>resource</title>
<jsp:include page="/common/commonCSS.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/common/test.jsp"></jsp:include>
<div class="container">
    <%--/* 展示 */--%>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-info">
                <div class="panel-heading"> <h2>權限面板
                    <button type="button" class="btn btn-default" onclick="addResource()"><font class="glyphicon glyphicon-plus">增加</font></button>
                    <button type="button" class="btn btn-default" onclick="updateResource()"><font class="glyphicon glyphicon-pencil">修改</font></button>
                    <button type="button" class="btn btn-info" onclick="deleteResource()"><font class="glyphicon glyphicon-trash">刪除</font></button>
                </h2>
                </div>
                <div class="panel-body">
                    <ul id="treeDemo" class="ztree"></ul>
                </div>
            </div>
        </div>
    </div>
    <%--/* 增加  */--%>
    <div id="AddResourceFormDiv" style="display: none;">
        <form class="form-horizontal">
            <div class="form-group">
                <label  class="col-sm-2 control-label">權限名</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="Add_resourceName" placeholder="請輸入權限名...">
                </div>
            </div>
            <div class="form-group">
                <label  class="col-sm-2 control-label">權限類型</label>
                <div class="col-sm-10">
                    <input type="radio" name="Add_resourceType" value="0"   />菜單
                    <input type="radio" name="Add_resourceType" value="1"   />按鈕
                </div>
            </div>
            <div class="form-group">
                <label  class="col-sm-2 control-label">路徑</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="Add_resourceUrl" placeholder="請輸入權限路徑...">
                </div>
            </div>
        </form>
    </div>
    <%--/* 修改  */--%>
    <div id="UpdateResourceFormDiv" style="display: none;">
        <form class="form-horizontal">
            <div class="form-group">
                <label  class="col-sm-2 control-label">權限名</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="Update_resourceName" placeholder="請輸入地權限名...">
                </div>
            </div>
            <div class="form-group">
                <label  class="col-sm-2 control-label">權限類型</label>
                <div class="col-sm-10">
                    <input type="radio" name="Update_resourceType" value="0"   />菜單
                    <input type="radio" name="Update_resourceType" value="1"   />按鈕
                </div>
            </div>
            <div class="form-group">
                <label  class="col-sm-2 control-label">權限路徑</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="Update_resourceUrl" placeholder="請輸入地權限名...">
                </div>
            </div>
        </form>
    </div>
</div>


<jsp:include page="/common/commonJS.jsp"></jsp:include>
</body>
<SCRIPT type="text/javascript">
    var BFAddResourceFormDiv;
    var BFUpdateResourceFormDiv;
    $(function () {
        initAreaZtree();
        BFAddResourceFormDiv=$("#AddResourceFormDiv").html();
        BFUpdateResourceFormDiv=$("#UpdateResourceFormDiv").html();
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


    function initAreaZtree() {
        $.ajax({
            url:"/resource/toResourceTable.do",
            type:"post",
            success:function (result) {
                var setting = {
                    data: {
                        simpleData: {
                            enable: true,
                            idKey: "id",
                            pIdKey: "fatherId",
                            rootPId: 0
                        },
                        key: {
                            name: "name"
                        }
                    }
                };
                $.fn.zTree.init($("#treeDemo"), setting, result.data);
            }
        });
    }
</SCRIPT>
<script>
    /* 增加 */
    var HaddResourceDig;
    function addResource() {
        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        var nodes = treeObj.getSelectedNodes();
        if(nodes.length == 1){
            // console.log(nodes);
            HaddResourceDig= bootbox.dialog({
                title: '添加地區',
                message: $("#AddResourceFormDiv form"),
                size: 'large',
                buttons: {
                    cancel: {
                        label: "取消",
                        className: 'btn-danger'
                    },
                    ok: {
                        label: "確定",
                        className: 'btn-info',
                        callback: function(){
                            var id=  nodes[0].id;
                            // alert(id);
                            var resource=$("#Add_resourceName",HaddResourceDig).val();
                            var resourceType= $("input[name='Add_resourceType']:checked",HaddResourceDig).val();
                            var resourceUrl=$("#Add_resourceUrl",HaddResourceDig).val();
                            //alert(areaName);
                            var data = {};
                            data.pid=id;
                            data.resourceName=resource;
                            data.resourceType=resourceType;
                            data.resourceUrl=resourceUrl;
                            $.ajax({
                                url:"/resource/addResource.do",
                                type:"post",
                                data:data,
                                success:function (result) {
                                    if(result.code == 200){
                                        var names = {id:result.data,name:resource,pid:id,resourceType:resourceType,resourceUrl:resourceUrl};
                                        //alert(JSON.stringify(names));
                                        treeObj.addNodes(nodes[0],names);
                                    }
                                }
                            })
                        }
                    }
                }
            });
            $("#AddResourceFormDiv").html(BFAddResourceFormDiv);
        }else{
            bootbox.alert({
                message:"只能選擇一項",
                className: 'rubberBand animated'
            });
        }
    }
    /* 刪除 */
    function deleteResource() {
        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        var sNodes = treeObj.getSelectedNodes();
        if (sNodes.length > 0) {//單個  刪除
            //alert(sNodes.length );
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
                    if (result) {
                        var areaIds = [];
                        var nodes = treeObj.transformToArray(sNodes);
                        for (var i = 0; i < nodes.length; i++) {
                            areaIds.push(nodes[i].id);
                            //alert(nodes[i].id);
                        }
                        $.ajax({
                            url: "/resource/deleteResource.do",
                            type: "post",
                            data: {"ids": areaIds},
                            success: function (result) {
                                if (result.code == 200) {
                                    for (var i = sNodes.length - 1; i >= 0; i--) {
                                        treeObj.removeNode(sNodes[i]);
                                    }
                                    console.log(result.message);
                                }
                            }
                        });//刪除 ajax
                    }
                }
            });//確認刪除嗎？
        }else {  // 一個都不選
            bootbox.alert({
                message: "選擇一個！",
                className: 'rubberBand animated'
            });
        }
    }
    /* 修改 */
    var HupdateResourceDig;
    function updateResource() {
        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        var nodes = treeObj.getSelectedNodes();

        if(nodes.length > 1){
            bootbox.alert({
                message:"只能選擇一項！",
                className: 'rubberBand animated'
            });
        }else
        if(nodes.length ==1 ){
            var ss= $("#Update_resourceName").val(nodes[0].name);
            var id= nodes[0].id;
            $.ajax({
                url:"/resource/queryUserByID.do",
                type:"post",
                async:false,
                data:{"id":id},
                success:function (result) {
                    if(result.code == 200){
                        var resourceDate=result.data;
                        console.log(resourceDate);
                        if(resourceDate.resourceType== 0){
                            $("input[type=radio][name='Update_resourceType'][value='0']").attr("checked",'checked');
                        }else{
                            $("input[type=radio][name='Update_resourceType'][value='1']").attr("checked",'checked');
                        }
                        $("#Update_resourceUrl").val(resourceDate.resourceUrl);
                    }
                }
            });

            HupdateResourceDig= bootbox.dialog({
                title: '修改地區',
                message: $("#UpdateResourceFormDiv form"),
                size: 'large',
                buttons: {
                    cancel: {
                        label: "取消",
                        className: 'btn-danger'
                    },
                    ok: {
                        label: "確定",
                        className: 'btn-info',
                        callback: function(){
                            var resourceName=$("#Update_resourceName",HupdateResourceDig).val();
                            var resourceType=$("#Update_resourceType",HupdateResourceDig).val();
                            var resourceUrl=$("#Update_resourceUrl",HupdateResourceDig).val();
                            //alert(areaName);

                            var data={};
                            data.id=id;
                            data.resourceName=resourceName;
                            data,resourceType=resourceType;
                            data.resourceUrl=resourceUrl;
                            $.ajax({
                                url:"/resource/updateResource.do",
                                type:"post",
                                data:data,
                                success:function (result) {
                                    if(result.code == 200){
                                        nodes[0].name = resourceName;
                                        treeObj.updateNode(nodes[0]);
                                        //console.log(result.message);
                                    }
                                }
                            });
                        }
                    }
                }
            });
            $("#UpdateResourceFormDiv").html(BFUpdateResourceFormDiv);
        }else {
            bootbox.alert({
                message: "只能選擇一項！",
                className: 'rubberBand animated'
            });
        }
    }
</script>
</html>
