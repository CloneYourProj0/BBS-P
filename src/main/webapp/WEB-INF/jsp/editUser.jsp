<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.gem.bbs.entity.User" %>
<%
  User user = (User) request.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>编辑用户</title>
  <!-- 引入 layui.css -->
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/layui/css/layui.css">
  <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/global.css">
  <script src="${pageContext.servletContext.contextPath}/assets/layui/layui.js"></script>
  <style>
    body {
      background-color: #f5f5f5;
      font-family: Arial, sans-serif;
    }
    .layui-container {
      margin-top: 50px;
      background: #ffffff;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      max-width: 600px;
      margin-left: auto;
      margin-right: auto;
    }
    h1 {
      font-size: 24px;
      color: #333;
      text-align: center;
      margin-bottom: 20px;
    }
    .layui-form-item label {
      font-weight: bold;
      color: #555;
    }
    .layui-input {
      border-radius: 4px;
      box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
    }
    .layui-btn {
      background-color: #1e9fff;
      color: #fff;
      border-radius: 4px;
      width: 100%;
      font-size: 16px;
    }
    .layui-btn:hover {
      background-color: #1599e8;
    }

    /*返回键的*/
    .layui-btn {
      background-color: #1e9fff;
      color: #fff;
      border-radius: 4px;
      width: 48%;
      font-size: 16px;
    }
    .layui-btn-primary {
      background-color: #e0e0e0;
      color: #333;
      border-radius: 4px;
      width: 48%;
      font-size: 16px;
    }
    .button-group {
      display: flex;
      justify-content: space-between;
    }
    .button-group .layui-btn {
      width: 48%;
    }

  </style>
</head>
<body>
<%--公共头部开始--%>
<jsp:include page="/WEB-INF/jsp/common/head.jsp"></jsp:include>
<%--公共头部结束--%>
<div class="layui-container">
  <h1>编辑用户信息</h1>
  <form class="layui-form" action="<%= request.getContextPath() %>/admin/updateUser" method="post">
    <input type="hidden" name="id" value="<%= user.getId() %>"/>
    <div class="layui-form-item">
      <label class="layui-form-label">登录名</label>
      <div class="layui-input-block">
        <input type="text" name="loginname" required lay-verify="required" placeholder="请输入登录名" autocomplete="off" class="layui-input" value="<%= user.getLoginname() %>">
      </div>
    </div>
    <div class="layui-form-item">
      <label class="layui-form-label">用户名</label>
      <div class="layui-input-block">
        <input type="text" name="username" required lay-verify="required" placeholder="请输入用户名" autocomplete="off" class="layui-input" value="<%= user.getUsername() %>">
      </div>
    </div>
    <div class="layui-form-item">
      <label class="layui-form-label">昵称</label>
      <div class="layui-input-block">
        <input type="text" name="nickname" required lay-verify="required" placeholder="请输入昵称" autocomplete="off" class="layui-input" value="<%= user.getNickname() %>">
      </div>
    </div>
    <div class="layui-form-item">
      <label class="layui-form-label">邮箱</label>
      <div class="layui-input-block">
        <input type="email" name="email" required lay-verify="required|email" placeholder="请输入邮箱" autocomplete="off" class="layui-input" value="<%= user.getEmail() %>">
      </div>
    </div>
    <div class="layui-form-item">
      <div class="layui-input-block">
        <button class="layui-btn" lay-submit lay-filter="formDemo">更新</button>
        <button type="button" class="layui-btn layui-btn-primary" id="backButton">返回</button>
      </div>
    </div>
  </form>
</div>

<!-- 引入 layui.js -->
<script src="https://cdn.jsdelivr.net/npm/layui@2.7.6/dist/layui.js"></script>
<script>
  layui.use(['form'], function(){
    var form = layui.form;

    // 自定义验证规则
    form.verify({
      username: function(value){
        if(value.length < 1){
          return '用户名至少得1个字符';
        }
      },
      email: function(value){
        if(!/^([a-zA-Z0-9_\.\-])+\@([a-zA-Z0-9\-])+\.([a-zA-Z]{2,4})$/.test(value)){
          return '请输入有效的邮箱地址';
        }
      }
    });

    // 监听提交事件
    form.on('submit(editUserForm)', function(data){
      // 提交时获取表单数据
      var formData = data.field;

      // 发送Ajax请求到后端
      $.ajax({
        url: '${pageContext.servletContext.contextPath}/admin/saveUser', // 提交的URL
        type: 'POST',
        data: formData,
        success: function(response) {
          if(response.success) {
            layer.msg('保存成功', {icon: 1, time: 2000}, function(){
              // 关闭当前窗口，或者刷新父页面
              var index = parent.layer.getFrameIndex(window.name);
              parent.layer.close(index);
              parent.location.reload();
            });
          } else {
            layer.msg('保存失败: ' + response.message, {icon: 2});
          }
        },
        error: function() {
          layer.msg('请求失败，请稍后再试', {icon: 2});
        }
      });

      return false; // 阻止表单跳转。如果需要表单跳转，去掉这行即可。
    });
  });
  // 返回按钮点击事件
  document.getElementById('backButton').addEventListener('click', function(){
    window.history.back();
  });

</script>
</body>
</html>
