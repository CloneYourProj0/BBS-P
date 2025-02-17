<%@ page import="org.apache.commons.lang3.StringEscapeUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>用户个人资料</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!-- 引入 Layui v1.0.9 CSS -->
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/layui/css/layui.css">
    <!-- 引入自定义全局 CSS -->
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/global.css">
    <!-- 引入 Layui v1.0.9 JS -->
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

        <!-- 我的提问与我的回答部分 -->
        <div class="layui-col-md8">
            <!-- 使用 Layui 的 Tab 组件 -->
            <div class="layui-tab" lay-filter="profileTab">
                <ul class="layui-tab-title">
                    <c:choose>
                        <c:when test="${param.tab == 'answers'}">
                            <li>我的提问</li>
                            <li class="layui-this">我的回答</li>
                        </c:when>
                        <c:otherwise>
                            <li class="layui-this">我的提问</li>
                            <li>我的回答</li>
                        </c:otherwise>
                    </c:choose>
                </ul>
                <div class="layui-tab-content">
                    <!-- 我的提问内容 -->
                    <div class="layui-tab-item <c:if test="${param.tab != 'answers'}">layui-show</c:if>">
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
                        </div>
                    </div>

                    <!-- 我的回答内容 -->
                    <div class="layui-tab-item <c:if test="${param.tab == 'answers'}">layui-show</c:if>">
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
</div>

<script>
    layui.use(['laypage', 'element'], function(){
        var laypage = layui.laypage;
        var element = layui.element;

        // 初始化“我的提问”分页
        laypage({
            cont: 'paginationQ', // 分页容器的ID
            pages: ${totalPageQ}, // 总页数
            curr: ${currentPageQ}, // 当前页
            skin: '#1E9FFF', // 分页控件颜色（可选）
            groups: 5, // 连续显示分页数（可选）
            skip: true, // 是否开启跳页（可选）
            jump: function(obj, first){
                if(!first){
                    // 切换页码时，保持当前选中的 Tab
                    window.location.href = "${pageContext.servletContext.contextPath}/profile?id=${userData.id}&pageQ=" + obj.curr + "&pageA=${currentPageA}&tab=questions";
                }
            }
        });

        // 初始化“我的回答”分页
        laypage({
            cont: 'paginationA', // 分页容器的ID
            pages: ${totalPageA}, // 总页数
            curr: ${currentPageA}, // 当前页
            skin: '#1E9FFF', // 分页控件颜色（可选）
            groups: 5, // 连续显示分页数（可选）
            skip: true, // 是否开启跳页（可选）
            jump: function(obj, first){
                if(!first){
                    // 切换页码时，保持当前选中的 Tab
                    window.location.href = "${pageContext.servletContext.contextPath}/profile?id=${userData.id}&pageQ=${currentPageQ}&pageA=" + obj.curr + "&tab=answers";
                }
            }
        });

        // 标签切换事件，自动滚动到内容区域（可选）
        element.on('tab(profileTab)', function(data){
            window.scrollTo(0, document.body.scrollHeight);
        });
    });

    /* 编辑资料 */
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

    /* 查看回答详情 */
    function navigateToDetail(questionId, content) {
        // 根据需要跳转到回答详情页面，这里假设有一个页面用于展示回答详情
        window.location.href = "${pageContext.servletContext.contextPath}/ques/detail?id=" + questionId;
    }
</script>
</body>
</html>

