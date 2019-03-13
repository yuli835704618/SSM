<%@ page import="java.io.File" %>
<%

    String path = request.getContextPath();
    String basePath = request.getScheme() + ":" +File.separator+ request.getServerName() + ":" + request.getServerPort() + path + File.separator;
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>
</head>
<script src="static/jquery-3.3.1.min.js"></script>
<body>
<div id="root">
    <%--<input type="button"  value="点击" v-on:click="down()"/>
    <ul>
        <li v-for="item in arr">{{item}}</li>
    </ul>--%>
    <button id="but" onclick="down()">点击</button>
</div>
<script>
    function down() {
            $.ajax({
                url:"user/show",
                type:"post",
                dataType:"json",
                success:function(data){
                    console.log(data)
                }
            })
    }

</script>
</body>
</html>
