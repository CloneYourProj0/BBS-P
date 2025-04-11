<%--<%@ page import="org.apache.commons.lang3.StringEscapeUtils" %>--%>
<%--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>--%>
<%--<!DOCTYPE html>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <meta charset="utf-8">--%>
<%--    <title>用户个人资料</title>--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">--%>
<%--    <!-- 引入 Layui v1.0.9 CSS -->--%>
<%--    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/layui/css/layui.css">--%>
<%--    <!-- 引入自定义全局 CSS -->--%>
<%--    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/global.css">--%>
<%--    <style>--%>
<%--            /* 主体区域（添加整体阴影与圆角） */--%>
<%--        .main .wrap {--%>
<%--            padding: 15px;--%>
<%--            border-radius: 8px;--%>
<%--            box-shadow: 0 2px 10px rgba(0,0,0,0.08);--%>
<%--            background-color: #fff;--%>
<%--        }--%>

<%--        /* 左侧个人信息区块增加边框和阴影效果 */--%>
<%--        .layui-col-md4 .layui-card {--%>
<%--            border: 1px solid #f2f2f2;--%>
<%--            border-radius: 6px;--%>
<%--            box-shadow: 0 4px 12px rgba(0,0,0,0.05);--%>
<%--        }--%>

<%--        /* 右侧Tab内容区块增加边框样式 */--%>
<%--        .layui-col-md8 .layui-tab {--%>
<%--            border: 1px solid #f2f2f2;--%>
<%--            border-radius: 6px;--%>
<%--            box-shadow: 0 4px 12px rgba(0,0,0,0.05);--%>
<%--        }--%>

<%--        /* 标签页标题美化 */--%>
<%--        .layui-tab-title {--%>
<%--            border-bottom: 1px solid #e8e8e8;--%>
<%--            background-color: #f9f9f9;--%>
<%--            border-radius: 6px 6px 0 0;--%>
<%--        }--%>

<%--        /* 按钮悬浮特效 */--%>
<%--        .layui-btn-primary:hover {--%>
<%--            border-color: #1E9FFF;--%>
<%--            color: #1E9FFF;--%>
<%--        }--%>

<%--        /* 表格样式增强（视觉清晰） */--%>
<%--        .layui-table {--%>
<%--            border-radius: 4px;--%>
<%--        }--%>

<%--        /* 空信息提示美化 */--%>
<%--        .fly-none {--%>
<%--            padding: 20px;--%>
<%--            text-align: center;--%>
<%--            color: #ababab;--%>
<%--            border-radius: 4px;--%>
<%--            background-color: #fcfcfc;--%>
<%--            border: 1px dashed #e2e2e2;--%>
<%--        }--%>

<%--        /* 输入框统一边框美化 */--%>
<%--        .layui-input[readonly] {--%>
<%--            border-color: #eee !important;--%>
<%--            background-color: #fbfbfb !important;--%>
<%--        }--%>

<%--        /* 卡片部分头部划分 */--%>
<%--        .layui-card-header {--%>
<%--            border-bottom: 1px solid #f0f0f0;--%>
<%--            font-weight: bold;--%>
<%--        }--%>
<%--    </style>--%>
<%--    <!-- 引入 Layui v1.0.9 JS -->--%>
<%--    <script src="${pageContext.servletContext.contextPath}/assets/layui/layui.js"></script>--%>
<%--    <!-- 引入 jQuery（如果需要） -->--%>
<%--    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>--%>
<%--</head>--%>
<%--<body>--%>
<%--&lt;%&ndash; 公共头部开始 &ndash;%&gt;--%>
<%--<jsp:include page="/WEB-INF/jsp/common/head.jsp"></jsp:include>--%>
<%--&lt;%&ndash; 公共头部结束 &ndash;%&gt;--%>

<%--<div class="main layui-clear">--%>
<%--    <div class="wrap">--%>
<%--        <!-- 个人信息部分 -->--%>
<%--        <div class="layui-col-md4">--%>
<%--            <div class="layui-card">--%>
<%--                <div class="layui-card-header">--%>
<%--                    <i class="layui-icon layui-icon-user"></i> 个人信息--%>
<%--                </div>--%>
<%--                <div class="layui-card-body">--%>
<%--                    <form class="layui-form">--%>
<%--                        <div class="layui-form-item">--%>
<%--                            <label class="layui-form-label">用户名</label>--%>
<%--                            <div class="layui-input-block">--%>
<%--                                <input type="text" value="${userData.loginname}" class="layui-input" readonly>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="layui-form-item">--%>
<%--                            <label class="layui-form-label">邮箱</label>--%>
<%--                            <div class="layui-input-block">--%>
<%--                                <input type="text" value="${userData.email}" class="layui-input" readonly>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="layui-form-item">--%>
<%--                            <label class="layui-form-label">注册时间</label>--%>
<%--                            <div class="layui-input-block">--%>
<%--                                <input type="text" value="${userData.createtime}" class="layui-input" readonly>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="layui-form-item">--%>
<%--                            <div class="layui-input-block">--%>
<%--                                <button type="button" class="layui-btn layui-btn-normal layui-btn-sm" onclick="editProfile()">编辑资料</button>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </form>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>

<%--        <!-- 我的提问与我的回答部分 -->--%>
<%--        <div class="layui-col-md8">--%>
<%--            <!-- 使用 Layui 的 Tab 组件 -->--%>
<%--            <div class="layui-tab" lay-filter="profileTab">--%>
<%--                <ul class="layui-tab-title">--%>
<%--                    <c:choose>--%>
<%--                        <c:when test="${param.tab == 'answers'}">--%>
<%--                            <li>我的提问</li>--%>
<%--                            <li class="layui-this">我的回答</li>--%>
<%--                        </c:when>--%>
<%--                        <c:otherwise>--%>
<%--                            <li class="layui-this">我的提问</li>--%>
<%--                            <li>我的回答</li>--%>
<%--                        </c:otherwise>--%>
<%--                    </c:choose>--%>
<%--                </ul>--%>
<%--                <div class="layui-tab-content">--%>
<%--                    <!-- 我的提问内容 -->--%>
<%--                    <div class="layui-tab-item <c:if test="${param.tab != 'answers'}">layui-show</c:if>">--%>
<%--                        <div class="layui-card-body">--%>
<%--                            <c:if test="${not empty questionList}">--%>
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
<%--                                            <td>--%>
<%--                                                <button class="layui-btn layui-btn-primary layui-btn-sm"--%>
<%--                                                        onclick="window.location='${pageContext.servletContext.contextPath}/ques/detail?id=${question.id}'">--%>
<%--                                                    查看详情--%>
<%--                                                </button>--%>
<%--                                            </td>--%>
<%--                                        </tr>--%>
<%--                                    </c:forEach>--%>
<%--                                    </tbody>--%>
<%--                                </table>--%>
<%--                            </c:if>--%>
<%--                            <c:if test="${empty questionList}">--%>
<%--                                <div class="fly-none">您还没有提问过任何问题。</div>--%>
<%--                            </c:if>--%>

<%--                            <!-- 分页部分（我的提问） -->--%>
<%--                            <div id="paginationQ" style="text-align: center; margin-top: 20px;"></div>--%>
<%--                        </div>--%>
<%--                    </div>--%>

<%--                    <!-- 我的回答内容 -->--%>
<%--                    <div class="layui-tab-item <c:if test="${param.tab == 'answers'}">layui-show</c:if>">--%>
<%--                        <div class="layui-card-body">--%>
<%--                            <c:if test="${not empty Answerlist}">--%>
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
<%--                                                <button class="layui-btn layui-btn-primary layui-btn-sm"--%>
<%--                                                        onclick="navigateToDetail('${answer.questionId}', '<%= safeContent %>')">--%>
<%--                                                    查看详情--%>
<%--                                                </button>--%>
<%--                                            </td>--%>
<%--                                        </tr>--%>
<%--                                    </c:forEach>--%>
<%--                                    </tbody>--%>
<%--                                </table>--%>
<%--                            </c:if>--%>
<%--                            <c:if test="${empty Answerlist}">--%>
<%--                                <div class="fly-none">您还没有回答过任何问题。</div>--%>
<%--                            </c:if>--%>

<%--                            <!-- 分页部分（我的回答） -->--%>
<%--                            <div id="paginationA" style="text-align: center; margin-top: 20px;"></div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>

<%--<script>--%>
<%--    layui.use(['laypage', 'element'], function(){--%>
<%--        var laypage = layui.laypage;--%>
<%--        var element = layui.element;--%>

<%--        // 初始化“我的提问”分页--%>
<%--        laypage({--%>
<%--            cont: 'paginationQ', // 分页容器的ID--%>
<%--            pages: ${totalPageQ}, // 总页数--%>
<%--            curr: ${currentPageQ}, // 当前页--%>
<%--            skin: '#1E9FFF', // 分页控件颜色（可选）--%>
<%--            groups: 5, // 连续显示分页数（可选）--%>
<%--            skip: true, // 是否开启跳页（可选）--%>
<%--            jump: function(obj, first){--%>
<%--                if(!first){--%>
<%--                    // 切换页码时，保持当前选中的 Tab--%>
<%--                    window.location.href = "${pageContext.servletContext.contextPath}/profile?id=${userData.id}&pageQ=" + obj.curr + "&pageA=${currentPageA}&tab=questions";--%>
<%--                }--%>
<%--            }--%>
<%--        });--%>

<%--        // 初始化“我的回答”分页--%>
<%--        laypage({--%>
<%--            cont: 'paginationA', // 分页容器的ID--%>
<%--            pages: ${totalPageA}, // 总页数--%>
<%--            curr: ${currentPageA}, // 当前页--%>
<%--            skin: '#1E9FFF', // 分页控件颜色（可选）--%>
<%--            groups: 5, // 连续显示分页数（可选）--%>
<%--            skip: true, // 是否开启跳页（可选）--%>
<%--            jump: function(obj, first){--%>
<%--                if(!first){--%>
<%--                    // 切换页码时，保持当前选中的 Tab--%>
<%--                    window.location.href = "${pageContext.servletContext.contextPath}/profile?id=${userData.id}&pageQ=${currentPageQ}&pageA=" + obj.curr + "&tab=answers";--%>
<%--                }--%>
<%--            }--%>
<%--        });--%>

<%--        // 标签切换事件，自动滚动到内容区域（可选）--%>
<%--        element.on('tab(profileTab)', function(data){--%>
<%--            window.scrollTo(0, document.body.scrollHeight);--%>
<%--        });--%>
<%--    });--%>

<%--    /* 编辑资料 */--%>
<%--    function editProfile() {--%>
<%--        // 从session域中获取user对象--%>
<%--        var user = "${user}";--%>
<%--        // 判断user对象是否为空--%>
<%--        if(user == "") {--%>
<%--            alert("请先登录！");--%>
<%--        } else {--%>
<%--            window.location.href = "${pageContext.servletContext.contextPath}/ques/form";--%>
<%--        }--%>
<%--    }--%>

<%--    /* 查看回答详情 */--%>
<%--    function navigateToDetail(questionId, content) {--%>
<%--        // 根据需要跳转到回答详情页面，这里假设有一个页面用于展示回答详情--%>
<%--        window.location.href = "${pageContext.servletContext.contextPath}/ques/detail?id=" + questionId;--%>
<%--    }--%>
<%--</script>--%>
<%--</body>--%>
<%--</html>--%>

<%--<%@ page import="org.apache.commons.lang3.StringEscapeUtils" %>--%>
<%--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>--%>
<%--<!DOCTYPE html>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <meta charset="utf-8">--%>
<%--    <title>用户个人资料</title>--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">--%>
<%--    <!-- 引入 Layui v1.0.9 CSS -->--%>
<%--    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/layui/css/layui.css">--%>
<%--    <!-- 引入自定义全局 CSS -->--%>
<%--    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/global.css">--%>
<%--    <style>--%>
<%--        /* 主体区域（添加整体阴影与圆角） */--%>
<%--        .main .wrap {--%>
<%--            padding: 15px;--%>
<%--            border-radius: 8px;--%>
<%--            box-shadow: 0 2px 10px rgba(0,0,0,0.08);--%>
<%--            background-color: #fff;--%>
<%--        }--%>
<%--        /* 左侧个人信息区块增加边框和阴影效果 */--%>
<%--        .layui-col-md4 .layui-card {--%>
<%--            border: 1px solid #f2f2f2;--%>
<%--            border-radius: 6px;--%>
<%--            box-shadow: 0 4px 12px rgba(0,0,0,0.05);--%>
<%--        }--%>
<%--        /* 右侧Tab内容区块增加边框样式 */--%>
<%--        .layui-col-md8 .layui-tab {--%>
<%--            border: 1px solid #f2f2f2;--%>
<%--            border-radius: 6px;--%>
<%--            box-shadow: 0 4px 12px rgba(0,0,0,0.05);--%>
<%--        }--%>
<%--        /* 标签页标题美化 */--%>
<%--        .layui-tab-title {--%>
<%--            border-bottom: 1px solid #e8e8e8;--%>
<%--            background-color: #f9f9f9;--%>
<%--            border-radius: 6px 6px 0 0;--%>
<%--        }--%>
<%--        /* 按钮悬浮特效 */--%>
<%--        .layui-btn-primary:hover {--%>
<%--            border-color: #1E9FFF;--%>
<%--            color: #1E9FFF;--%>
<%--        }--%>
<%--        /* 表格样式增强（视觉清晰） */--%>
<%--        .layui-table {--%>
<%--            border-radius: 4px;--%>
<%--        }--%>
<%--        /* 空信息提示美化 */--%>
<%--        .fly-none {--%>
<%--            padding: 20px;--%>
<%--            text-align: center;--%>
<%--            color: #ababab;--%>
<%--            border-radius: 4px;--%>
<%--            background-color: #fcfcfc;--%>
<%--            border: 1px dashed #e2e2e2;--%>
<%--        }--%>
<%--        /* 输入框统一边框美化 */--%>
<%--        .layui-input[readonly] {--%>
<%--            border-color: #eee !important;--%>
<%--            background-color: #fbfbfb !important;--%>
<%--        }--%>
<%--        /* 卡片部分头部划分 */--%>
<%--        .layui-card-header {--%>
<%--            border-bottom: 1px solid #f0f0f0;--%>
<%--            font-weight: bold;--%>
<%--        }--%>
<%--        /* 头像样式 */--%>
<%--        .avatar-container {--%>
<%--            text-align: center;--%>
<%--            margin-bottom: 20px;--%>
<%--            padding: 15px 0;--%>
<%--        }--%>
<%--        .avatar-img {--%>
<%--            width: 100px;--%>
<%--            height: 100px;--%>
<%--            border-radius: 50%;--%>
<%--            border: 2px solid #f2f2f2;--%>
<%--            box-shadow: 0 2px 5px rgba(0,0,0,0.1);--%>
<%--            object-fit: cover;--%>
<%--        }--%>
<%--        /* 文件上传按钮样式 */--%>
<%--        .avatar-upload {--%>
<%--            margin-top: 10px;--%>
<%--        }--%>
<%--        /* 图片预览区域 */--%>
<%--        .img-preview {--%>
<%--            display: none;--%>
<%--            margin: 10px auto;--%>
<%--            max-width: 100px;--%>
<%--            max-height: 100px;--%>
<%--            border-radius: 4px;--%>
<%--        }--%>
<%--    </style>--%>
<%--    <!-- 引入 Layui v1.0.9 JS -->--%>
<%--    <script src="${pageContext.servletContext.contextPath}/assets/layui/layui.js"></script>--%>
<%--    <!-- 引入 jQuery（如果需要） -->--%>
<%--    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>--%>
<%--</head>--%>
<%--<body>--%>
<%--&lt;%&ndash; 公共头部开始 &ndash;%&gt;--%>
<%--<jsp:include page="/WEB-INF/jsp/common/head.jsp"></jsp:include>--%>
<%--&lt;%&ndash; 公共头部结束 &ndash;%&gt;--%>
<%--<div class="main layui-clear">--%>
<%--    <div class="wrap">--%>
<%--        <!-- 个人信息部分 -->--%>
<%--        <div class="layui-col-md4">--%>
<%--            <div class="layui-card">--%>
<%--                <div class="layui-card-header">--%>
<%--                    <i class="layui-icon layui-icon-user"></i> 个人信息--%>
<%--                </div>--%>
<%--                <div class="layui-card-body">--%>
<%--                    <!-- 头像展示区域 -->--%>
<%--                    <div class="avatar-container">--%>
<%--                        <c:choose>--%>
<%--                            <c:when test="${not empty userData.avatar}">--%>
<%--                                <img class="avatar-img" id="avatar" src="${userData.avatar}" alt="用户头像">--%>
<%--                            </c:when>--%>
<%--                            <c:otherwise>--%>
<%--                                <img class="avatar-img" id="avatar" src="${pageContext.servletContext.contextPath}/images/default_avatar.png" alt="用户头像">--%>
<%--                            </c:otherwise>--%>
<%--                        </c:choose>--%>

<%--                        <!-- 头像上传部分 -->--%>
<%--                        <div class="avatar-upload">--%>
<%--                            <button type="button" class="layui-btn layui-btn-primary layui-btn-sm" id="chooseAvatarBtn">--%>
<%--                                <i class="layui-icon">&#xe67c;</i>选择图片--%>
<%--                            </button>--%>
<%--                            <button type="button" class="layui-btn layui-btn-normal layui-btn-sm" id="uploadAvatarBtn" style="display:none;">--%>
<%--                                上传头像--%>
<%--                            </button>--%>
<%--                        </div>--%>

<%--                        <!-- 预览区域 -->--%>
<%--                        <div class="img-preview-area">--%>
<%--                            <img id="imgPreview" class="img-preview" src="" alt="预览">--%>
<%--                        </div>--%>
<%--                    </div>--%>

<%--                    <form class="layui-form">--%>
<%--                        <div class="layui-form-item">--%>
<%--                            <label class="layui-form-label">用户名</label>--%>
<%--                            <div class="layui-input-block">--%>
<%--                                <input type="text" value="${userData.loginname}" class="layui-input" readonly>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="layui-form-item">--%>
<%--                            <label class="layui-form-label">邮箱</label>--%>
<%--                            <div class="layui-input-block">--%>
<%--                                <input type="text" value="${userData.email}" class="layui-input" readonly>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="layui-form-item">--%>
<%--                            <label class="layui-form-label">注册时间</label>--%>
<%--                            <div class="layui-input-block">--%>
<%--                                <input type="text" value="${userData.createtime}" class="layui-input" readonly>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="layui-form-item">--%>
<%--                            <div class="layui-input-block">--%>
<%--                                <button type="button" class="layui-btn layui-btn-normal layui-btn-sm" onclick="editProfile()">编辑资料</button>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </form>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <!-- 我的提问与我的回答部分 -->--%>
<%--        <div class="layui-col-md8">--%>
<%--            <!-- 使用 Layui 的 Tab 组件 -->--%>
<%--            <div class="layui-tab" lay-filter="profileTab">--%>
<%--                <ul class="layui-tab-title">--%>
<%--                    <c:choose>--%>
<%--                        <c:when test="${param.tab == 'answers'}">--%>
<%--                            <li>我的提问</li>--%>
<%--                            <li class="layui-this">我的回答</li>--%>
<%--                        </c:when>--%>
<%--                        <c:otherwise>--%>
<%--                            <li class="layui-this">我的提问</li>--%>
<%--                            <li>我的回答</li>--%>
<%--                        </c:otherwise>--%>
<%--                    </c:choose>--%>
<%--                </ul>--%>
<%--                <div class="layui-tab-content">--%>
<%--                    <!-- 我的提问内容 -->--%>
<%--                    <div class="layui-tab-item <c:if test="${param.tab != 'answers'}">layui-show</c:if>">--%>
<%--                        <div class="layui-card-body">--%>
<%--                            <c:if test="${not empty questionList}">--%>
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
<%--                                            <td>--%>
<%--                                                <button class="layui-btn layui-btn-primary layui-btn-sm" onclick="window.location='${pageContext.servletContext.contextPath}/ques/detail?id=${question.id}'">--%>
<%--                                                    查看详情--%>
<%--                                                </button>--%>
<%--                                            </td>--%>
<%--                                        </tr>--%>
<%--                                    </c:forEach>--%>
<%--                                    </tbody>--%>
<%--                                </table>--%>
<%--                            </c:if>--%>
<%--                            <c:if test="${empty questionList}">--%>
<%--                                <div class="fly-none">您还没有提问过任何问题。</div>--%>
<%--                            </c:if>--%>
<%--                            <!-- 分页部分（我的提问） -->--%>
<%--                            <div id="paginationQ" style="text-align: center; margin-top: 20px;"></div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <!-- 我的回答内容 -->--%>
<%--                    <div class="layui-tab-item <c:if test="${param.tab == 'answers'}">layui-show</c:if>">--%>
<%--                        <div class="layui-card-body">--%>
<%--                            <c:if test="${not empty Answerlist}">--%>
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
<%--                                                <button class="layui-btn layui-btn-primary layui-btn-sm" onclick="navigateToDetail('${answer.questionId}', '<%= safeContent %>')">--%>
<%--                                                    查看详情--%>
<%--                                                </button>--%>
<%--                                            </td>--%>
<%--                                        </tr>--%>
<%--                                    </c:forEach>--%>
<%--                                    </tbody>--%>
<%--                                </table>--%>
<%--                            </c:if>--%>
<%--                            <c:if test="${empty Answerlist}">--%>
<%--                                <div class="fly-none">您还没有回答过任何问题。</div>--%>
<%--                            </c:if>--%>
<%--                            <!-- 分页部分（我的回答） -->--%>
<%--                            <div id="paginationA" style="text-align: center; margin-top: 20px;"></div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>

<%--<!-- 隐藏的文件上传input -->--%>
<%--<input type="file" id="fileInput" style="display: none;" accept="image/*">--%>

<%--<script>--%>
<%--    layui.use(['laypage', 'element', 'layer'], function(){--%>
<%--        var laypage = layui.laypage;--%>
<%--        var element = layui.element;--%>
<%--        var layer = layui.layer;--%>

<%--        // 初始化"我的提问"分页--%>
<%--        laypage({--%>
<%--            cont: 'paginationQ', // 分页容器的ID--%>
<%--            pages: ${totalPageQ}, // 总页数--%>
<%--            curr: ${currentPageQ}, // 当前页--%>
<%--            skin: '#1E9FFF', // 分页控件颜色（可选）--%>
<%--            groups: 5, // 连续显示分页数（可选）--%>
<%--            skip: true, // 是否开启跳页（可选）--%>
<%--            jump: function(obj, first){--%>
<%--                if(!first){--%>
<%--                    // 切换页码时，保持当前选中的 Tab--%>
<%--                    window.location.href = "${pageContext.servletContext.contextPath}/profile?id=${userData.id}&pageQ=" + obj.curr + "&pageA=${currentPageA}&tab=questions";--%>
<%--                }--%>
<%--            }--%>
<%--        });--%>

<%--        // 初始化"我的回答"分页--%>
<%--        laypage({--%>
<%--            cont: 'paginationA', // 分页容器的ID--%>
<%--            pages: ${totalPageA}, // 总页数--%>
<%--            curr: ${currentPageA}, // 当前页--%>
<%--            skin: '#1E9FFF', // 分页控件颜色（可选）--%>
<%--            groups: 5, // 连续显示分页数（可选）--%>
<%--            skip: true, // 是否开启跳页（可选）--%>
<%--            jump: function(obj, first){--%>
<%--                if(!first){--%>
<%--                    // 切换页码时，保持当前选中的 Tab--%>
<%--                    window.location.href = "${pageContext.servletContext.contextPath}/profile?id=${userData.id}&pageQ=${currentPageQ}&pageA=" + obj.curr + "&tab=answers";--%>
<%--                }--%>
<%--            }--%>
<%--        });--%>
<%--    });--%>

<%--    // 头像上传相关JS--%>
<%--    $(document).ready(function() {--%>
<%--        // 选择文件按钮点击事件--%>
<%--        $("#chooseAvatarBtn").click(function() {--%>
<%--            // 验证登录状态--%>
<%--            var user = "${user}";--%>
<%--            if(user == "") {--%>
<%--                layer.msg("请先登录！");--%>
<%--                return;--%>
<%--            }--%>
<%--            // 触发文件选择框点击--%>
<%--            $("#fileInput").click();--%>
<%--        });--%>

<%--        // 文件选择变更事件--%>
<%--        $("#fileInput").change(function() {--%>
<%--            var file = this.files[0];--%>
<%--            if(file) {--%>
<%--                // 验证文件类型--%>
<%--                if(!file.type.match('image.*')) {--%>
<%--                    layer.msg('请选择图片文件！');--%>
<%--                    return;--%>
<%--                }--%>

<%--                // 验证文件大小（2MB以内）--%>
<%--                if(file.size > 2 * 1024 * 1024) {--%>
<%--                    layer.msg('图片大小不能超过2MB！');--%>
<%--                    return;--%>
<%--                }--%>

<%--                // 预览图片--%>
<%--                var reader = new FileReader();--%>
<%--                reader.onload = function(e) {--%>
<%--                    $("#imgPreview").attr("src", e.target.result).show();--%>
<%--                    $("#uploadAvatarBtn").show(); // 显示上传按钮--%>
<%--                };--%>
<%--                reader.readAsDataURL(file);--%>
<%--            }--%>
<%--        });--%>

<%--        // 上传按钮点击事件--%>
<%--        $("#uploadAvatarBtn").click(function() {--%>
<%--            var file = $("#fileInput")[0].files[0];--%>
<%--            if(!file) {--%>
<%--                layer.msg('请先选择图片！');--%>
<%--                return;--%>
<%--            }--%>

<%--            // 创建FormData对象--%>
<%--            var formData = new FormData();--%>
<%--            formData.append('avatar', file);--%>
<%--            formData.append('userId', ${userData.id});--%>

<%--            // 显示上传中提示--%>
<%--            var loadIndex = layer.load(1);--%>

<%--            // 发送Ajax请求--%>
<%--            $.ajax({--%>
<%--                url: '${pageContext.servletContext.contextPath}/user/uploadAvatar',--%>
<%--                type: 'POST',--%>
<%--                data: formData,--%>
<%--                processData: false,--%>
<%--                contentType: false,--%>
<%--                success: function(res) {--%>
<%--                    layer.close(loadIndex);--%>
<%--                    if(res.code === 0) {--%>
<%--                        layer.msg('头像上传成功！', {icon: 1});--%>
<%--                        // 更新显示的头像--%>
<%--                        $("#avatar").attr("src", res.data.avatarUrl);--%>
<%--                        // 隐藏预览和上传按钮--%>
<%--                        $("#imgPreview").hide();--%>
<%--                        $("#uploadAvatarBtn").hide();--%>
<%--                        // 清空文件输入框--%>
<%--                        $("#fileInput").val("");--%>
<%--                    } else {--%>
<%--                        layer.msg(res.msg || '上传失败，请重试', {icon: 2});--%>
<%--                    }--%>
<%--                },--%>
<%--                error: function() {--%>
<%--                    layer.close(loadIndex);--%>
<%--                    layer.msg('服务器错误，请稍后重试', {icon: 2});--%>
<%--                }--%>
<%--            });--%>
<%--        });--%>
<%--    });--%>

<%--    /* 编辑资料 */--%>
<%--    function editProfile() {--%>
<%--        // 从session域中获取user对象--%>
<%--        var user = "${user}";--%>
<%--        // 判断user对象是否为空--%>
<%--        if(user == "") {--%>
<%--            layer.msg("请先登录！");--%>
<%--        } else {--%>
<%--            window.location.href = "${pageContext.servletContext.contextPath}/ques/form";--%>
<%--        }--%>
<%--    }--%>

<%--    /* 查看回答详情 */--%>
<%--    function navigateToDetail(questionId, content) {--%>
<%--        // 根据需要跳转到回答详情页面，这里假设有一个页面用于展示回答详情--%>
<%--        window.location.href = "${pageContext.servletContext.contextPath}/ques/detail?id=" + questionId;--%>
<%--    }--%>
<%--</script>--%>
<%--</body>--%>
<%--</html>--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>个人中心</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/global.css">
    <style>
        /* 现代化UI样式 */
        .profile-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 15px;
        }

        .profile-header {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            padding: 25px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }

        .profile-avatar-container {
            position: relative;
            margin-right: 25px;
        }

        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #f2f2f2;
        }

        .change-avatar-btn {
            position: absolute;
            bottom: 0;
            right: 0;
            width: 32px;
            height: 32px;
            line-height: 32px;
            text-align: center;
            background: rgba(0,0,0,0.5);
            color: #fff;
            border-radius: 50%;
            cursor: pointer;
        }

        .profile-info {
            flex: 1;
        }

        .profile-username {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .profile-meta {
            color: #666;
            margin-bottom: 15px;
        }

        .profile-meta span {
            margin-right: 15px;
        }

        .profile-content {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

        .profile-sidebar {
            width: 280px;
            flex-shrink: 0;
        }

        .profile-main {
            flex: 1;
            min-width: 0;
        }

        .stats-card, .content-card {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            padding: 20px;
            margin-bottom: 20px;
        }

        .stats-title {
            font-size: 16px;
            font-weight: 600;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
            margin-bottom: 15px;
        }

        .stat-item {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .stat-icon {
            width: 40px;
            height: 40px;
            line-height: 40px;
            text-align: center;
            background-color: #f0f7ff;
            color: #1E9FFF;
            border-radius: 50%;
            margin-right: 15px;
        }

        .stat-info {
            flex: 1;
        }

        .stat-value {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 2px;
        }

        .stat-label {
            font-size: 14px;
            color: #666;
        }

        .content-item {
            padding: 15px 0;
            border-bottom: 1px solid #eee;
        }

        .content-item:last-child {
            border-bottom: none;
        }

        .content-title {
            font-size: 16px;
            font-weight: 500;
            margin-bottom: 10px;
        }

        .content-title a {
            color: #1E9FFF;
        }

        .content-title a:hover {
            text-decoration: underline;
        }

        .content-meta {
            font-size: 13px;
            color: #999;
        }

        .content-meta span {
            margin-right: 12px;
        }

        .empty-placeholder {
            text-align: center;
            padding: 30px 0;
            color: #999;
        }

        .empty-placeholder i {
            font-size: 48px;
            margin-bottom: 10px;
            color: #ddd;
        }

        .tab-header {
            border-bottom: 1px solid #eee;
            margin-bottom: 20px;
        }

        .tab-header .layui-btn {
            padding: 5px 15px;
            margin-right: 10px;
            margin-bottom: -1px;
            border-radius: 4px 4px 0 0;
        }

        .tab-header .active {
            background-color: #fff;
            color: #1E9FFF;
            border-bottom: 2px solid #1E9FFF;
        }

        @media screen and (max-width: 768px) {
            .profile-header {
                flex-direction: column;
                align-items: center;
                text-align: center;
            }

            .profile-avatar-container {
                margin-right: 0;
                margin-bottom: 20px;
            }

            .profile-content {
                flex-direction: column;
            }

            .profile-sidebar {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<!-- 公共头部 - 保持原样 -->
<jsp:include page="/WEB-INF/jsp/common/head.jsp"></jsp:include>

<div class="profile-container">
    <div class="profile-header">
        <div class="profile-avatar-container">
            <!-- 保留原有的头像逻辑 -->
            <img src="${not empty userData.avatar ? userData.avatar : pageContext.servletContext.contextPath.concat('/img/logo.png')}" class="profile-avatar" id="avatar">

            <!-- 使用原有的判断逻辑决定是否显示上传按钮 -->
            <% if(request.getSession().getAttribute("user") != null &&
                    request.getSession().getAttribute("user").equals(request.getAttribute("userData"))) { %>
            <div class="change-avatar-btn" id="chooseAvatarBtn">
                <i class="layui-icon layui-icon-camera"></i>
            </div>
            <% } %>
        </div>

        <div class="profile-info">
            <h2 class="profile-username">${userData.loginname}</h2>

            <div class="profile-meta">
                <span><i class="layui-icon layui-icon-email"></i> ${userData.email}</span>
                <span><i class="layui-icon layui-icon-date"></i> 注册于：${userData.createtime}</span>
            </div>

            <!-- 保留原有的登录判断逻辑 -->
            <div class="profile-actions">
                <% if(request.getSession().getAttribute("user") != null &&
                        request.getSession().getAttribute("user").equals(request.getAttribute("userData"))) { %>
                <button type="button" class="layui-btn" onclick="editProfile()">编辑资料</button>
                <% } %>
            </div>
        </div>
    </div>

    <div class="profile-content">
        <div class="profile-sidebar">
            <div class="stats-card">
                <div class="stats-title">统计信息</div>

                <!-- 使用后端已有数据，如果没有提供则显示0 -->
                <div class="stat-item">
                    <div class="stat-icon">
                        <i class="layui-icon layui-icon-form"></i>
                    </div>
                    <div class="stat-info">
                        <div class="stat-value">${totalQuestions != null ? totalQuestions : 0}</div>
                        <div class="stat-label">提问数</div>
                    </div>
                </div>

                <div class="stat-item">
                    <div class="stat-icon">
                        <i class="layui-icon layui-icon-reply-fill"></i>
                    </div>
                    <div class="stat-info">
                        <div class="stat-value">${totalAnswers != null ? totalAnswers : 0}</div>
                        <div class="stat-label">回答数</div>
                    </div>
                </div>
            </div>

            <!-- 可以在实际集成时替换成真实数据 -->
            <div class="stats-card">
                <div class="stats-title">快速操作</div>
                <button class="layui-btn layui-btn-fluid" onclick="window.location.href='${pageContext.servletContext.contextPath}/ques/form'">
                    <i class="layui-icon layui-icon-add-1"></i> 发布新问题
                </button>
            </div>
        </div>

        <div class="profile-main">
            <div class="content-card">
                <div class="tab-header">
                    <!-- 保留原页面参数传递方式 -->
                    <button type="button" class="layui-btn layui-btn-primary ${param.tab != 'answers' ? 'active' : ''}"
                            onclick="window.location.href='${pageContext.servletContext.contextPath}/profile?id=${userData.id}&tab=questions'">
                        我的提问
                    </button>
                    <button type="button" class="layui-btn layui-btn-primary ${param.tab == 'answers' ? 'active' : ''}"
                            onclick="window.location.href='${pageContext.servletContext.contextPath}/profile?id=${userData.id}&tab=answers'">
                        我的回答
                    </button>
                </div>

                <!-- 保留原有的条件逻辑结构 -->
                <div id="questionTab" style="display: ${param.tab != 'answers' ? 'block' : 'none'}">
                    <c:if test="${not empty questionList}">
                        <c:forEach items="${questionList}" var="question">
                            <div class="content-item">
                                <div class="content-title">
                                    <a href="${pageContext.servletContext.contextPath}/ques/detail?id=${question.id}">${question.title}</a>
                                </div>
                                <div class="content-meta">
                                    <span><i class="layui-icon layui-icon-date"></i> ${question.createtime}</span>
                                    <!-- 使用静态样例数据，后端集成时可替换 -->
                                    <span><i class="layui-icon layui-icon-reply-fill"></i> 回复: 0</span>
                                    <span><i class="layui-icon layui-icon-read"></i> 浏览: 0</span>
                                </div>
                            </div>
                        </c:forEach>

                        <!-- 保留原有的分页组件 -->
                        <div id="pageDiv" style="text-align: center;"></div>
                    </c:if>

                    <c:if test="${empty questionList}">
                        <div class="empty-placeholder">
                            <i class="layui-icon layui-icon-help"></i>
                            <p>您还没有发布过问题</p>
                        </div>
                    </c:if>
                </div>

                <div id="answerTab" style="display: ${param.tab == 'answers' ? 'block' : 'none'}">
                    <c:if test="${not empty Answerlist}">
                        <c:forEach items="${Answerlist}" var="answer">
                            <div class="content-item">
                                <div class="content-meta">
                                    回答于：${answer.createtime}
                                </div>
                                <div class="content-text">
                                    <!-- 保留原有内容渲染方式 -->
                                        ${answer.content}
                                </div>
                                <div class="content-actions">
                                    <a href="${pageContext.servletContext.contextPath}/ques/detail?id=${answer.questionId}" class="layui-btn layui-btn-xs layui-btn-primary">
                                        查看原问题
                                    </a>
                                </div>
                            </div>
                        </c:forEach>

                        <!-- 保留原有的分页组件 -->
                        <div id="pageDiv2" style="text-align: center;"></div>
                    </c:if>

                    <c:if test="${empty Answerlist}">
                        <div class="empty-placeholder">
                            <i class="layui-icon layui-icon-reply-fill"></i>
                            <p>您还没有回答过问题</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 隐藏的文件上传input - 保留原有逻辑 -->
<input type="file" id="fileInput" style="display: none;" accept="image/*">

<script src="${pageContext.servletContext.contextPath}/assets/layui/layui.js"></script>
<script>
    layui.use(['layer', 'laypage'], function(){
        var layer = layui.layer;
        var laypage = layui.laypage;

        // 保留原有的分页逻辑
        laypage.render({
            elem: 'pageDiv',
            count: ${totalItemsQ != null ? totalItemsQ : 0},
            limit: 5,
            curr: ${currentPageQ != null ? currentPageQ : 1},
            layout: ['count', 'prev', 'page', 'next', 'skip'],
            jump: function(obj, first){
                if(!first){
                    window.location.href = "${pageContext.servletContext.contextPath}/profile?id=${userData.id}&pageQ=" + obj.curr + "&tab=questions";
                }
            }
        });

        // 保留原有的分页逻辑
        laypage.render({
            elem: 'pageDiv2',
            count: ${totalItemsA != null ? totalItemsA : 0},
            limit: 5,
            curr: ${currentPageA != null ? currentPageA : 1},
            layout: ['count', 'prev', 'page', 'next', 'skip'],
            jump: function(obj, first){
                if(!first){
                    window.location.href = "${pageContext.servletContext.contextPath}/profile?id=${userData.id}&pageA=" + obj.curr + "&tab=answers";
                }
            }
        });
    });

    // 保留原有头像上传逻辑
    layui.use(['upload', 'layer'], function() {
        var layer = layui.layer;

        // 选择头像按钮点击事件
        document.getElementById('chooseAvatarBtn').addEventListener('click', function() {
            document.getElementById('fileInput').click();
        });

        // 文件选择变更事件
        document.getElementById('fileInput').addEventListener('change', function() {
            var file = this.files[0];
            if (!file) return;

            var formData = new FormData();
            formData.append('avatar', file);
            formData.append('userId', ${userData.id});

            var loadIndex = layer.load(1, {shade: [0.1, '#fff']});

            // 保留原有的Ajax上传路径
            fetch('${pageContext.servletContext.contextPath}/uploadAvatar', {
                method: 'POST',
                body: formData
            })
                .then(response => response.json())
                .then(data => {
                    layer.close(loadIndex);
                    if (data.code === 0) {
                        layer.msg('头像上传成功！');
                        document.getElementById('avatar').src = data.data.avatarUrl + '?t=' + new Date().getTime();
                        document.getElementById('fileInput').value = '';
                    } else {
                        layer.msg(data.msg || '上传失败，请重试');
                    }
                })
                .catch(error => {
                    layer.close(loadIndex);
                    layer.msg('服务器错误，请稍后重试');
                });
        });
    });

    // 保留原有的编辑资料函数
    function editProfile() {
        // 从session域中获取user对象
        var user = "${user}";
        // 判断user对象是否为空
        if(user == "") {
            layui.layer.msg("请先登录！", {icon: 0});
        } else {
            window.location.href = "${pageContext.servletContext.contextPath}/user/settings";
        }
    }
</script>
</body>
</html>

