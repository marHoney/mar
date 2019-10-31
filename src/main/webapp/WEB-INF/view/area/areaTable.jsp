<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/8/25
  Time: 10:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>area</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <jsp:include page="/common/commonCSS.jsp"></jsp:include>

</head>
<body>
<jsp:include page="/common/test.jsp"></jsp:include>
<div class="container">
    <%--/* 展示 */--%>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-info">
                <div class="panel-heading"> <h2>地區面板
                    <button type="button" class="btn btn-default" onclick="addArea()"><font class="glyphicon glyphicon-plus">增加</font></button>
                    <button type="button" class="btn btn-default" onclick="updateArea()"><font class="glyphicon glyphicon-pencil">修改</font></button>
                    <button type="button" class="btn btn-info" onclick="deleteArea()"><font class="glyphicon glyphicon-trash">刪除</font></button>
                </h2>

                </div>
                <div class="panel-body">
                                <ul id="treeDemo" class="ztree"></ul>
                </div>
            </div>
        </div>
    </div>
    <%--/* 增加  */--%>
    <div id="AddAreaFormDiv" style="display: none;">
        <form class="form-horizontal">
            <div class="form-group">
                <label  class="col-sm-2 control-label">地區名</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="Add_areaName" placeholder="請輸入地區名...">
                </div>
            </div>
        </form>
    </div>
    <%--/* 修改  */--%>
    <div id="UpdateAreaFormDiv" style="display: none;">
            <form class="form-horizontal">
                <div class="form-group">
                    <label  class="col-sm-2 control-label">地區名</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="Update_areaName" placeholder="請輸入地區名...">
                    </div>
                </div>
            </form>
        </div>
</div>
<jsp:include page="/common/commonJS.jsp"></jsp:include>
</body>
<SCRIPT type="text/javascript">
    var BFAddAreaFormDiv;
    var BFUpdateAreaFormDiv;
    $(function () {
        initAreaZtree();
        BFAddAreaFormDiv=$("#AddAreaFormDiv").html();
        BFUpdateAreaFormDiv=$("#UpdateAreaFormDiv").html();
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
            url:"/area/queryAreaList.do",
            type:"post",
            success:function (result) {
                var setting = {

                    data: {
                        simpleData: {
                            enable: true,
                            idKey: "id",
                            pIdKey: "fatherId",
                            rootPId: 0
                        },key: {
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
    var HaddAreaDig;
    function addArea() {
        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        var nodes = treeObj.getSelectedNodes();
        if(nodes.length == 1){
           // console.log(nodes);
            HaddAreaDig= bootbox.dialog({
                title: '添加地區',
                message: $("#AddAreaFormDiv form"),
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
                         var areaName=$("#Add_areaName",HaddAreaDig).val();
                         //alert(areaName);
                        $.ajax({
                            url:"/area/addArea.do",
                            type:"post",
                            data:{"pid":id,"areaName":areaName},
                            success:function (result) {
                                if(result.code == 200){
                                    var names = {id:result.data,name:areaName,pid:id};
                                    //alert(JSON.stringify(names));
                                    treeObj.addNodes(nodes[0],names);
                                }
                            }
                        })
                        }
                    }
                }
            });
            $("#AddAreaFormDiv").html(BFAddAreaFormDiv);
        }else{
            bootbox.alert({
                message:"只能選擇一項",
                className: 'rubberBand animated'
            });
        }
    }
    /* 刪除 */
    function deleteArea() {
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
                            url: "/area/deleteArea.do",
                            type: "post",
                            data: {"idss": areaIds},
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
    var HupdateAreaDig;
    function updateArea() {
        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        var nodes = treeObj.getSelectedNodes();

        if(nodes.length > 1){
            bootbox.alert({
                message:"只能選擇一項！",
                className: 'rubberBand animated'
            });
        }else
       if(nodes.length ==1 ){
       var ss= $("#Update_areaName").val(nodes[0].name);
       var id= nodes[0].id;
       HupdateAreaDig= bootbox.dialog({
           title: '修改地區',
           message: $("#UpdateAreaFormDiv form"),
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
                       var areaName=$("#Update_areaName",HupdateAreaDig).val();
                       //alert(areaName);
                       $.ajax({
                           url:"/area/updateArea.do",
                           type:"post",
                           data:{"id":id,"areaName":areaName},
                           success:function (result) {
                               if(result.code == 200){
                                   nodes[0].name = areaName;
                                   treeObj.updateNode(nodes[0]);
                                   console.log(result.message);
                               }
                           }
                       });
                   }
               }
           }
       });
       $("#UpdateAreaFormDiv").html(BFUpdateAreaFormDiv);
   }else {
       bootbox.alert({
           message: "只能選擇一項！",
           className: 'rubberBand animated'
         });
       }
}

</script>
</html>
