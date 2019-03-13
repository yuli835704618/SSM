<%@ page import="java.io.File" %>
<%

    String path = request.getContextPath();
    String basePath = request.getScheme() + ":" + File.separator + File.separator + request.getServerName() + ":" + request.getServerPort() + path + File.separator;
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>
    <link rel="stylesheet" href="static/bootstrap-3.3.7-dist/css/bootstrap.css">
    <link rel="stylesheet" href="static/dist/bootstrap-table.css">
    <script src="static/jquery-3.3.1.min.js" type="text/javascript"></script>
    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="static/dist/bootstrap-table.js" type="text/javascript"></script>
    <script src="static/dist/locale/bootstrap-table-zh-CN.js" type="text/javascript"></script>
</head>
<body>
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">添加用户</h4>
            </div>
            <div class="modal-body">
                <form id="addForm">
                    用户名:&nbsp;&nbsp;&nbsp;&nbsp;<input id="addUserName" type="text" name="userName"><br/><br/>
                    密码:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input id="addPassword" type="password"
                                                                              name="password"><br/><br/>
                    邮箱:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="email" id="addMail"
                                                                              name="mail"><br/><br/>
                    电话号码:<input type="text" id="addPhone" name="phone"><br/><br/>
                    个人说明:<input type="text" id="addDescription" name="description">
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" onclick="addUser()" class="btn btn-primary">提交更改</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<div class="modal fade" id="upModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel1">修改用户信息</h4>
            </div>
            <div class="modal-body">
                <form id="upForm">
                    <input type="hidden" id="userId" name="userId">
                    用户名:&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="userName" name="userName"><br/><br/>
                    邮箱:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="email" id="mail"
                                                                              name="mail"><br/><br/>
                    电话号码:<input type="text" id="phone" name="phone"><br/><br/>
                    个人说明:<input type="text" id="description" name="description">
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" onclick="upUser()" class="btn btn-primary">提交更改</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<div class="panel panel-default">
    <div class="panel-heading">
        查询条件
    </div>
    <div class="panel-body form-group" style="margin-bottom:0px;">
        <label class="col-sm-1 control-label" style="text-align: right; margin-top:5px">姓名：</label>
        <div class="col-sm-2">
            <input type="text" class="form-control" name="Name" id="search_name"/>
        </div>
        <label class="col-sm-1 control-label" style="text-align: right; margin-top:5px">手机号：</label>
        <div class="col-sm-2">
            <input type="text" class="form-control" name="Name" id="search_tel"/>
        </div>
        <div class="col-sm-1 col-sm-offset-4">
            <button class="btn btn-primary" id="search_btn">查询</button>
        </div>
    </div>
</div>
<table id="mytab" class="table table-hover"></table>
<div id="toolbar" class="btn-group pull-right" style="margin-right: 20px;">
    <input type="button" value="新增用户" id="addUser" data-toggle="modal" data-target="#addModal"
           class="btn btn-primary"></input>
    <input type="button" value="修改用户" id="editBtn" data-toggle="modal" <%--data-target="#upModal"--%>
           class="btn btn-primary" onclick="update()"></input>
    <input type="button" value="删除用户" id="deleteBtn" data-toggle="modal" class="btn btn-primary"
           onclick="delUser()"></input>
</div>
<script>
    function getall() {
        $.ajax({
            url: "blog/find",
            type: "post",
            dataType: "json",
            success: function (data) {
                console.log(data)
            }
        })
    }


    $(function () {
        //创建bootstrapTable
        $("#mytab").bootstrapTable({
            method: "POST",
            //极为重要，缺失无法执行queryParams，传递page参数
            contentType: "application/x-www-form-urlencoded",
            dataType: "json",
            url: 'user/show',
            queryParams: queryParam,
            pagination: true,//显示分页条：页码，条数等
            striped: true,//隔行变色
            pageNumber: 1,//首页页码
            pageSize: 10,//分页，页面数据条数
            uniqueId: "bId",//Indicate an unique identifier for each row
            sidePagination: "server",//在服务器分页
            responseHandler: responseHandler,
            height: 500,
            toolbar: "#toolbar",//工具栏
            columns: [{
                checkbox: "true",
                field: "box"
            }, {
                title: "ID",
                field: "bId",
                visible: false
            }, {
                title: "用户姓名",
                field: "userName"
            }, {
                title: "邮箱",
                field: "mail"
            }, {
                title: "电话号码",
                field: "phone"
            }, {
                title: "个人说明",
                field: "description"
            }
            ],
            showRefresh: true,//刷新
        });


    })

    function responseHandler(res) {
        console.log(res);
        if (res) {
            return {
                "rows": res.result.list,
                "total": res.result.total
            };
        } else {
            return {
                "rows": [],
                "total": 0
            };
        }
    }

    function queryParam(params) {
        var param = {
            limit: this.limit, // 页面大小
            offset: this.offset, // 页码
            pageNumber: this.pageNumber,
            pageSize: this.pageSize
        };
        return param;
    }

    function addUser() {
        if($("#addUserName").val() == '' || $("#addMail").val() == ''){
            alert("密码和邮箱必填")
        }else{
            var p = $("#addForm").serializeArray();
            $.ajax({
                url: "user/add",
                type: "post",
                data: p,
                dataType: "json",
                success: function (data) {
                    $("#mytab").bootstrapTable('refresh');
                    $("#addModal").modal("hide");
                }
            })
        }
    }

    function upUser() {
        var p = $("#upForm").serializeArray();
        $.ajax({
            url: "user/update",
            type: "post",
            data: p,
            dataType: "json",
            success: function (data) {
                $("#mytab").bootstrapTable('refresh');
                $("#upModal").modal("hide");
            }
        })
    }

    function update() {
        var rows = $("#mytab").bootstrapTable('getSelections');
        if (rows.length > 1) {
            alert("不能一次修改多个");
        }
        if (rows.length == 0) {
            alert("请选择某个用户进行修改");
        }
        if (rows.length == 1) {
            console.log(rows[0].userId);
            $("#userId").val(rows[0].userId);
            $("#userName").val(rows[0].userName);
            $("#mail").val(rows[0].mail);
            $("#phone").val(rows[0].phone);
            $("#description").val(rows[0].description);
            $("#upModal").modal("show");
        }

    }

    function delUser() {
        var rows = $("#mytab").bootstrapTable('getSelections');
        var str = "";
        for (i in rows) {
            var id = rows[i].userId;
            str += id + ","
            console.log(str);

        }

        $.ajax({
            url: "user/delete",
            type: "post",
            data: {"val": str},
            dataType: "json",
            success: function (data) {
                $("#mytab").bootstrapTable('refresh');
            }
        })
    }

    $("#addDescription").blur(function () {
        if ($("#addDescription").val() == '') {
            $("#addDescription").val("个人说明,100字以内");
        }
    });

    if ($("#addDescription").val() == '') {
        $("#addDescription").val("个人说明,100字以内");
    }

    if ($("#addDescription").val() == '个人说明,100字以内')  //如果值为提示信息，获得焦点时，清空提示信息，样式说明在此省略
    {
        $("#addDescription").focus(function () {
            $("#addDescription").val("");
        });
    }

    $("#addPhone").blur(function () {
        if ($("#addPhone").val() == '') {
            $("#addPhone").val("请输入手机号码");
        }
    });

    if ($("#addPhone").val() == '') {
        $("#addPhone").val("请输入手机号码");
    }

    if ($("#addPhone").val() == '请输入手机号码')  //如果值为提示信息，获得焦点时，清空提示信息，样式说明在此省略
    {
        $("#addPhone").focus(function () {
            $("#addPhone").val("");
        });
    }

    $("#addUserName").blur(function () {
        if ($("#addUserName").val() == '') {
            $("#addUserName").val("请输入用户名");
        }
    });

    if ($("#addUserName").val() == '') {
        $("#addUserName").val("请输入用户名");
    }

    if ($("#addUserName").val() == '请输入用户名')  //如果值为提示信息，获得焦点时，清空提示信息，样式说明在此省略
    {
        $("#addUserName").focus(function () {
            $("#addUserName").val("");
        });
    }


</script>
</body>
</html>
