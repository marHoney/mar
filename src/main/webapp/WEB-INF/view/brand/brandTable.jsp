<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/8/24
  Time: 19:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>brand</title>
<jsp:include page="/common/commonCSS.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/common/test.jsp"></jsp:include>
<div class="container">
    <%--第一行  條件查詢--%>
    <div class="row">
        <div class="panel panel-info">
            <div class="panel-heading">品牌查詢</div>
            <div class="panel-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">品牌</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="Search_brandName" placeholder="請輸入品牌...">
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
                <button type="button" class="btn btn-primary" onclick="addBrand()"><font class="glyphicon glyphicon-plus">增加</font> </button>
                <button type="button" class="btn btn-danger" onclick="deleteBatches()"><font class="glyphicon glyphicon-trash">批量刪</font></button>
            </div>
        </div>
    </div>
    <%--datatable--%>
    <div class="row">
        <div class="panel panel-info">
            <div class="panel-heading">商品列表</div>
            <div class="panel-body">
                <table id="table_id_brand" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                    <tr>
                        <th>id</th>
                        <th>商品價格</th>
                        <th>品牌圖片</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tfoot>
                    <tr>
                        <th>id</th>
                        <th>商品價格</th>
                        <th>品牌圖片</th>
                        <th>操作</th>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>
<div id="AddBrandFormDiv" style="display: none;">
    <form class="form-horizontal" >
        <div class="form-group">
            <label  class="col-sm-2 control-label">品牌名</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="Add_brandName"  placeholder="請輸入角色名...">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">主图</label>
            <div class="col-sm-5">
                <input type="file" name="ff" class="file-loading" id="Add_brandPhoto"  >
                <input type="hidden" id="Add_fileInput"/>
            </div>
        </div>
    </form>
</div>
<div id="UpdateBrandFormDiv" style="display: none;">
    <form class="form-horizontal" >
        <div class="form-group">
            <label  class="col-sm-2 control-label">角色名</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="Update_brandName"  placeholder="請修改角色名...">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">品牌圖片</label>
            <div class="col-sm-4">
               <%-- <input type="text" class="form-control" id="Update_brandPhoto"  placeholder="請修改角色名...">
                <input type="text" id="add_mainImagePath">--%>
                   <input type="file" name="files" class="file-loading" id="Update_brandPhoto"  >
                   <input type="hidden" id="Update_fileInput"/>
            </div>
        </div>
    </form>
</div>


<jsp:include page="/common/commonJS.jsp"></jsp:include>
<script>
    var BFAddBrandFormDiv;
    var BFUpdateBrandFormDiv;
    $(function () {
        initDataTable();
        BFAddBrandFormDiv=$("#AddBrandFormDiv").html();
        BFUpdateBrandFormDiv=$("#UpdateBrandFormDiv").html();

        initFileInput("Add_brandPhoto","Add_fileInput");
        initFileInput("Update_brandPhoto","Update_fileInput");
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

    /* 查詢*/
    function search() {
        var v_brandName=$("#Search_brandName").val();
        var V_Search ={};
        V_Search.brandName=v_brandName;
        productTable.settings()[0].ajax.data = V_Search;
        productTable.ajax.reload();
    }
    /* 刪除 */
     function deleteBrand(id) {
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
                         url:"/brand/deleteBrand.do",
                         type:"post",
                         data:{"id":id},
                         success:function (result) {
                             if(result.code  == 200){
                                 search();
                                 console.log(result.message);
                             }

                         }
                     });//ajax
                 }
             }
         });
     }
    /* 修改 */
    var HTUpdateBrnad;
    function updateBrand(row) {
        $("#Update_id").val(row.id);
        $("#Update_brandName").val(row.brandName);
        $("#Update_brandPhoto").val(row.brandPhoto);

        HTUpdateBrnad= bootbox.dialog({
            title: '品牌修改',
            message: $("#UpdateBrandFormDiv form"),
            size: 'large',
            buttons: {
                cancel: {
                    label: "取消",
                    className: 'btn-danger',
                },
                ok: {
                    label: "確定",
                    className: 'btn-info',
                    callback: function () {
                        var V_id= $("#Update_id",HTUpdateBrnad).val();
                        var V_brandName= $("#Update_brandName",HTUpdateBrnad).val();
                        var V_brandPhoto= $("#Update_brandPhoto",HTUpdateBrnad).val();

                        var data ={};
                        data.id=V_id;
                        data.brandName=V_brandName;
                        data.brandPhoto=V_brandPhoto;
                        $.ajax({
                            url:"/brand/UpdateBrand.do",
                            type:"post",
                            data:data,
                            success:function (result) {
                                if(result.code == 200){
                                    // 刷新
                                    search();
                                }
                            }
                        });
                    }
                }
            }
        });
        $("#UpdateBrandFormDiv").html(BFUpdateBrandFormDiv);

    }
    /* 增加 */
    var HTaddBrand;
    function addBrand() {
        HTaddBrand= bootbox.dialog({
            title: '品牌添加',
            message: $("#AddBrandFormDiv form"),
            size: 'large',
            buttons: {
                cancel: {
                    label: "取消",
                    className: 'btn-danger',
                },
                ok: {
                    label: "確定",
                    className: 'btn-info',
                    callback: function () {
                       var V_brandName= $("#Add_brandName",HTaddBrand).val();
                        var V_brandPhoto = $("#Add_fileInput", HTaddBrand).val();

                       var data ={};
                       data.brandName=V_brandName;
                       data.brandPhoto=V_brandPhoto;
                        $.ajax({
                            url:"/brand/addBrand.do",
                            type:"post",
                            data:data,
                            success:function (result) {
                                if(result.code == 200){
                                    // 刷新
                                    search();
                                }
                            }
                        });
                    }
                }
            }
        });
       $("#AddBrandFormDiv").html(BFAddBrandFormDiv);
    }
    /* 初始化product 表格 */
    var productTable;
    function initDataTable(){
        productTable= $('#table_id_brand').DataTable( {
            "lengthMenu":[5,9,3,-1],
            "language": {
                "url": "/js/bootstrap-3.3.7-dist/css/Chinese.json"
            },
            "searching":false,
            "processing": true,
            "serverSide": true,
            ajax: {
                url: "/brand/toBrandTable.do",
                type: "POST"
            },
            "columns": [
                { "data": "id" },
                { "data": "brandName" },
                { "data": "brandPhoto",
                    "render": function (data, type, row, meta) {
                    console.log(data);
                        return "<img src='"+data+"' width='100px' height='100px'/>";
                    }
                },
                {  "data": "id","render": function ( data, type, row, meta ) {
                        var  huixain = JSON.stringify(row)
                        var  deleteUserById='<button type="button"  class="btn btn-danger"  onclick="deleteBrand('+data+');"><font class="glyphicon glyphicon-trash">刪除</font></button>';
                        var  updateUser="<button type='button'  class='btn btn-primary'  onclick='updateBrand("+huixain+")'><font class='glyphicon glyphicon-plus'>修改</font></button>";
                        var common=deleteUserById+updateUser;
                        return common;
                    } }
            ]
        } );
    }

        /*FileInput的图片上传*/
        function initFileInput(prefix,aftrUrl) {
            $("#"+prefix).fileinput({
                language: 'zh', //设置语言
                uploadUrl:"/brand/addBrandFileInput.do", //上传的地址
                allowedFileExtensions: ['jpg', 'gif', 'png'],//接收的文件后缀
                //uploadExtraData:{"id": 1, "fileName":'123.mp3'},
                allowedFileExtensions : ["jpg","bmp","png","gif","docx","zip","xlsx","txt"],/*上传文件格式限制*/
                uploadAsync: true, //默认异步上传
                showUpload:true, //是否显示上传按钮
                showRemove :true, //显示移除按钮
                showPreview :true, //是否显示预览
                showCaption:false,//是否显示标题
                browseClass:"btn btn-primary", //按钮样式
                dropZoneEnabled: false,//是否显示拖拽区域
                minImageWidth: 0, //图片的最小宽度
                minImageHeight: 0,//图片的最小高度
                maxImageWidth: 1000,//图片的最大宽度
                maxImageHeight: 1000,//图片的最大高度
                maxFileSize:0,//单位为kb，如果为0表示不限制文件大小
                minFileCount: 0,
                maxFileCount:10, //表示允许同时上传的最大文件个数
                //enctype:'multipart/form-data',
                validateInitialCount:true,
                previewFileIcon: "<iclass='glyphicon glyphicon-king'></i>",
                msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
                initialPreviewAsData:true,
                // 默认预览的详细配置，回显时会用到
            }).on("fileuploaded", function (event, data, previewId, index){
                $("#"+aftrUrl,HTaddBrand).val(data.response.url);
            });
        }

</script>
</body>
</html>
