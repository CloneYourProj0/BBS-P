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
        }

        /* 标题样式 */
        .panel-title {
            font-size: 16px;
            padding: 15px;
            border-bottom: 1px solid #f0f0f0;
        }

        /* 问题项样式 */
        .question-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #f0f0f0;

        }

        .question-item:last-child {
            border-bottom: none;
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
            border-radius: 2px;rrr
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
    </style>
</head>
<body>
<%--公共头部开始--%>
<jsp:include page="/WEB-INF/jsp/common/head.jsp"></jsp:include>
<%--公共头部结束--%>

<div class="main layui-clear">
    <div class="fly-tab">
        <form action="${pageContext.servletContext.contextPath}/index" method="post" class="fly-search">
            <i class="iconfont icon-sousuo"></i>
            <input class="layui-input" autocomplete="off" placeholder="搜索内容" type="text" value="${title}" name="title">
        </form>
        <%--屏蔽a标签的默认跳转--%>
        <a href="javascript:;" onclick="publish()" class="layui-btn jie-add">发布问题</a>
    </div>

    <div class="wrap">
        <!-- 左侧推荐问题 -->
<%--        <div class="side-panel">--%>
<%--            <div class="panel-title">推荐问题</div>--%>
<%--            <div class="panel-content">--%>
<%--                <div class="question-item">--%>
<%--                    <a href="#">如何学习Java多线程编程？</a>--%>
<%--                    <span class="count">阅读 2354</span>--%>
<%--                </div>--%>
<%--                <div class="question-item">--%>
<%--                    <a href="#">Spring Boot最佳实践有哪些？</a>--%>
<%--                    <span class="count">阅读 1992</span>--%>
<%--                </div>--%>
<%--                <div class="question-item">--%>
<%--                    <a href="#">MySQL索引优化技巧分享</a>--%>
<%--                    <span class="count">阅读 1654</span>--%>
<%--                </div>--%>
<%--                <div class="question-item">--%>
<%--                    <a href="#">Redis缓存设计方案</a>--%>
<%--                    <span class="count">阅读 1433</span>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>

        <!-- 保持原有的中间内容区 -->
        <!-- 中间内容区 -->
        <div class="content">


            <!-- 问题列表 -->
            <ul class="fly-list">
                <!-- 示例问题1 -->
                <li class="fly-list-li">
                    <a href="javascript:;" class="fly-list-avatar">
                        <img src="${pageContext.servletContext.contextPath}/img/uer.jpg" alt="">
                    </a>
                    <h2 class="fly-tip">
                        <a href="#">Java Spring Boot 项目如何优雅地处理异常？</a>
                        <span class="fly-tip-stick">置顶</span>
                    </h2>
                    <p>
                        <span><a href="">张三</a></span>
                        <span>10分钟前</span>
                        <span class="fly-list-hint">
                                    <i class="iconfont" title="回答">&#xe60c;</i> 25
                                </span>
                    </p>
                </li>

                <!-- 示例问题2 -->
                <li class="fly-list-li">
                    <a href="javascript:;" class="fly-list-avatar">
                        <img src="${pageContext.servletContext.contextPath}/img/uer.jpg" alt="">
                    </a>
                    <h2 class="fly-tip">
                        <a href="#">如何设计高并发系统的缓存架构？</a>
                    </h2>
                    <p>
                        <span><a href="">李四</a></span>
                        <span>1小时前</span>
                        <span class="fly-list-hint">
                                    <i class="iconfont" title="回答">&#xe60c;</i> 158
                                </span>
                    </p>
                </li>

                <!-- 示例问题3 -->
                <li class="fly-list-li">
                    <a href="javascript:;" class="fly-list-avatar">
                        <img src="${pageContext.servletContext.contextPath}/img/uer.jpg" alt="">
                    </a>
                    <h2 class="fly-tip">
                        <a href="#">微服务架构中如何解决分布式事务问题？</a>
                    </h2>
                    <p>
                        <span><a href="">王五</a></span>
                        <span>2小时前</span>
                        <span class="fly-list-hint">
                                    <i class="iconfont" title="回答">&#xe60c;</i> 85
                                </span>
                    </p>
                </li>

                <!-- 示例问题4 -->
                <li class="fly-list-li">
                    <a href="javascript:;" class="fly-list-avatar">
                        <img src="${pageContext.servletContext.contextPath}/img/uer.jpg" alt="">
                    </a>
                    <h2 class="fly-tip">
                        <a href="#">Docker容器编排最佳实践分享</a>
                    </h2>
                    <p>
                        <span><a href="">赵六</a></span>
                        <span>3小时前</span>
                        <span class="fly-list-hint">
                                    <i class="iconfont" title="回答">&#xe60c;</i> 46
                                </span>
                    </p>
                </li>
                <!-- 示例问题2 -->
                <li class="fly-list-li">
                    <a href="javascript:;" class="fly-list-avatar">
                        <img src="${pageContext.servletContext.contextPath}/img/uer.jpg" alt="">
                    </a>
                    <h2 class="fly-tip">
                        <a href="#">如何设计高并发系统的缓存架构？</a>
                    </h2>
                    <p>
                        <span><a href="">李四</a></span>
                        <span>1小时前</span>
                        <span class="fly-list-hint">
                                    <i class="iconfont" title="回答">&#xe60c;</i> 158
                                </span>
                    </p>
                </li>

                <!-- 示例问题3 -->
                <li class="fly-list-li">
                    <a href="javascript:;" class="fly-list-avatar">
                        <img src="${pageContext.servletContext.contextPath}/img/uer.jpg" alt="">
                    </a>
                    <h2 class="fly-tip">
                        <a href="#">微服务架构中如何解决分布式事务问题？</a>
                    </h2>
                    <p>
                        <span><a href="">王五</a></span>
                        <span>2小时前</span>
                        <span class="fly-list-hint">
                                    <i class="iconfont" title="回答">&#xe60c;</i> 85
                                </span>
                    </p>
                </li>
                <!-- 示例问题2 -->
                <li class="fly-list-li">
                    <a href="javascript:;" class="fly-list-avatar">
                        <img src="${pageContext.servletContext.contextPath}/img/uer.jpg" alt="">
                    </a>
                    <h2 class="fly-tip">
                        <a href="#">如何设计高并发系统的缓存架构？</a>
                    </h2>
                    <p>
                        <span><a href="">李四</a></span>
                        <span>1小时前</span>
                        <span class="fly-list-hint">
                                    <i class="iconfont" title="回答">&#xe60c;</i> 158
                                </span>
                    </p>
                </li>

                <!-- 示例问题3 -->
                <li class="fly-list-li">
                    <a href="javascript:;" class="fly-list-avatar">
                        <img src="${pageContext.servletContext.contextPath}/img/uer.jpg" alt="">
                    </a>
                    <h2 class="fly-tip">
                        <a href="#">微服务架构中如何解决分布式事务问题？</a>
                    </h2>
                    <p>
                        <span><a href="">王五</a></span>
                        <span>2小时前</span>
                        <span class="fly-list-hint">
                                    <i class="iconfont" title="回答">&#xe60c;</i> 85
                                </span>
                    </p>
                </li><!-- 示例问题2 -->
                <li class="fly-list-li">
                    <a href="javascript:;" class="fly-list-avatar">
                        <img src="${pageContext.servletContext.contextPath}/img/uer.jpg" alt="">
                    </a>
                    <h2 class="fly-tip">
                        <a href="#">如何设计高并发系统的缓存架构？</a>
                    </h2>
                    <p>
                        <span><a href="">李四</a></span>
                        <span>1小时前</span>
                        <span class="fly-list-hint">
                                    <i class="iconfont" title="回答">&#xe60c;</i> 158
                                </span>
                    </p>
                </li>

                <!-- 示例问题3 -->
                <li class="fly-list-li">
                    <a href="javascript:;" class="fly-list-avatar">
                        <img src="${pageContext.servletContext.contextPath}/img/uer.jpg" alt="">
                    </a>
                    <h2 class="fly-tip">
                        <a href="#">微服务架构中如何解决分布式事务问题？</a>
                    </h2>
                    <p><!-- 示例问题2 -->
                <li class="fly-list-li">
                    <a href="javascript:;" class="fly-list-avatar">
                        <img src="${pageContext.servletContext.contextPath}/img/uer.jpg" alt="">
                    </a>
                    <h2 class="fly-tip">
                        <a href="#">如何设计高并发系统的缓存架构？</a>
                    </h2>
                    <p>
                        <span><a href="">李四</a></span>
                        <span>1小时前</span>
                        <span class="fly-list-hint">
                                    <i class="iconfont" title="回答">&#xe60c;</i> 158
                                </span>
                    </p>
                </li>

                <!-- 示例问题4 -->
                <li class="fly-list-li">
                    <a href="javascript:;" class="fly-list-avatar">
                        <img src="${pageContext.servletContext.contextPath}/img/uer.jpg" alt="">
                    </a>
                    <h2 class="fly-tip">
                        <a href="#">Docker容器编排最佳实践分享</a>
                    </h2>
                    <p>
                        <span><a href="">赵六</a></span>
                        <span>3小时前</span>
                        <span class="fly-list-hint">
                                    <i class="iconfont" title="回答">&#xe60c;</i> 46
                                </span>
                    </p>
                </li>
            </ul>

            <!-- 分页部分 -->
            <div style="text-align: center">
                <div class="laypage-main">
                    <a href="#" class="laypage-next">上一页</a>
                    <a href="#" class="laypage-last" title="首页">首页</a>
                    <a href="#" class="laypage-curr">1</a>
                    <a href="#">2</a>
                    <a href="#">3</a>
                    <a href="#">4</a>
                    <a href="#">5</a>
                    <span>...</span>
                    <a href="#" class="laypage-last" title="尾页">尾页</a>
                    <a href="#" class="laypage-next">下一页</a>
                </div>
            </div>
        </div>

        <!-- 右侧热门内容 -->
        <div class="side-panel">
            <!-- 热门话题 -->
            <div class="hot-topics">
                <div class="panel-title">热门话题</div>
                <div class="panel-content">
                    <div class="question-item">
                        <div>
                            <span class="hot-tag">热</span>
                            <a href="#">微服务架构设计经验分享</a>
                        </div>
                        <span class="count">回复 89</span>
                    </div>
                    <div class="question-item">
                        <div>
                            <span class="hot-tag">热</span>
                            <a href="#">Docker容器化部署实践</a>
                        </div>
                        <span class="count">回复 76</span>
                    </div>
                    <div class="question-item">
                        <div>
                            <span class="hot-tag">热</span>
                            <a href="#">前端框架选型建议</a>
                        </div>
                        <span class="count">回复 65</span>
                    </div>
                </div>
            </div>
            <hr>
            <div class="panel-title">推荐问题</div>
            <div class="panel-content">
                <div class="question-item">
                    <a href="#">如何学习Java多线程编程？</a>
                    <span class="count">阅读 2354</span>
                </div>
                <div class="question-item">
                    <a href="#">Spring Boot最佳实践有哪些？</a>
                    <span class="count">阅读 1992</span>
                </div>
                <div class="question-item">
                    <a href="#">MySQL索引优化技巧分享</a>
                    <span class="count">阅读 1654</span>
                </div>
                <div class="question-item">
                    <a href="#">Redis缓存设计方案</a>
                    <span class="count">阅读 1433</span>
                </div>
            </div>

            <!-- 热门标签 -->
            <div class="panel-title">热门标签</div>
            <div class="panel-content">
                <div class="topic-tags">
                    <span class="topic-tag">Java</span>
                    <span class="topic-tag">Spring</span>
                    <span class="topic-tag">MySQL</span>
                    <span class="topic-tag">Redis</span>
                    <span class="topic-tag">Vue</span>
                    <span class="topic-tag">Docker</span>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
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
