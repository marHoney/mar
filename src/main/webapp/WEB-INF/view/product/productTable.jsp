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
    <title>product</title>
<jsp:include page="/common/commonCSS.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/common/test.jsp"></jsp:include>

<div class="container">
    <%--第一行  條件查詢--%>
    <div class="row">
        <div class="panel panel-info">
            <div class="panel-heading">商品查詢</div>
            <div class="panel-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">商品名稱</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="Search_productName" placeholder="請輸入商品名稱...">
                        </div>
                        <label  class="col-sm-2 control-label">商品價格</label>
                        <div class="col-sm-4">
                            <div class="input-group">
                            <input type="text" id="Search_minPrice" class="form-control" placeholder="最小商品價格..." >
                            <span class="input-group-addon" ><font class="glyphicon glyphicon-yen"></font></span>
                            <input type="text" id="Search_maxPrice" class="form-control" placeholder="最大商品價格...">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                    <label  class="col-sm-2 control-label">薪資範圍</label>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <input type="text" class="form-control" id="Search_minProductDate" placeholder="最小商品生產日期...">
                            <span class="input-group-addon" ><font class="glyphicon glyphicon-yen"></font></span>
                            <input type="text" class="form-control" id="Search_maxProductDate" placeholder="最大商品生產日期...">
                        </div>
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
                <button type="button" class="btn btn-primary" onclick="addProduct()"><font class="glyphicon glyphicon-plus">增加</font> </button>
                <button type="button" class="btn btn-danger" onclick="deleteProductBatches()"><font class="glyphicon glyphicon-trash">批量刪</font></button>
            </div>
        </div>
    </div>
    <%--datatable--%>
    <div class="row">
        <div class="panel panel-info">
            <div class="panel-heading">商品列表</div>
            <div class="panel-body">
                <table id="table_id_product" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                    <tr>
                        <th>id</th>
                        <th>商品名稱</th>
                        <th>商品價格</th>
                        <th>商品圖片</th>
                        <th>商品日期</th>
                        <th>是否熱銷</th>
                        <th>是否上架</th>
                        <th>商品縂庫存</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tfoot>
                    <tr>
                        <th>id</th>
                        <th>商品名稱</th>
                        <th>商品價格</th>
                        <th>商品圖片</th>
                        <th>商品日期</th>
                        <th>是否熱銷</th>
                        <th>是否上架</th>
                        <th>商品縂庫存</th>
                        <th>操作</th>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
       <%-- /* 品牌增加 */--%>
    <div id="AddProductFormDiv" style="display: none;">
        <form class="form-horizontal" >
            <div class="form-group">
                <label  class="col-sm-2 control-label">品牌名</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="Add_productName"  placeholder="請輸入品牌名...">
                </div>
            </div>
            <div class="form-group">
                <label  class="col-sm-2 control-label">品牌價格</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="Add_price"  placeholder="請輸入品牌名...">
                </div>
            </div>
            <div class="form-group">
                <label  class="col-sm-2 control-label">圖片</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="Add_productPhoto"  placeholder="請添加圖片...">
                </div>
            </div>
            <div class="form-group">
                <label  class="col-sm-2 control-label">品牌時間</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="Add_productDate"  placeholder="請輸入品牌時間...">
                </div>
            </div>
            <div class="form-group">
                <label  class="col-sm-2 control-label">是否熱銷</label>
                <div class="col-sm-4">
                    <input type="radio" name="Add_isHot" value="0" placeholder="請輸入品牌名...">是
                    <input type="radio"  name="Add_isHot" value="1"  placeholder="請輸入品牌名...">否
                </div>
            </div>
            <div class="form-group">
                <label  class="col-sm-2 control-label">是否上架</label>
                <div class="col-sm-4">
                    <input type="radio" name="Add_isUp" value="0"  placeholder="請輸入品牌名...">是
                    <input type="radio"  name="Add_isUp" value="1" placeholder="請輸入品牌名...">否
                </div>
            </div>
            <div class="form-group">
                <label  class="col-sm-2 control-label">縂庫存</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="Add_productCount"  placeholder="請輸入縂庫存...">
                </div>
            </div>
        </form>
    </div>
        <%-- /* 品牌修改 */--%>
    <div id="UpdateProductFormDiv" style="display: none;">
        <form class="form-horizontal" >
            <div class="form-group">
                <label  class="col-sm-2 control-label">品牌名</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="Update_productName"  placeholder="請修改品牌名...">
                </div>
            </div>
            <div class="form-group">
                <label  class="col-sm-2 control-label">品牌價格</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="Update_price"  placeholder="請修改品牌名...">
                </div>
            </div>
            <div class="form-group">
                <label  class="col-sm-2 control-label">圖片</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="Update_productPhoto"  placeholder="請修改圖片...">
                </div>
            </div>
            <div class="form-group">
                <label  class="col-sm-2 control-label">品牌時間</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="Update_productDate"  placeholder="請修改品牌時間...">
                </div>
            </div>
        </form>
    </div>
</div>
<%--  js  --%>
<jsp:include page="/common/commonJS.jsp"></jsp:include>
<script>
    var BFAddProductFormDiv;
    var BFUpdateProductFormDiv;
    $(function () {
        //這是備份 爲了 下次點擊 添加能夠 把彈出框 會先出來
        BFAddProductFormDiv=$("#AddProductFormDiv").html();
        BFUpdateProductFormDiv=$("#UpdateProductFormDiv").html();
        initDataTable();
        //時間插件
        initFormDate();
        initSearchDate();
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


    /* 初始化 search 的時間插件 */
    function initSearchDate() {
        $('#Search_minProductDate').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-CN',
            showClear: true
        });
        $('#Search_maxProductDate').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-CN',
            showClear: true
        });
    }
    
    /* 條件查詢 */
    function search() {
       var s_productName= $("#Search_productName").val();
       var s_minPrice= $("#Search_minPrice").val();
       var s_maxPrice= $("#Search_maxPrice").val();
       var s_minProductDate= $("#Search_minProductDate").val();
       var s_minProductDate= $("#Search_maxProductDate").val();

       var V_Search  ={};
        V_Search.productName =s_productName;
        V_Search.minPrice =s_minPrice;
        V_Search.maxPrice =s_maxPrice;
        V_Search.minProductDate =s_minProductDate;
        V_Search.maxProductDate =s_minProductDate;

        productTable.settings()[0].ajax.data = V_Search;
        productTable.ajax.reload();
    }
    /* 刪除 */
    function deleteProduct(id) {
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
                        url:"/product/deleteProduct.do",
                        type:"post",
                        data:{"id":id},
                        success:function (result) {
                            if(result.code == 200){
                                // 刷新
                                search();
                            }
                        }
                    });
                }
            }
        });

    }
    /* 修改 */
    var HTupdateProduct;
    function updateProduct(row) {
         $("#Update_productName").val(row.productName);
         $("#Update_price").val(row.price);
         $("#Update_productPhoto").val(row.productPhoto);
         $("#Update_productDate").val(row.productDate);
       HTupdateProduct =  bootbox.dialog({
            title: '品牌添加',
            message: $("#UpdateProductFormDiv form"),
            size: 'large',
            buttons: {
                cancel: {
                    label: "取消",
                    className: 'btn-danger'
                },
                ok: {
                    label: "確認",
                    className: 'btn-info',
                    callback: function(){
                        var v_productName=   $("#Update_productName",HTupdateProduct).val();
                        var v_productPrice=  $("#Update_price",HTupdateProduct).val();
                        var v_productPhoto=  $("#Update_productPhoto",HTupdateProduct).val();
                        var v_productDate=  $("#Update_productDate",HTupdateProduct).val();

                        var productData ={};
                        productData.id  =row.id;
                        productData.productName  =v_productName;
                        productData.price        =v_productPrice;
                        productData.productPhoto =v_productPhoto;
                        productData.productDate   =v_productDate;
                        $.ajax({
                            url:"/product/updateProduct.do",
                            type:"post",
                            data:productData,
                            success:function (result) {
                                if(result.code == 200){
                                    search();
                                }
                            }
                        });//增加
                    }
                }
            }
        });
        $("#UpdateProductFormDiv").html(BFUpdateProductFormDiv)
        initFormDate();
    }
    /* 增加  這個全局變量 是爲了 限制 form 表單中的值 */
    var HTaddProduct;
    function addProduct() {
     HTaddProduct= bootbox.dialog({
            title: '品牌添加',
            message: $("#AddProductFormDiv form"),
            size: 'large',
            buttons: {
                cancel: {
                    label: "取消",
                    className: 'btn-danger'
                },
                ok: {
                    label: "確認",
                    className: 'btn-info',
                    callback: function(){
                       var v_productName=   $("#Add_productName",HTaddProduct).val();
                       var v_productPrice=  $("#Add_price",HTaddProduct).val();
                       var v_productPhoto=  $("#Add_productPhoto",HTaddProduct).val();
                       var v_productDate=  $("#Add_productDate",HTaddProduct).val();
                       var v_productCount=  $("#Add_productCount",HTaddProduct).val();

                       var productData ={};
                        productData.productName  =v_productName;
                        productData.price        =v_productPrice;
                        productData.productPhoto =v_productPhoto;
                        productData.productDate   =v_productDate;
                        productData.productCount   =v_productCount;
                          $.ajax({
                              url:"/product/addProduct.do",
                              type:"post",
                              data:productData,
                              success:function (result) {
                                  if(result.code == 200){
                                      search();
                                  }
                              }
                          });//增加
                    }
                }
            }
        });
        $("#AddProductFormDiv").html(BFAddProductFormDiv);
        initFormDate();
    }
    /* 時間插件 from 中的 */
    function initFormDate() {
        $('#Add_productDate').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-CN',
            showClear: true
        });$('#Update_productDate').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-CN',
            showClear: true
        });

    }

    function updateIsUp(row) {
        var up=row.isUp;
        if(up ==1 ){
            up=0;
        }else{
            up=1;
        }
        console.log(up);
        $.ajax({
            url:"/product/updateProductIsUp.do",
            type:"post",
            data:{id:row.id,isUp:up},
            success:function (result) {
                if(result.code == 200){
                    search();
                }
            }
        });
    }


    /* 批量刪除 */
    function deleteProductBatches() {
    }
    /* 初始化product 表格 */
    var productTable;
    function initDataTable(){
        productTable= $('#table_id_product').DataTable( {
            "lengthMenu":[5,9,3,-1],
            "language": {
                "url": "/js/bootstrap-3.3.7-dist/css/Chinese.json"
            },
            "searching":false,
            "processing": true,
            "serverSide": true,
            ajax: {
                url: "/product/toProductTable.do",
                type: "POST"
            },
            "columns": [
                { "data": "id" },
                { "data": "productName" },
                { "data": "price" },
                { "data": "productPhoto" },
                { "data": "productDate" },
                { "data": "isHot" ,
               "render":function (a,b,c,d) {
                        return a == 0 ? "是" : "否";
                     }
                 },
                { "data": "isUp",
                    "render":function (a,b,c,d) {
                        return a==0?"是":"否";
                     }
                },
                { "data": "productCount"},
                {  "data": "id","render": function ( data, type, row, meta ) {
                        var  huixain = JSON.stringify(row)
                        var isup=JSON.stringify(row.isUp);
                        var  deleteUserById='<button type="button"  class="btn btn-danger"  onclick="deleteProduct('+data+');"><font class="glyphicon glyphicon-trash">刪除</font></button>';
                        var  updateUser="<button type='button'  class='btn btn-success'  onclick='updateProduct("+huixain+")'><font class='glyphicon glyphicon-plus'>修改</font></button>";

                        if(isup==0){
                            var  updateIsUp="<button type='button'  class='btn btn-info'  onclick='updateIsUp("+huixain+")' ><font class='glyphicon glyphicon-arrow-down ' >下架</font></button>";
                        }else{
                            var  updateIsUp="<button type='button'  class='btn btn-warning'  onclick='updateIsUp("+huixain+")' ><font class='glyphicon glyphicon-arrow-up' >上架</font></button>";
                        }

                        var common=deleteUserById+updateUser+updateIsUp;
                        return common;
                    } }
            ]
        } );
    }

</script>
</body>
</html>
