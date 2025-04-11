<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.gem.bbs.entity.Question" %>
<%
  Question question = (Question) request.getAttribute("question");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>编辑帖子</title>
  <!-- 引入 layui.css -->
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/layui-2.8.0/src/css/layui.css">
  <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/global.css">
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
      max-width: 700px;
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
    .layui-input, .layui-textarea {
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
<%-- 公共头部开始 --%>
<jsp:include page="/WEB-INF/jsp/common/head.jsp"></jsp:include>
<%-- 公共头部结束 --%>

<div class="layui-container">
  <h1>编辑帖子</h1>
  <form class="layui-form" action="<%= request.getContextPath() %>/admin/updateQuestion" method="post" id="editQuestionForm">
    <input type="hidden" name="id" value="<%= question.getId() %>"/>

    <div class="layui-form-item">
      <label class="layui-form-label">标题</label>
      <div class="layui-input-block">
        <input type="text" name="title" required lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input" value="<%= question.getTitle() %>">
      </div>
    </div>

    <div class="layui-form-item">
      <label class="layui-form-label">描述</label>
      <div class="layui-input-block">
        <textarea name="description" required lay-verify="required" placeholder="请输入描述" autocomplete="off" class="layui-textarea"><%= question.getDescription() %></textarea>
      </div>
    </div>

    <div class="layui-form-item">
      <label class="layui-form-label">是否置顶</label>
      <div class="layui-input-block">
        <input type="radio" name="isUp" lay-filter="isUpCheckbox" value="1" <%= (question.getIsUp() != null && question.getIsUp().equals("1")) ? "checked" : "" %> title="置顶">
        <input type="radio" name="isUp" lay-filter="noUpCheckbox" value="0" <%= (question.getIsUp() != null && question.getIsUp().equals("0")) ? "checked" : "" %> title="取消置顶">
<%--        <input type="hidden" id="isUpHidden" name="isUp" value="<%= (question.getIsUp() != null && question.getIsUp().equals("1")) ? "1" : "0" %>"/>--%>
      </div>
    </div>


    <div class="layui-form-item">
      <label class="layui-form-label">金币</label>
      <div class="layui-input-block">
        <input type="number" name="coin" required lay-verify="number" placeholder="请输入金币数量" autocomplete="off" class="layui-input" value="<%= question.getCoin() %>">
      </div>
    </div>

    <div class="layui-form-item">
      <div class="layui-input-block">
        <button class="layui-btn" lay-submit lay-filter="editQuestion">更新</button>
        <button type="button" class="layui-btn layui-btn-primary" id="backButton">返回</button>
      </div>
    </div>
  </form>
</div>

<!-- 引入 layui.js -->
<script src="${pageContext.servletContext.contextPath}/assets/layui-2.8.0/src/layui.js"></script>
<script>
  layui.use(['form', 'layer'], function(){
    var form = layui.form;
    var layer = layui.layer;

    // 自定义验证规则
    form.verify({
      title: function(value){
        if(value.length < 1){
          return '标题至少得1个字符';
        }
      },
      description: function(value){
        if(value.length < 5){
          return '描述至少得5个字符';
        }
      },
      number: [/^\d+$/, '请输入有效的数字']
    });
    form.on('radio', function(data){
      console.log(data);
    });

    // 监听提交事件
    form.on('submit(editQuestion)', function(data){
      // 获取表单数据
      var formData = data.field;

      // 发送Ajax请求到后端
      $.ajax({
        url: '<%= request.getContextPath() %>/admin/updateQuestion', // 提交的URL
        type: 'POST',
        data: formData,
        success: function(response) {
          if(response.success) {
            layer.msg('更新成功', {icon: 1, time: 2000}, function(){
              // 刷新页面或跳转到其他页面
              window.location.href = '<%= request.getContextPath() %>/admin/viewUserPosts';
            });
          } else {
            // 显示后端返回的错误信息
            layer.msg('更新失败: ' + (response.message || '未知错误'), {icon: 2});
          }
        },
        error: function() {
          layer.msg('请求失败，请稍后再试', {icon: 2});
        }
      });

      return false; // 阻止表单跳转
    });

  // 返回按钮点击事件
  document.getElementById('backButton').addEventListener('click', function(){
    window.history.back();
  });
  });

</script>
</body>
</html>
