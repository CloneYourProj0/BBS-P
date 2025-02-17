<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 2024/11/19
  Time: 11:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>消息列表</title>
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/layui/css/layui.css">
    <style>
        .layui-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .message-table {
            margin-top: 20px;
        }
        .message-table th, .message-table td {
            text-align: center;
        }
        .message-table th {
            background-color: #f2f2f2;
            font-weight: bold;
            text-align: center !important;
        }
        .message-table tbody tr:nth-child(odd) {
            background-color: #f9f9f9;
        }
        .message-table tbody tr:hover {
            background-color: #f5f5f5;
        }
        .reply-btn {
            margin: 0 auto;
            display: block;
        }
        .pagination {
            margin-top: 20px;
            text-align: center;
        }
        .pagination span {
            display: inline-block;
            padding: 5px 10px;
            margin: 0 2px;
            border: 1px solid #e2e2e2;
            background-color: #fff;
            color: #333;
            cursor: pointer;
        }
        .pagination span.current {
            background-color: #009688;
            color: #fff;
            border-color: #009688;
        }
        .pagination span:hover {
            background-color: #f2f2f2;
        }
        .pagination span.current:hover {
            background-color: #009688;
        }
        .pagination-info {
            margin-top: 10px;
            text-align: center;
            color: #666;
        }
        /* 未读消息样式 */
        .unread-message {
            font-weight: bold;
            background-color: #f0f9eb !important;
        }
        /* 消息状态标签样式 */
        .message-status {
            display: inline-block;
            padding: 2px 6px;
            border-radius: 2px;
            font-size: 12px;
            margin-right: 5px;
        }
        .status-unread {
            background-color: #ff5722;
            color: #fff;
        }
        .status-read {
            background-color: #009688;
            color: #fff;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/common/head.jsp"></jsp:include>

<div class="layui-container">
    <div class="message-table">
        <table class="layui-table" lay-skin="line">
            <colgroup>
                <col width="100">
                <col width="150">
                <col>
                <col width="200">
                <col width="150">
            </colgroup>
            <thead>
            <tr>
                <th>状态</th>
                <th>发送者</th>
                <th>消息内容</th>
                <th>发送时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${messageList}" var="message">
                <tr class="${message.isRead == 0 ? 'unread-message' : ''}">
                    <td>
                        <span class="message-status ${message.isRead == 0 ? 'status-unread' : 'status-read'}">
                                ${message.isRead == 0 ? '未读' : '已读'}
                        </span>
                    </td>
                    <td>${message.fromUserName}</td>
                    <td>${message.content}</td>
                    <td>
                        <fmt:formatDate value="${message.createTime}" pattern="yyyy-MM-dd HH:mm:ss" />
                    </td>
                    <td>
                        <button class="layui-btn layui-btn-sm reply-btn"
                                onclick="replyMessage(${message.id}, ${message.resourseId}, ${message.resourceAnswerId})">
                            回复
                        </button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <!-- 分页区域 -->
        <div class="pagination">
            <!-- 首页 -->
            <c:if test="${currentPage > 1}">
                <span onclick="goToPage(1)">首页</span>
                <span onclick="goToPage(${currentPage - 1})">上一页</span>
            </c:if>

            <!-- 页码 -->
            <c:choose>
                <c:when test="${totalPage <= 5}">
                    <c:forEach var="i" begin="1" end="${totalPage}">
                        <span class="${i == currentPage ? 'current' : ''}"
                              onclick="goToPage(${i})">${i}</span>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <c:if test="${currentPage <= 3}">
                        <c:forEach var="i" begin="1" end="5">
                            <span class="${i == currentPage ? 'current' : ''}"
                                  onclick="goToPage(${i})">${i}</span>
                        </c:forEach>
                    </c:if>
                    <c:if test="${currentPage > 3 && currentPage < totalPage - 2}">
                        <c:forEach var="i" begin="${currentPage - 2}" end="${currentPage + 2}">
                            <span class="${i == currentPage ? 'current' : ''}"
                                  onclick="goToPage(${i})">${i}</span>
                        </c:forEach>
                    </c:if>
                    <c:if test="${currentPage >= totalPage - 2}">
                        <c:forEach var="i" begin="${totalPage - 4}" end="${totalPage}">
                            <span class="${i == currentPage ? 'current' : ''}"
                                  onclick="goToPage(${i})">${i}</span>
                        </c:forEach>
                    </c:if>
                </c:otherwise>
            </c:choose>

            <!-- 末页 -->
            <c:if test="${currentPage < totalPage}">
                <span onclick="goToPage(${currentPage + 1})">下一页</span>
                <span onclick="goToPage(${totalPage})">末页</span>
            </c:if>
        </div>

        <!-- 分页信息 -->
        <div class="pagination-info">
            共 ${total} 条记录，当前第 ${currentPage}/${totalPage} 页
            <select id="pageSizeSelect" onchange="changePageSize(this.value)">
                <option value="10" ${pageSize == 10 ? 'selected' : ''}>10条/页</option>
                <option value="20" ${pageSize == 20 ? 'selected' : ''}>20条/页</option>
                <option value="30" ${pageSize == 30 ? 'selected' : ''}>30条/页</option>
                <option value="50" ${pageSize == 50 ? 'selected' : ''}>50条/页</option>
            </select>
        </div>
    </div>
</div>

<script src="${pageContext.servletContext.contextPath}/assets/layui/layui.js"></script>
<script>
    layui.use(['layer'], function(){
        var layer = layui.layer;

        window.replyMessage = function(messageId, resourceId, answerId) {
            // 先更新消息状态
            $.ajax({
                url: '${pageContext.request.contextPath}/updateMessageStatus',
                data: {messageId: messageId},
                type: 'POST',
                success: function(response) {
                    if(response === 'success') {
                        // 更新成功后跳转到回复页面
                        layer.confirm('确认要回复这条消息吗？', {
                            btn: ['确定','取消']
                        }, function(){
                            var url = '${pageContext.request.contextPath}/ques/detail?id=' + resourceId;
                            if (answerId) {
                                url += '#answer-' + answerId;
                            }
                            window.location.href = url;
                        });
                    }
                }
            });
        }
    });

    function goToPage(page) {
        window.location.href = '${pageContext.request.contextPath}/message?userId=${userId}&pageNum='
            + page + '&pageSize=${pageSize}';
    }

    function changePageSize(pageSize) {
        window.location.href = '${pageContext.request.contextPath}/message?userId=${userId}&pageNum=1&pageSize='
            + pageSize;
    }
</script>
</body>
</html>