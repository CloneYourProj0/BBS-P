<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 2024/11/29
  Time: 10:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>问答系统首页</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/global.css">
    <script src="${pageContext.servletContext.contextPath}/assets/layui/layui.js"></script>
    <style>
        /* 整体容器样式调整 */
        body .main {
            width: 60%;  /* 增加主容器宽度 */
            margin: 0 auto;
            padding: 15px;
        }

        .wrap {
            display: flex;
            /*gap: 15px;*/
            justify-content: space-between;
            margin-top: 20px;
        }

        /*!* 侧边栏样式统一 *!*/
        /*.side-panel {*/
        /*    width: 350px;  !* 统一侧边栏宽度 *!*/
        /*    height: 30%;*/
        /*    background: #fff;*/
        /*    border-radius: 2px;*/
        /*    box-shadow: 0 1px 2px rgba(0,0,0,.1);*/
        /*}*/
        .side-panel{
            width: 350px;
            background: #fff;
            position: sticky;  /* 设置粘性定位 */
            top: 20px;        /* 设置顶部触发距离 */
            height: fit-content; /* 根据内容自适应高度 */
            max-height: calc(100vh - 40px); /* 防止内容超出视口 */
            overflow-y: auto;  /* 内容过多时显示滚动条 */
            scrollbar-width: thin; /* Firefox 细滚动条 */
            scrollbar-color: rgba(0, 0, 0, .3) transparent; /* Firefox 滚动条颜色 */
        }


        /* 中间内容区域样式 */
        .content {
            flex: 1;
            min-width: 0;
            margin: 0 !important;
            background: #fff;
            border-radius: 2px;
            box-shadow: 0 1px 2px rgba(0,0,0,.1);
            margin: 0 8px !important;
        }

        /* 面板内容样式 */
        .panel-content {
            padding: 15px;
            margin-bottom: 25px;
        }

        /* 标题样式 */
        .panel-title {
            font-size: 16px;
            padding: 15px;
            border-bottom: 1px solid #f0f0f0;
        }

        /*!* 问题项样式 *!*/
        /*.question-item {*/
        /*    display: flex;*/
        /*    justify-content: space-between;*/
        /*    padding: 10px 0;*/
        /*    border-bottom: 1px solid #f0f0f0;*/

        /*}*/
        /*.question-item:last-child {*/
        /*    border-bottom: none;*/
        /*}*/

        .question-item {
            width: 100%;
            margin-bottom: 8px;
            box-sizing: border-box;
        }

        .question-item div {
            width: 100%;
            box-sizing: border-box;
            display: flex;  /* 使用flex布局 */
            align-items: center;  /* 垂直居中对齐 */
            gap: 8px;  /* 元素之间的间距 */
        }

        .hot-tag {
            background-color: #ff4d4f;  /* 热门标签的背景色 */
            color: white;
            padding: 2px 6px;
            border-radius: 2px;
            font-size: 12px;
            flex-shrink: 0;  /* 防止压缩 */
        }

        .question-item div a {
            flex: 1;  /* 占据剩余空间 */
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            text-decoration: none;
            font-size: 14px;
            line-height: 1.5;
        }

        .count {
            color: #999;
            font-size: 12px;
            flex-shrink: 0;  /* 防止压缩 */
        }



        /* 计数样式 */
        .count {
            color: #999;
            font-size: 12px;
        }

        /* 热门标签样式 */
        .hot-tag {
            display: inline-block;
            padding: 2px 4px;
            background: #ff5722;
            color: #fff;
            font-size: 12px;
            border-radius: 2px;
            margin-right: 5px;
        }

        /* 话题标签样式 */
        .topic-tags {
            margin-top: 10px;
        }

        .topic-tag {
            display: inline-block;
            padding: 5px 10px;
            background: #26A69A;
            color: #fff;
            border-radius: 2px;
            margin: 0 5px 5px 0;
            font-size: 12px;
        }

        /* 热门话题样式 */
        .hot-topics {
            margin-bottom: 15px;
        }

        #loading {
            text-align: center;
            padding: 20px 0;
        }

        #loading .layui-icon {
            font-size: 32px;  /* 调整图标大小 */
            color: #1E9FFF;   /* 使用 Layui 的主题蓝色 */
        }
    </style>
</head>
<body>
<%--公共头部开始--%>
<jsp:include page="/WEB-INF/jsp/common/head.jsp"></jsp:include>
<%--公共头部结束--%>

<div class="main layui-clear">
    <div class="fly-tab">
        <form id="searchForm" action="${pageContext.servletContext.contextPath}/index" method="post" class="fly-search">
            <i class="iconfont icon-sousuo" id="searchIcon">&#xe60c;</i>
            <input class="layui-input" autocomplete="off" placeholder="搜索内容" type="text" value="${title}" name="title" id="searchInput">
        </form>
        <!-- 发布问题按钮 -->
        <a href="javascript:;" onclick="publish()" class="layui-btn jie-add">发布问题</a>
        <!-- 用于显示模糊查询结果的下拉容器 -->
        <div id="suggestions">
            <ul id="suggestionList"></ul>
        </div>
    </div>

    <div class="wrap">
        <!-- 保持原有的中间内容区 -->
        <!-- 中间内容区 -->
        <div id="content" class="content" style="margin-right:0">
            <c:if test="${questionList != null && !questionList.isEmpty()}">
                <ul class="fly-list">
                    <c:forEach items="${questionList}" var="question">
                        <li class="fly-list-li">
                            <a href="javascript:;" class="fly-list-avatar">
                                <img src="${pageContext.servletContext.contextPath}/img/user.jpg" alt="用户头像">
                            </a>
                            <div class="fly-tip">
                                <h2 class="fly-tip-title">
                                    <a href="${pageContext.servletContext.contextPath}/ques/detail?id=${question.id}">${question.title}</a>
                                    <c:if test="${question.isUp == 1}">
                                        <span class="fly-tip-stick">置顶</span>
                                    </c:if>
                                </h2>
                                <p>
                                    <span><a href="#">贤心</a></span>
                                    <span>刚刚</span>
                                    <span class="fly-list-hint">
                                    <i class="iconfont" title="回答">&#xe60c;</i> ${question.answerCount}
                                </span>
                                </p>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </c:if>
            <c:if test="${questionList == null || questionList.isEmpty()}">
                <p>没有找到相关问题。</p>
            </c:if>

            <c:if test="${questionList == null}">
                <div class="fly-none">并无相关数据</div>
            </c:if>


            <div style="text-align: center">
                <div class="laypage-main">
                    <%-- 上一页 --%>
                    <c:if test="${currentPage ne 1}">
                        <a href="${pageContext.servletContext.contextPath}/index?page=${currentPage - 1}" class="laypage-next">上一页</a>
                    </c:if>

                    <%-- 首页 --%>
                    <a href="${pageContext.servletContext.contextPath}/index?page=1" class="laypage-last" title="首页">首页</a>

                    <%-- 页码显示逻辑优化 --%>
                    <c:choose>
                        <%-- 当总页数小于等于10时，显示所有页码 --%>
                        <c:when test="${totalPage <= 5}">
                            <c:forEach begin="1" end="${totalPage}" var="page">
                                <a class="${currentPage eq page ? 'laypage-curr' : ''}"
                                   href="${pageContext.servletContext.contextPath}/index?page=${page}">${page}</a>
                            </c:forEach>
                        </c:when>

                        <%-- 当总页数大于5时，显示部分页码 --%>
                        <c:otherwise>
                            <%-- 显示当前页附近的页码 --%>
                            <c:set var="begin" value="${currentPage - 2 > 1 ? currentPage - 2 : 1}"/>
                            <c:set var="end" value="${currentPage + 2 < totalPage ? currentPage + 2 : totalPage}"/>

                            <%-- 如果当前页靠近开始，补充显示后面的页码 --%>
                            <c:if test="${begin == 1}">
                                <c:set var="end" value="${begin + 4 < totalPage ? begin + 4 : totalPage}"/>
                            </c:if>

                            <%-- 如果当前页靠近结束，补充显示前面的页码 --%>
                            <c:if test="${end == totalPage}">
                                <c:set var="begin" value="${end - 4 > 1 ? end - 4 : 1}"/>
                            </c:if>

                            <%-- 显示省略号和首页 --%>
                            <c:if test="${begin > 1}">
                                <span>...</span>
                            </c:if>

                            <%-- 显示页码 --%>
                            <c:forEach begin="${begin}" end="${end}" var="page">
                                <a class="${currentPage eq page ? 'laypage-curr' : ''}"
                                   href="${pageContext.servletContext.contextPath}/index?page=${page}">${page}</a>
                            </c:forEach>

                            <%-- 显示省略号和末页 --%>
                            <c:if test="${end < totalPage}">
                                <span>...</span>
                            </c:if>
                        </c:otherwise>
                    </c:choose>

                    <%-- 尾页 --%>
                    <a href="${pageContext.servletContext.contextPath}/index?page=${totalPage}" class="laypage-last" title="尾页">尾页</a>

                    <%-- 下一页 --%>
                    <c:if test="${currentPage ne totalPage}">
                        <a href="${pageContext.servletContext.contextPath}/index?page=${currentPage + 1}" class="laypage-next">下一页</a>
                    </c:if>
                </div>
            </div>

        </div>

        <!-- 右侧热门内容 -->
        <div class="side-panel">
            <!-- 热门话题 -->
            <div class="hot-topics">
                <div class="panel-title">热门话题</div>
                <%--                 在页面最开始添加一个加载状态--%>
                <div id="loading" class="layui-card">
                    <div class="layui-card-body">
                        <div class="layui-row">
                            <div class="layui-col-xs12" style="text-align: center;">
                                <!-- 使用骨架屏风格展示加载状态 -->
                                <div class="layui-bg-gray" style="height: 24px; width: 60%; margin: 10px auto; border-radius: 4px;"></div>
                                <div class="layui-bg-gray" style="height: 24px; width: 80%; margin: 10px auto; border-radius: 4px;"></div>
                                <div class="layui-bg-gray" style="height: 24px; width: 70%; margin: 10px auto; border-radius: 4px;"></div>
                                <!-- 添加加载提示文字 -->
                                <div style="margin-top: 15px;">
                                    <i class="layui-icon layui-icon-loading layui-anim layui-anim-rotate layui-anim-loop"></i>
                                    <span style="margin-left: 10px; color: #666;">正在加载热门问题...</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="mainContent" style="display: none;">
                    <!-- 您原有的内容 -->
                    <div class="panel-content">
                        <c:forEach items="${hotQuestion}" var="rec">
                            <div class="question-item">
                                <div>
                                    <span class="hot-tag">热</span>
                                    <a href="#">${rec.description}</a>
                                    <span class="count">阅读 ${rec.viewCount}</span>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <hr>
            <div class="panel-title">推荐问题</div>
            <%--            在页面最开始添加一个加载状态--%>
            <div id="loading2" class="layui-card">
                <div class="layui-card-body">
                    <div class="layui-row">
                        <div class="layui-col-xs12" style="text-align: center;">
                            <!-- 使用骨架屏风格展示加载状态 -->
                            <div class="layui-bg-gray" style="height: 24px; width: 60%; margin: 10px auto; border-radius: 4px;"></div>
                            <div class="layui-bg-gray" style="height: 24px; width: 80%; margin: 10px auto; border-radius: 4px;"></div>
                            <div class="layui-bg-gray" style="height: 24px; width: 70%; margin: 10px auto; border-radius: 4px;"></div>
                            <!-- 添加加载提示文字 -->
                            <div style="margin-top: 15px;">
                                <i class="layui-icon layui-icon-loading layui-anim layui-anim-rotate layui-anim-loop"></i>
                                <span style="margin-left: 10px; color: #666;">正在加载热门问题...</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <input type="hidden" id="someoneValue" value="${recomment}">
            <div id="mainContent2" style="display: none;">
                <div class="panel-content">
                    <c:forEach items="${recomment}" var="rec">
                        <div class="question-item">
                            <div>
                                <span class="hot-tag">热</span>
                                <a  href="#">${rec.description}</a>
                                <span class="count">阅读 2354</span>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(function(){
        var $searchInput = $('#searchInput');
        var $suggestionList = $('#suggestionList');
        var $suggestions = $('#suggestions');
        var $searchForm = $('#searchForm');
        var $searchIcon = $('#searchIcon');
        var $content = $('#content');
        var suggestionsData = []; // 存储搜索建议的数据

        // 动态调整下拉列表的宽度和位置
        function adjustSuggestionBox() {
            var inputOffset = $searchInput.offset();
            var inputWidth = $searchInput.outerWidth();

            $suggestions.css({
                'left': inputOffset.left + 'px',
                'top': ($searchInput.offset().top + $searchInput.outerHeight()) + 'px',
                'width': inputWidth + 'px',
                'position': 'absolute'
            });

            $suggestionList.css('width', inputWidth + 'px');
        }
        // 在窗口缩放或加载时也校正位置
        $(window).on('resize', adjustSuggestionBox);
        adjustSuggestionBox();

        // 处理输入框的键盘事件
        $searchInput.on('keyup', function(e){
            var query = $(this).val().trim();

            // 输入为空则隐藏建议列表
            if(query === ''){
                $suggestionList.empty().hide();
                suggestionsData = [];
                return;
            }

            // 如果按下的是回车键，则触发搜索
            if(e.key === 'Enter' || e.keyCode === 13){
                performSearch(query);
                $suggestionList.empty().hide();
                return;
            }

            // AJAX 请求获取搜索建议
            $.ajax({
                url: '${pageContext.servletContext.contextPath}/ques/matchQuestion',
                type: 'GET',
                data: { content: query },
                dataType: 'json',
                success: function(data){
                    $suggestionList.empty();

                    if(data && data.length > 0){
                        suggestionsData = data; // 存储搜索建议数据

                        $.each(data, function(index, question){
                            var $li = $('<li>')
                                .text(question.title)
                                .on('click', function(){
                                    $searchInput.val(question.title);
                                    $suggestionList.empty().hide();
                                    performSearch(question.title);
                                });

                            $suggestionList.append($li);
                        });
                        $suggestionList.show();
                        adjustSuggestionBox();
                    } else {
                        suggestionsData = [];
                        var $noResult = $('<li>').text('无匹配结果').css({
                            'color':'#999'
                        });
                        $suggestionList.append($noResult).show();
                        adjustSuggestionBox();
                    }
                },
                error: function(){
                    console.error("请求失败，请检查后端接口。");
                    $suggestionList.empty().hide();
                    suggestionsData = [];
                }
            });
        });

        // 点击搜索图标时触发搜索
        $searchIcon.on('click', function(){
            var query = $searchInput.val().trim();
            if(query !== ''){
                performSearch(query);
                $suggestionList.empty().hide();
            }
        });

        // 表单提交时阻止默认行为并通过 AJAX 处理
        $searchForm.on('submit', function(e){
            e.preventDefault();
            var query = $searchInput.val().trim();
            if(query !== ''){
                performSearch(query);
                $suggestionList.empty().hide();
            }
        });

        // 点击页面其他区域时隐藏建议
        $(document).on('click', function(e){
            if(!$(e.target).closest('#suggestionList, #searchInput, #searchIcon').length){
                $suggestionList.empty().hide();
            }
        });

        // 定义执行搜索的函数
        function performSearch(query){
            if(suggestionsData.length === 0){
                // 如果没有建议数据，显示没有找到相关问题
                $content.html('<p>没有找到相关问题。</p>');
                return;
            }

            // 过滤建议数据中与查询匹配的项目（这里假设matchQuestion已经返回匹配的数据）
            // 如果需要更复杂的匹配逻辑，可以在这里调整
            var filteredData = suggestionsData.filter(function(question){
                return question.title.toLowerCase().includes(query.toLowerCase());
            });

            if(filteredData.length > 0){
                var html = '<ul class="fly-list">';
                $.each(filteredData, function(index, question){
                    html += '<li class="fly-list-li">';
                    html += '    <a href="javascript:;" class="fly-list-avatar">';
                    html += '        <img src="' + '${pageContext.servletContext.contextPath}' + '/img/user.jpg" alt="用户头像">';
                    html += '    </a>';
                    html += '    <div class="fly-tip">';
                    html += '        <h2 class="fly-tip-title">';
                    html += '            <a href="' + '${pageContext.servletContext.contextPath}' + '/ques/detail?id=' + question.id + '">' + question.title + '</a>';
                    if(question.isUp == 1){
                        html += '            <span class="fly-tip-stick">置顶</span>';
                    }
                    html += '        </h2>';
                    html += '        <p>';
                    html += '            <span><a href="#">贤心</a></span>';
                    html += '            <span>刚刚</span>';
                    html += '            <span class="fly-list-hint">';
                    html += '                <i class="iconfont" title="回答">&#xe60c;</i> ' + (question.answerCount || 0);
                    html += '            </span>';
                    html += '        </p>';
                    html += '    </div>';
                    html += '</li>';
                });
                html += '</ul>';
                $content.html(html);
            } else {
                $content.html('<p>没有找到相关问题。</p>');
            }
        }
    });

    // 示例发布函数（请根据实际需求实现）
    function publish(){
        alert('发布问题功能待实现');
    }
</script>
<script>
    $(document).ready(function() {
        // 创建一个deferred对象
        var dataLoaded = $.Deferred();

        // 发起数据请求
        $.ajax({
            url: '${pageContext.servletContext.contextPath}/ques/getTopQuestion',
            type: 'GET',
            success: function(response) {
                if(response === '101') {
                    // 使用更精确的选择器，只刷新热门话题下的panel-content
                    // 延迟1秒后刷新热门话题下的panel-content
                    setTimeout(() => {
                        $("#mainContent .panel-content").load(location.href + " #mainContent .panel-content>*", function() {
                            dataLoaded.resolve();
                        });
                    }, 1000); // 1000毫秒 = 1秒
                } else {
                    console.log('获取热门问题失败');
                    dataLoaded.reject();
                }
            },
            error: function(xhr, status, error) {
                console.error('请求失败:', error);
                dataLoaded.reject();
            }
        });

        // 等待数据加载完成后再显示内容
        $.when(dataLoaded).then(
            function() {
                $('#loading').hide();
                $('#mainContent').show();
            },
            function() {
                $('#loading').text('加载失败，请刷新页面重试');
            }
        );
    });
</script>
<script>
    var someone = document.getElementById("someoneValue").value;
    document.addEventListener("DOMContentLoaded", function() {
        <%--console.log(${recomment})--%>
        // 检查 sessionStorage 中是否存在 "recomment" 对象
        if (someone) {
            console.log(111111111111111)
            // 延迟 1 秒执行
            setTimeout(function() {
                // 隐藏 id 为 "loading2" 的 div
                var loadingDiv = document.getElementById("loading2");
                if (loadingDiv) {
                    loadingDiv.style.display = "none";
                }

                // 显示 id 为 "mainContent2" 的 div
                var mainContentDiv = document.getElementById("mainContent2");
                if (mainContentDiv) {
                    mainContentDiv.style.display = "block";
                }
            }, 1000); // 延迟 1000 毫秒 (1 秒)
        }
    });
</script>
<script>
    function publish() {
        var user = "${user}";
        if(user == "") {
            alert("请先登录！");
        } else {
            window.location.href = "${pageContext.servletContext.contextPath}/ques/form";
        }
    }
</script>
</html>
