<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 2024/11/3
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        $('#submitForm').on('submit', function(event) {
            event.preventDefault(); // 阻止默认表单提交

            $.ajax({
                url: 'gpt', // 发送请求的URL
                type: 'POST', // 请求类型
                data: $(this).serialize(), // 表单数据序列化
                success: function(response) {
                    $('#result').html(response); // 处理成功的返回
                },
                error: function(xhr, status, error) {
                    console.error(error); // 处理错误
                }
            });
        });
    });
</script>
<body>
<form id="submitForm">
    <input type="text" name="inputData" placeholder="请输入数据" required>
    <button type="submit">提交</button>
</form>
<div id="result"></div>
<h1>${message}</h1>
</body>
</html>
