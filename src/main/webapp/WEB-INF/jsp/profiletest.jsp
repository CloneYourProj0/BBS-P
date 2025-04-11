<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 引入必要的工具类 --%>
<%@ page import="org.apache.commons.lang3.StringEscapeUtils" %>
<!DOCTYPE html>
<html>
<head>
  <title>个人主页</title>
  <link rel="stylesheet" href="resources/css/layui.css">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="keywords" content="">
  <meta name="description" content="">
  <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/layui/css/layui.css">
  <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/global.css">
  <script src="${pageContext.servletContext.contextPath}/assets/layui/layui.js"></script>

</head>
<body>
<%--公共头部开始--%>
<jsp:include page="/WEB-INF/jsp/common/head.jsp"></jsp:include>
<%--公共头部结束--%>
<div class="main layui-clear">
  <div class="layui-container">
    <div class="layui-row layui-col-space15">

      <%-- 左侧个人信息面板 --%>
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
                  <input type="text" value="${userData.createtime}" class="layui-input" readonly>
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

      <%-- 右侧内容面板 --%>
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
                        <td>${question.createtime}</td>
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
                        <td>${answer.content}</td>
                        <td>${answer.createtime}</td>
                        <td>
                          <c:set var="content" value="${answer.content}" scope="page"/>
                          <%
                            String content = (String) pageContext.getAttribute("content");
                            // 移除 HTML 标签
                            String cleanContent = content.replaceAll("<[^>]*>", ""); // 使用正则表达式移除 HTML 标签

                            // 转义特殊字符以防止 JavaScript 注入
                            String safeContent = StringEscapeUtils.escapeEcmaScript(cleanContent);
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
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>



    <%--                    <div class="layui-col-md8">--%>
    <%--                        <div class="layui-card">--%>
    <%--                            <div class="layui-card-header">我的回答</div>--%>
    <%--                            <div class="layui-card-body">--%>
    <%--                                <table class="layui-table">--%>
    <%--                                    <colgroup>--%>
    <%--                                        <col width="50%">--%>
    <%--                                        <col width="30%">--%>
    <%--                                        <col width="20%">--%>
    <%--                                    </colgroup>--%>
    <%--                                    <thead>--%>
    <%--                                    <tr>--%>
    <%--                                        <th>问题</th>--%>
    <%--                                        <th>回答时间</th>--%>
    <%--                                        <th>操作</th>--%>
    <%--                                    </tr>--%>
    <%--                                    </thead>--%>
    <%--                                    <tbody>--%>
    <%--                                    <c:forEach items="${Answerlist}" var="answer">--%>
    <%--                                        <tr>--%>
    <%--                                            <td>${answer.content}</td>--%>
    <%--                                            <td>${answer.createtime}</td>--%>
    <%--                                            <td>--%>
    <%--                                                <c:set var="content" value="${answer.content}" scope="page"/>--%>
    <%--                                                <%--%>
    <%--                                                    String content = (String) pageContext.getAttribute("content");--%>
    <%--                                                    // 移除 HTML 标签--%>
    <%--                                                    String cleanContent = content.replaceAll("<[^>]*>", ""); // 使用正则表达式移除 HTML 标签--%>

    <%--                                                    // 转义特殊字符以防止 JavaScript 注入--%>
    <%--                                                    String safeContent = StringEscapeUtils.escapeEcmaScript(cleanContent);--%>
    <%--                                                %>--%>
    <%--                                                <button class="layui-btn layui-btn-primary layui-btn-sm" onclick="navigateToDetail('${answer.questionId}','<%= safeContent %>')">查看详情</button>--%>
    <%--                                            </td>--%>
    <%--                                        </tr>--%>
    <%--                                    </c:forEach>--%>
    <%--                                    </tbody>--%>
    <%--                                </table>--%>
    <%--                            </div>--%>
    <%--                        </div>--%>
    <%--                        --%>
    <%--                            <div class="layui-card" style="margin-top: 20px;">--%>
    <%--                                <div class="layui-card-header">我的提问</div>--%>
    <%--                                <div class="layui-card-body">--%>
    <%--                                    <c:if test="${not empty questionList}">--%>
    <%--                                        <table class="layui-table">--%>
    <%--                                            <colgroup>--%>
    <%--                                                <col width="50%">--%>
    <%--                                                <col width="30%">--%>
    <%--                                                <col width="20%">--%>
    <%--                                            </colgroup>--%>
    <%--                                            <thead>--%>
    <%--                                            <tr>--%>
    <%--                                                <th>提问标题</th>--%>
    <%--                                                <th>提问时间</th>--%>
    <%--                                                <th>操作</th>--%>
    <%--                                            </tr>--%>
    <%--                                            </thead>--%>
    <%--                                            <tbody>--%>
    <%--                                            <c:forEach items="${questionList}" var="question">--%>
    <%--                                                <tr>--%>
    <%--                                                    <td>${question.title}</td>--%>
    <%--                                                    <td>${question.createtime}</td>--%>
    <%--                                                    <td>--%>
    <%--                                                        <button class="layui-btn layui-btn-primary layui-btn-sm"--%>
    <%--                                                                onclick="window.location='${pageContext.servletContext.contextPath}/profile?id=${question.id}'">--%>
    <%--                                                            查看详情--%>
    <%--                                                        </button>--%>
    <%--                                                    </td>--%>
    <%--                                                </tr>--%>
    <%--                                            </c:forEach>--%>
    <%--                                            </tbody>--%>
    <%--                                        </table>--%>
    <%--                                    </c:if>--%>
    <%--                                    <c:if test="${empty questionList}">--%>
    <%--                                        <div class="fly-none">您还没有提问过任何问题。</div>--%>
    <%--                                    </c:if>--%>

    <%--                                    <!-- 分页部分 -->--%>
    <%--                                    <div style="text-align: center; margin-top: 20px;">--%>
    <%--                                        <div class="laypage-main">--%>
    <%--                                            <!-- 上一页 -->--%>
    <%--                                            <c:if test="${currentPage ne 1}">--%>
    <%--                                                <a href="${pageContext.servletContext.contextPath}/profile?id=${user.id}&page=${currentPage - 1}" class="laypage-next">上一页</a>--%>
    <%--                                            </c:if>--%>

    <%--                                            <!-- 首页 -->--%>
    <%--                                            <a href="${pageContext.servletContext.contextPath}/profile?id=${user.id}&page=1" class="laypage-last" title="首页">首页</a>--%>

    <%--                                            <!-- 页码循环 -->--%>
    <%--                                            <c:forEach begin="1" end="${totalPage}" var="page">--%>
    <%--                                                <a class="${currentPage eq page ? 'laypage-curr' : ''}"--%>
    <%--                                                   href="${pageContext.servletContext.contextPath}/profile?id=${user.id}&page=${page}">--%>
    <%--                                                        ${page}--%>
    <%--                                                </a>--%>
    <%--                                            </c:forEach>--%>

    <%--                                            <!-- 尾页 -->--%>
    <%--                                            <a href="${pageContext.servletContext.contextPath}/profile?id=${user.id}&page=${totalPage}" class="laypage-last" title="尾页">尾页</a>--%>

    <%--                                            <!-- 下一页 -->--%>
    <%--                                            <c:if test="${currentPage ne totalPage}">--%>
    <%--                                                <a href="${pageContext.servletContext.contextPath}/profile?id=${user.id}&page=${currentPage + 1}" class="laypage-next">下一页</a>--%>
    <%--                                            </c:if>--%>
    <%--                                        </div>--%>
    <%--                                    </div>--%>
    <%--                                    <!-- 分页结束 -->--%>
    <%--                                </div>--%>
    <%--                            </div>--%>
    <%--                        </div>--%>
    <%--                        <div class="layui-card" style="margin-top: 20px;">--%>
    <%--                            <div class="layui-card-header">我的提问</div>--%>
    <%--                            <div class="layui-card-body">--%>
    <%--                                <table class="layui-table">--%>
    <%--                                    <colgroup>--%>
    <%--                                        <col width="50%">--%>
    <%--                                        <col width="30%">--%>
    <%--                                        <col width="20%">--%>
    <%--                                    </colgroup>--%>
    <%--                                    <thead>--%>
    <%--                                    <tr>--%>
    <%--                                        <th>提问标题</th>--%>
    <%--                                        <th>提问时间</th>--%>
    <%--                                        <th>操作</th>--%>
    <%--                                    </tr>--%>
    <%--                                    </thead>--%>
    <%--                                    <tbody>--%>
    <%--                                    <c:forEach items="${questionList}" var="question">--%>
    <%--                                        <tr>--%>
    <%--                                            <td>${question.title}</td>--%>
    <%--                                            <td>${question.createtime}</td>--%>
    <%--                                            <td><button class="layui-btn layui-btn-primary layui-btn-sm" onclick="window.location='ques/detail?id=${question.id}'">查看详情</button></td>--%>
    <%--                                        </tr>--%>
    <%--                                    </c:forEach>--%>
    <%--                                    </tbody>--%>
    <%--                                </table>--%>
    <%--                            </div>--%>
    <%--                        </div>--%>
  </div>

</div>
</div>

<div>
  <%--            ${fn:escapeXml(JSON.stringify(Answerlist))}--%>
</div>
</div>

<script>
  layui.use(['laypage', 'element'], function(){
    var laypage = layui.laypage;
    var element = layui.element;

    // 初始化“我的提问”分页
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

    // 初始化“我的回答”分页
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

    // 标签切换事件，自动滚动到内容区域
    element.on('tab(profileTab)', function(data){
      // 自动滚动到内容区域（可选）
      window.scrollTo(0, document.body.scrollHeight);
    });
  });

  layui.use(['layer', 'form'], function() {
    var layer = layui.layer;
    var form = layui.form;

    // 编辑资料按钮的点击事件
    window.editProfile = function() {
      layer.open({
        type: 1,
        title: '编辑资料',
        area: ['500px', '400px'],
        content: `
                        <form class="layui-form" action="${pageContext.servletContext.contextPath}/updataProfile" method="post" style="margin: 20px;">
                        <input type="hidden" name="id" value="${userData.id}">
                            <div class="layui-form-item">
                                <label class="layui-form-label">用户名</label>
                                <div class="layui-input-block">
                                    <input type="text" name="loginname" required lay-verify="required" placeholder="请输入用户名" autocomplete="off" class="layui-input" value="${userData.loginname}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">邮箱</label>
                                <div class="layui-input-block">
                                    <input type="email" name="email" required lay-verify="required|email" placeholder="请输入邮箱" autocomplete="off" class="layui-input" value="${userData.email}">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-input-block">
                                    <button class="layui-btn" lay-submit lay-filter="saveProfile">保存</button>
                                </div>
                            </div>
                        </form>
                    `
      });
    };
  });
</script>
<script>
  function navigateToDetail(questionId, content) {
    if (!questionId) {
      console.error('Question ID is missing');
      return;
    }

    // 现在content参数已经被适当转义，可以安全使用
    console.log('Question ID:', questionId);
    console.log('Content:', content);

    // 根据你的具体需求构建 URL
    window.location.href = 'ques/detail?id=' + questionId + '#' + content;
  }
</script>
</body>
</html>

0758 2858028