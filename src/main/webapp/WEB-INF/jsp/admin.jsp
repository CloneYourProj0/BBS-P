<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.gem.bbs.entity.User" %>
<%@ page import="com.gem.bbs.entity.Question" %>
<%@ page import="com.gem.bbs.entity.Answer" %>
<%@ page import="com.gem.bbs.entity.User" %>
<%@ page import="com.gem.bbs.entity.Question" %>
<%@ page import="com.gem.bbs.entity.Answer" %>
<%
  User currentUser = (User) session.getAttribute("user");
  if (currentUser == null || !"admin".equals(currentUser.getRole())) {
    response.sendRedirect(request.getContextPath() + "/user/loginPage");
    return;
  }

  // 获取用户列表
  List<User> userList = (List<User>) request.getAttribute("userList");
%>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>管理员管理页面</title>
  <style>
    /* 页面整体布局 */
    body {
      font-family: Arial, sans-serif;
      background-color: #f5f5f5;
      margin: 0;
      padding: 0;
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }

    /* 公共头部样式 */
    .header {
      width: 100%;
      padding: 15px;
      background-color: #6d3c96;
      color: #fff;
      display: flex;
      align-items: center;
      justify-content: space-between;
      box-sizing: border-box;
    }

    .header h1 {
      margin: 0;
      font-size: 20px;
    }

    .header a {
      color: #fff;
      text-decoration: none;
      font-weight: bold;
      padding: 8px 16px;
      background-color: #6d3c96;
      border-radius: 4px;
      transition: background-color 0.3s ease;
    }

    .header a:hover {
      background-color: #6d3c96;
    }

    /* 主内容容器 */
    .container {
      flex: 1;
      width: 100%;
      max-width: 1000px;
      margin: 20px auto;
      padding: 20px;
      background-color: #fff;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      box-sizing: border-box;
    }

    /* 表格样式 */
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
      background-color: #fff;
      border-radius: 8px;
      overflow: hidden;
    }

    th, td {
      padding: 12px;
      text-align: left;
    }

    th {
      background-color: #6d3c96;
      color: white;
    }

    tr:nth-child(even) {
      background-color: #f9f9f9;
    }

    tr:hover {
      background-color: #f1f1f1;
    }

    /* 操作按钮样式 */
    .action-buttons {
      display: flex;
      flex-wrap: wrap;
      gap: 5px;
    }

    .action-buttons a {
      display: inline-block;
      text-decoration: none;
      color: #6d3c96;
      font-weight: bold;
      padding: 6px 12px;
      border: 1px solid #6d3c96;
      border-radius: 4px;
      transition: 0.3s;
    }

    .action-buttons a:hover {
      background-color: #6d3c96;
      color: white;
    }

    /* 添加用户按钮 */
    .add-user {
      display: inline-block;
      margin-top: 20px;
      padding: 10px 20px;
      background-color: #6d3c96;
      color: white;
      border-radius: 4px;
      text-decoration: none;
      font-weight: bold;
      transition: 0.3s;
    }

    .add-user:hover {
      background-color: #6d3c96;
    }
  </style>
</head>
<body>

<!-- 公共头部 -->
<div class="header">
  <h1>管理员管理页面</h1>
  <a href="${pageContext.servletContext.contextPath}/index">返回主页</a>
</div>

<!-- 主内容 -->
<div class="container">
  <h1>欢迎，管理员：<%= currentUser.getUsername() %></h1>

  <!-- 用户列表 -->
  <h2>用户列表</h2>
  <table>
    <thead>
    <tr>
      <th>ID</th>
      <th>登录名</th>
      <th>用户名</th>
      <th>昵称</th>
      <th>邮箱</th>
      <th>创建时间</th>
      <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <% for (User user : userList) { %>
    <tr>
      <td><%= user.getId() %></td>
      <td><%= user.getLoginname() %></td>
      <td><%= user.getUsername() %></td>
      <td><%= user.getNickname() %></td>
      <td><%= user.getEmail() %></td>
      <td><%= user.getCreatetime() %></td>
      <td class="action-buttons">
        <a href="<%= request.getContextPath() %>/admin/editUser?id=<%= user.getId() %>">编辑</a>
        <a href="<%= request.getContextPath() %>/admin/deleteUser?id=<%= user.getId() %>">删除</a>
        <a href="<%= request.getContextPath() %>/admin/viewUserPosts?id=<%= user.getId() %>">查看帖子</a>
        <a href="<%= request.getContextPath() %>/admin/viewUserAnswers?id=<%= user.getId() %>">查看回复</a>
      </td>
    </tr>
    <% } %>
    </tbody>
  </table>

  <!-- 添加新用户按钮 -->
  <a href="<%= request.getContextPath() %>/admin/addUser" class="add-user">添加新用户</a>

  <!-- 帖子列表 -->
  <%
    List<Question> questionList = (List<Question>) request.getAttribute("questionList");
    if (questionList != null) {
  %>
  <h2>用户ID为<%= request.getAttribute("selectedUserId") %>的帖子列表</h2>
  <table>
    <thead>
    <tr>
      <th>帖子ID</th>
      <th>标题</th>
      <th>描述</th>
      <th>金币</th>
      <th>创建时间</th>
      <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <% for (Question question : questionList) { %>
    <tr>
      <td><%= question.getId() %></td>
      <td><%= question.getTitle() %></td>
      <td><%= question.getDescription() %></td>
      <td><%= question.getCoin() %></td>
      <td><%= question.getCreatetime() %></td>
      <td class="action-buttons">
        <a href="<%= request.getContextPath() %>/admin/editQuestion?id=<%= question.getId() %>">编辑</a>
        <a href="<%= request.getContextPath() %>/admin/deleteQuestion?id=<%= question.getId() %>">删除</a>
      </td>
    </tr>
    <% } %>
    </tbody>
  </table>
  <% } %>

  <!-- 回复列表 -->
  <%
    List<Answer> answerList = (List<Answer>) request.getAttribute("answerList");
    if (answerList != null) {
  %>
  <h2>用户ID为<%= request.getAttribute("selectedUserId") %>的回复列表</h2>
  <table>
    <thead>
    <tr>
      <th>回复ID</th>
      <th>内容</th>
      <th>帖子ID</th>
      <th>是否采纳</th>
      <th>点赞数</th>
      <th>创建时间</th>
      <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <% for (Answer answer : answerList) { %>
    <tr>
      <td><%= answer.getId() %></td>
      <td><%= answer.getContent() %></td>
      <td><%= answer.getQuestionId() %></td>
      <td><%= "1".equals(answer.getIsAccept()) ? "是" : "否" %></td>
      <td><%= answer.getLikes() %></td>
      <td><%= answer.getCreatetime() %></td>
      <td class="action-buttons">
        <a href="<%= request.getContextPath() %>/admin/editAnswer?id=<%= answer.getId() %>">编辑</a>
        <a href="<%= request.getContextPath() %>/admin/deleteAnswer?id=<%= answer.getId() %>">删除</a>
      </td>
    </tr>
    <% } %>
    </tbody>
  </table>
  <% } %>
</div>

</body>
</html>



