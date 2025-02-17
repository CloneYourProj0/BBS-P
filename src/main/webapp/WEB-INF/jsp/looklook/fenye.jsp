<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 2024/11/9
  Time: 19:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>用户个人资料</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <!-- 引入 layui CSS -->
  <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/layui/css/layui.css">
  <!-- 引入自定义全局 CSS -->
  <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/global.css">
  <!-- 引入 layui JS -->
  <script src="${pageContext.servletContext.contextPath}/assets/layui/layui.js"></script>
  <!-- 引入 jQuery（如果需要） -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<%-- 公共头部开始 --%>
<jsp:include page="/WEB-INF/jsp/common/head.jsp"></jsp:include>
<%-- 公共头部结束 --%>

<div class="main layui-clear">
  <div class="wrap">
    <!-- 个人信息部分 -->
    <div class="layui-col-md4">
      <div class="layui-card">
        <div class="layui-card-header">
          <i class="layui-icon layui-icon-user"></i> 个人信息
        </div>
        <div class="layui-card-body">
          <form class="layui-form">
            <div class="layui-form-item">
              <label class="layui-form-label">用户名</label>
              <div class="layui-input-block">
                <input type="text" value="${userData.loginname}" class="layui-input" readonly>
              </div>
            </div>
            <div class="layui-form-item">
              <label class="layui-form-label">邮箱</label>
              <div class="layui-input-block">
                <input type="text" value="${userData.email}" class="layui-input" readonly>
              </div>
            </div>
            <div class="layui-form-item">
              <label class="layui-form-label">注册时间</label>
              <div class="layui-input-block">
                <input type="text" value="${userData.registrationDate}" class="layui-input" readonly>
              </div>
            </div>
            <div class="layui-form-item">
              <div class="layui-input-block">
                <button type="button" class="layui-btn layui-btn-normal layui-btn-sm" onclick="editProfile()">编辑资料</button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- 我的提问与我的回答部分 -->
    <div class="layui-col-md8">
      <!-- 使用 layui 的 Tab 组件 -->
      <div class="layui-tab" lay-filter="profileTab">
        <ul class="layui-tab-title">
          <li class="layui-this">我的提问</li>
          <li>我的回答</li>
        </ul>
        <div class="layui-tab-content">
          <!-- 我的提问内容 -->
          <div class="layui-tab-item layui-show">
            <div class="layui-card-body">
              <c:if test="${not empty questionList}">
                <table class="layui-table">
                  <colgroup>
                    <col width="50%">
                    <col width="30%">
                    <col width="20%">
                  </colgroup>
                  <thead>
                  <tr>
                    <th>提问标题</th>
                    <th>提问时间</th>
                    <th>操作</th>
                  </tr>
                  </thead>
                  <tbody>
                  <c:forEach items="${questionList}" var="question">
                    <tr>
                      <td>${question.title}</td>
                      <td>${question.createTime}</td>
                      <td>
                        <button class="layui-btn layui-btn-primary layui-btn-sm"
                                onclick="window.location='${pageContext.servletContext.contextPath}/ques/detail?id=${question.id}'">
                          查看详情
                        </button>
                      </td>
                    </tr>
                  </c:forEach>
                  </tbody>
                </table>
              </c:if>
              <c:if test="${empty questionList}">
                <div class="fly-none">您还没有提问过任何问题。</div>
              </c:if>

              <!-- 分页部分（我的提问） -->
              <div id="paginationQ" style="text-align: center; margin-top: 20px;"></div>
              <script>
                layui.use(['laypage'], function(){
                  var laypage = layui.laypage;

                  laypage.render({
                    elem: 'paginationQ' // 分页容器的ID
                    ,count: ${totalQuestions} // 总数据条数
                    ,limit: 10 // 每页显示的条数
                    ,curr: ${currentPageQ} // 当前页
                    ,layout: ['prev', 'page', 'next', 'count']
                    ,jump: function(obj, first){
                      if(!first){
                        // 切换页码时，保持当前选中的 Tab
                        window.location.href = "${pageContext.servletContext.contextPath}/profile?id=${userData.id}&pageQ=" + obj.curr + "&pageA=${currentPageA}";
                      }
                    }
                  });
                });
              </script>
              <!-- 分页结束 -->
            </div>
          </div>

          <!-- 我的回答内容 -->
          <div class="layui-tab-item">
            <div class="layui-card-body">
              <c:if test="${not empty Answerlist}">
                <table class="layui-table">
                  <colgroup>
                    <col width="50%">
                    <col width="30%">
                    <col width="20%">
                  </colgroup>
                  <thead>
                  <tr>
                    <th>问题</th>
                    <th>回答时间</th>
                    <th>操作</th>
                  </tr>
                  </thead>
                  <tbody>
                  <c:forEach items="${Answerlist}" var="answer">
                    <tr>
                      <td>${answer.questionTitle}</td>
                      <td>${answer.createTime}</td>
                      <td>
                        <c:set var="content" value="${answer.content}" scope="page"/>
                        <%
                          String content = (String) pageContext.getAttribute("content");
                          // 移除 HTML 标签
                          String cleanContent = content.replaceAll("<[^>]*>", ""); // 使用正则表达式移除 HTML 标签

                          // 转义特殊字符以防止 JavaScript 注入
                          String safeContent = org.apache.commons.text.StringEscapeUtils.escapeEcmaScript(cleanContent);
                        %>
                        <button class="layui-btn layui-btn-primary layui-btn-sm"
                                onclick="navigateToDetail('${answer.questionId}', '<%= safeContent %>')">
                          查看详情
                        </button>
                      </td>
                    </tr>
                  </c:forEach>
                  </tbody>
                </table>
              </c:if>
              <c:if test="${empty Answerlist}">
                <div class="fly-none">您还没有回答过任何问题。</div>
              </c:if>

              <!-- 分页部分（我的回答） -->
              <div id="paginationA" style="text-align: center; margin-top: 20px;"></div>
              <script>
                layui.use(['laypage'], function(){
                  var laypage = layui.laypage;

                  laypage.render({
                    elem: 'paginationA' // 分页容器的ID
                    ,count: ${totalAnswers} // 总数据条数
                    ,limit: 10 // 每页显示的条数
                    ,curr: ${currentPageA} // 当前页
                    ,layout: ['prev', 'page', 'next', 'count']
                    ,jump: function(obj, first){
                      if(!first){
                        // 切换页码时，保持当前选中的 Tab
                        window.location.href = "${pageContext.servletContext.contextPath}/profile?id=${userData.id}&pageQ=${currentPageQ}&pageA=" + obj.curr;
                      }
                    }
                  });
                });
              </script>
              <!-- 分页结束 -->
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <script>
    /*编辑资料*/
    function editProfile() {
      // 从session域中获取user对象
      var user = "${user}";
      // 判断user对象是否为空
      if(user == "") {
        alert("请先登录！");
      } else {
        window.location.href = "${pageContext.servletContext.contextPath}/ques/form";
      }
    }

    /*查看回答详情*/
    function navigateToDetail(questionId, content) {
      // 根据需要跳转到回答详情页面，这里假设有一个页面用于展示回答详情
      window.location.href = "${pageContext.servletContext.contextPath}/ques/detail?id=" + questionId;
    }
  </script>
</body>
</html>

