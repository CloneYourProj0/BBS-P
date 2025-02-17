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
    </head>
    <body>
        <%--公共头部开始--%>
        <jsp:include page="/WEB-INF/jsp/common/head.jsp"></jsp:include>
        <%--公共头部结束--%>

        <div class="main layui-clear">
            <div class="wrap">
                <div class="content" style="margin-right:0">
                    <div class="fly-tab">
                        <form action="${pageContext.servletContext.contextPath}/index" method="post" class="fly-search">
                            <i class="iconfont icon-sousuo"></i>
                            <input class="layui-input" autocomplete="off" placeholder="搜索内容" type="text" value="${title}" name="title">
                        </form>
                        <%--屏蔽a标签的默认跳转--%>
                        <a href="javascript:;" onclick="publish()" class="layui-btn jie-add">发布问题</a>
                    </div>

                    <c:if test="${questionList != null}">
                        <ul class="fly-list">
                            <c:forEach items="${questionList}" var="question">
                                <li class="fly-list-li">
                                    <a href="javascript:;" class="fly-list-avatar">
                                        <img src="${pageContext.servletContext.contextPath}/img/uer.jpg" alt="">
                                    </a>
                                    <h2 class="fly-tip">
                                        <a href="${pageContext.servletContext.contextPath}/ques/detail?id=${question.id}">${question.title}</a>
                                        <c:if test="${question.isUp==1}">
                                        <span class="fly-tip-stick">置顶</span>
                                        </c:if>
                                    </h2>
                                    <p>
                                        <span><a href="">贤心</a></span>
                                        <span>刚刚</span>
                                        <span class="fly-list-hint">
                                          <i class="iconfont" title="回答">&#xe60c;</i> 317
                                        </span>
                                    </p>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:if>

                    <c:if test="${questionList == null}">
                        <div class="fly-none">并无相关数据</div>
                    </c:if>

<%--                    <div style="text-align: center">--%>
<%--                        <div class="laypage-main">&lt;%&ndash;<span class="laypage-curr">1</span>&ndash;%&gt;--%>
<%--                            <c:if test="${currentPage ne 1}">--%>
<%--                                <a href="${pageContext.servletContext.contextPath}/index?page=${currentPage - 1}" class="laypage-next">上一页</a>--%>
<%--                            </c:if>--%>
<%--                            <a href="${pageContext.servletContext.contextPath}/index?page=1" class="laypage-last" title="首页">首页</a>--%>
<%--                            <c:forEach begin="1" end="${totalPage}" var="page">--%>
<%--                                <a class="${currentPage eq page ? 'laypage-curr' : ''}" href="${pageContext.servletContext.contextPath}/index?page=${page}">${page}</a>--%>
<%--                            </c:forEach>--%>
<%--                            &lt;%&ndash;<span>…</span>&ndash;%&gt;--%>
<%--                            <a href="${pageContext.servletContext.contextPath}/index?page=${totalPage}" class="laypage-last" title="尾页">尾页</a>--%>
<%--                            <c:if test="${currentPage ne totalPage}">--%>
<%--                                <a href="${pageContext.servletContext.contextPath}/index?page=${currentPage + 1}" class="laypage-next">下一页</a>--%>
<%--                            </c:if>--%>
<%--                        </div>--%>
<%--                    </div>--%>

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
                                <c:when test="${totalPage <= 10}">
                                    <c:forEach begin="1" end="${totalPage}" var="page">
                                        <a class="${currentPage eq page ? 'laypage-curr' : ''}"
                                           href="${pageContext.servletContext.contextPath}/index?page=${page}">${page}</a>
                                    </c:forEach>
                                </c:when>

                                <%-- 当总页数大于10时，显示部分页码 --%>
                                <c:otherwise>
                                    <%-- 显示当前页附近的页码 --%>
                                    <c:set var="begin" value="${currentPage - 4 > 1 ? currentPage - 4 : 1}"/>
                                    <c:set var="end" value="${currentPage + 4 < totalPage ? currentPage + 4 : totalPage}"/>

                                    <%-- 如果当前页靠近开始，补充显示后面的页码 --%>
                                    <c:if test="${begin == 1}">
                                        <c:set var="end" value="${end + (5 - (currentPage - 1)) > totalPage ? totalPage : end + (5 - (currentPage - 1))}"/>
                                    </c:if>

                                    <%-- 如果当前页靠近结束，补充显示前面的页码 --%>
                                    <c:if test="${end == totalPage}">
                                        <c:set var="begin" value="${begin - (5 - (totalPage - currentPage)) < 1 ? 1 : begin - (5 - (totalPage - currentPage))}"/>
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
            </div>
        </div>
    </body>
    <script>
        /*发布问题*/
        console.log("WQWQWWQWQ")
        function publish() {
            //从session域中获取user对象
            var user = "${user}";
            //判断user对象是否为空
            if(user == "") {
                alert("请先登录！");
            } else {
                window.location.href = "${pageContext.servletContext.contextPath}/ques/form";
            }
        }
    </script>
</html>