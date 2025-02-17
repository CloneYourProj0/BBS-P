<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 2024/11/8
  Time: 22:02
  To change this template use File | Settings | File Templates.

  By-claude-sonnet-3.5 其实可以删了，没有用到它....
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>操作历史记录</title>
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/layui-2.8.0/src/css/layui.css">
    <style>
        .search-box {
            padding: 20px 0;
            background-color: #fff;
        }
        .layui-form-label {
            width: 85px;
        }
        .layui-card-header {
            font-size: 16px;
            font-weight: bold;
            padding: 15px;
        }
        .layui-table-tool {
            padding: 10px;
        }
        .layui-btn {
            background-color: #009688;
        }
        .layui-btn-xs {
            height: 22px;
            line-height: 22px;
            padding: 0 5px;
            font-size: 12px;
        }
        .detail-btn {
            background-color: #009688;
            color: #fff;
        }
        .content-wrapper {
            margin: 15px auto;
            max-width: 1200px;
            padding: 0 15px;
        }
        .layui-table {
            margin: 0 auto;
        }
        .layui-card {
            margin-bottom: 20px;
        }
        .layui-form {
            margin-bottom: 20px;
        }
        /* 下拉框本身 */
        .layui-laypage-limits select {
            height: 25px;
            /*line-height: 30px;*/
            /*padding: 0 25px 0 10px;  !* 给下拉箭头留出空间 *!*/
            /*margin-top: 5px;         !* 垂直居中 *!*/
        }

    </style>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/common/head.jsp"></jsp:include>

<div class="content-wrapper">
    <div class="layui-card">
        <div class="layui-card-header">操作历史记录</div>
        <div class="layui-card-body">
            <form class="layui-form">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">交互类型</label>
                        <div class="layui-input-inline">
                            <select name="interactionType" lay-filter="interactionType">
                                <option value="">全部</option>
                                <option value="view">查看</option>
                                <option value="like">点赞</option>
                                <option value="favorite">收藏</option>
                                <option value="answer">回答</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">日期范围</label>
                        <div class="layui-input-inline">
                            <input type="text" name="dateRange" class="layui-input" id="dateRange" placeholder="请选择日期范围">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <button class="layui-btn" lay-submit lay-filter="searchSubmit">查询</button>
                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                    </div>
                </div>
            </form>

            <table id="historyTable" lay-filter="historyTable"></table>
        </div>
    </div>
</div>

<script type="text/html" id="tableBar">
    <a class="layui-btn layui-btn-xs detail-btn" lay-event="detail">查看详情</a>
</script>

<script src="${pageContext.servletContext.contextPath}/assets/layui-2.8.0/src/layui.js"></script>
<script>
    layui.use(['table', 'form', 'laydate'], function(){
        var table = layui.table,
            form = layui.form,
            laydate = layui.laydate;

        // 初始化日期范围选择器
        laydate.render({
            elem: '#dateRange',
            type: 'datetime',
            range: true
        });

        // 初始化表格
        table.render({
            elem: '#historyTable',
            height:600,
            url: '${pageContext.servletContext.contextPath}/api/user/interactions/list', // 后端接口地址
            page: true,
            cols: [[
                {field: 'id', title: 'ID', sort: true},
                {field: 'userId', title: '用户ID'},
                {field: 'questionId', title: '问题ID'},
                {field: 'interactionType', title: '交互类型', templet: function(d){
                        var types = {
                            'view': '查看',
                            'like': '点赞',
                            'favorite': '收藏',
                            'answer': '回答'
                        };
                        return types[d.interactionType] || d.interactionType;
                    }},
                {field: 'createDate', title: '交互时间',  sort: true},
                {title: '操作',  toolbar: '#tableBar', fixed: 'right'}
            ]],
            limits: [15, 30, 45, 60],
            limit: 15,
            response: {
                statusName: 'code',
                statusCode: 200,
                msgName: 'msg',
                countName: 'count',
                dataName: 'data'
            }
        });

        // 监听表格工具条事件
        table.on('tool(historyTable)', function(obj){
            var data = obj.data;
            if(obj.event === 'detail'){
                // 查看详情逻辑
                layer.open({
                    type: 2,
                    title: '操作详情',
                    content: '${pageContext.servletContext.contextPath}/user/interaction/detail?id=' + data.id,
                    area: ['600px', '400px']
                });
            }
        });

        // 监听搜索提交
        form.on('submit(searchSubmit)', function(data){
            table.reload('historyTable', {
                where: data.field,
                page: {
                    curr: 1
                }
            });
            return false;
        });
    });
</script>
</body>
</html>


<%--<!DOCTYPE html>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <title>历史操作记录</title>--%>
<%--    &lt;%&ndash; 公共头部开始 &ndash;%&gt;--%>
<%--    <jsp:include page="/WEB-INF/jsp/common/head.jsp"></jsp:include>--%>
<%--    &lt;%&ndash; 公共头部结束 &ndash;%&gt;--%>
<%--</head>--%>
<%--<body>--%>

<%--<div class="layui-container">--%>
<%--    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">--%>
<%--        <legend>历史操作记录</legend>--%>
<%--    </fieldset>--%>

<%--    <table class="layui-table" lay-filter="historyTable">--%>
<%--        <thead>--%>
<%--        <tr>--%>
<%--            <th>交互ID</th>--%>
<%--            <th>用户ID</th>--%>
<%--            <th>问题ID</th>--%>
<%--            <th>交互类型</th>--%>
<%--            <th>交互时间</th>--%>
<%--        </tr>--%>
<%--        </thead>--%>
<%--        <tbody>--%>
<%--        &lt;%&ndash; 使用静态数据模拟 &ndash;%&gt;--%>
<%--        <tr>--%>
<%--            <td>1</td>--%>
<%--            <td>1001</td>--%>
<%--            <td>2001</td>--%>
<%--            <td>view</td>--%>
<%--            <td><fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd HH:mm:ss"/></td>--%>
<%--        </tr>--%>
<%--        <tr>--%>
<%--            <td>2</td>--%>
<%--            <td>1002</td>--%>
<%--            <td>2002</td>--%>
<%--            <td>like</td>--%>
<%--            <td><fmt:formatDate value="<%= new java.util.Date(System.currentTimeMillis() - 86400000L) %>" pattern="yyyy-MM-dd HH:mm:ss"/></td>--%>
<%--        </tr>--%>
<%--        <tr>--%>
<%--            <td>3</td>--%>
<%--            <td>1001</td>--%>
<%--            <td>2003</td>--%>
<%--            <td>favorite</td>--%>
<%--            <td><fmt:formatDate value="<%= new java.util.Date(System.currentTimeMillis() - 172800000L) %>" pattern="yyyy-MM-dd HH:mm:ss"/></td>--%>
<%--        </tr>--%>
<%--        <tr>--%>
<%--            <td>4</td>--%>
<%--            <td>1003</td>--%>
<%--            <td>2001</td>--%>
<%--            <td>answer</td>--%>
<%--            <td><fmt:formatDate value="<%= new java.util.Date(System.currentTimeMillis() - 259200000L) %>" pattern="yyyy-MM-dd HH:mm:ss"/></td>--%>
<%--        </tr>--%>
<%--        </tbody>--%>
<%--    </table>--%>
<%--</div>--%>

<%--<script>--%>
<%--    layui.use('table', function () {--%>
<%--        var table = layui.table;--%>

<%--        // 可选：初始化表格，如果需要分页或排序等功能--%>
<%--        table.render({--%>
<%--            elem: '.layui-table',--%>
<%--            page: true, // 开启分页--%>
<%--            limit: 10 // 每页显示条数--%>
<%--            // 可以添加其他配置，如排序、搜索等--%>
<%--        });--%>
<%--    });--%>
<%--</script>--%>

<%--</body>--%>
<%--</html>--%>

<%--<!DOCTYPE html>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <title>操作历史记录</title>--%>
<%--    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/layui/2.8.0/css/layui.css">--%>
<%--</head>--%>
<%--<body>--%>
<%--&lt;%&ndash;公共头部开始&ndash;%&gt;--%>
<%--<jsp:include page="/WEB-INF/jsp/common/head.jsp"></jsp:include>--%>
<%--&lt;%&ndash;公共头部结束&ndash;%&gt;--%>

<%--<div class="layui-container" style="margin-top: 15px;">--%>
<%--    <div class="layui-card">--%>
<%--        <div class="layui-card-header">--%>
<%--            <h2>操作历史记录</h2>--%>
<%--        </div>--%>
<%--        <div class="layui-card-body">--%>
<%--            <form class="layui-form" action="">--%>
<%--                <div class="layui-form-item">--%>
<%--                    <div class="layui-inline">--%>
<%--                        <label class="layui-form-label">交互类型</label>--%>
<%--                        <div class="layui-input-inline">--%>
<%--                            <select name="interactionType" lay-filter="interactionType">--%>
<%--                                <option value="">全部</option>--%>
<%--                                <option value="view">查看</option>--%>
<%--                                <option value="like">点赞</option>--%>
<%--                                <option value="favorite">收藏</option>--%>
<%--                                <option value="answer">回答</option>--%>
<%--                            </select>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="layui-inline">--%>
<%--                        <label class="layui-form-label">日期范围</label>--%>
<%--                        <div class="layui-input-inline">--%>
<%--                            <input type="text" name="dateRange" class="layui-input" id="dateRange" placeholder="请选择日期范围">--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="layui-inline">--%>
<%--                        <button class="layui-btn" lay-submit lay-filter="searchSubmit">查询</button>--%>
<%--                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </form>--%>

<%--            <table id="historyTable" lay-filter="historyTable"></table>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>

<%--<script type="text/html" id="tableBar">--%>
<%--    <a class="layui-btn layui-btn-xs" lay-event="detail">查看详情</a>--%>
<%--</script>--%>

<%--<script src="${pageContext.servletContext.contextPath}/assets/layui-2.8.0/src/layui.js"></script>--%>
<%--<script>--%>
<%--    layui.use(['table', 'form', 'laydate'], function(){--%>
<%--        var table = layui.table,--%>
<%--            form = layui.form,--%>
<%--            laydate = layui.laydate;--%>

<%--        laydate.render({--%>
<%--            elem: '#dateRange',--%>
<%--            type: 'datetime',--%>
<%--            range: true--%>
<%--        });--%>

<%--        // 静态数据--%>
<%--        var mockData = {--%>
<%--            "code": 200,--%>
<%--            "msg": "success",--%>
<%--            "count": 100,--%>
<%--            "data": [--%>
<%--                {id: 1, userId: 1001, questionId: 2001, interactionType: 'view', createDate: '2024-03-27 10:00:00'},--%>
<%--                {id: 2, userId: 1002, questionId: 2002, interactionType: 'like', createDate: '2024-03-27 09:30:00'},--%>
<%--                {id: 3, userId: 1003, questionId: 2003, interactionType: 'favorite', createDate: '2024-03-27 09:00:00'},--%>
<%--                {id: 4, userId: 1004, questionId: 2004, interactionType: 'answer', createDate: '2024-03-27 08:30:00'},--%>
<%--                {id: 5, userId: 1005, questionId: 2005, interactionType: 'view', createDate: '2024-03-27 08:00:00'},--%>
<%--            ]--%>
<%--        };--%>

<%--        table.render({--%>
<%--            elem: '#historyTable',--%>
<%--            data: mockData.data,--%>
<%--            page: true,--%>
<%--            cols: [[--%>
<%--                {field: 'id', title: 'ID', width: 80, sort: true},--%>
<%--                {field: 'userId', title: '用户ID', width: 100},--%>
<%--                {field: 'questionId', title: '问题ID', width: 100},--%>
<%--                {field: 'interactionType', title: '交互类型', width: 100, templet: function(d){--%>
<%--                        var types = {--%>
<%--                            'view': '查看',--%>
<%--                            'like': '点赞',--%>
<%--                            'favorite': '收藏',--%>
<%--                            'answer': '回答'--%>
<%--                        };--%>
<%--                        return types[d.interactionType] || d.interactionType;--%>
<%--                    }},--%>
<%--                {field: 'createDate', title: '交互时间', width: 180, sort: true},--%>
<%--                {title: '操作', width: 120, toolbar: '#tableBar', fixed: 'right'}--%>
<%--            ]],--%>
<%--            limits: [10, 20, 50, 100],--%>
<%--            limit: 10--%>
<%--        });--%>

<%--        table.on('tool(historyTable)', function(obj){--%>
<%--            if(obj.event === 'detail'){--%>
<%--                layer.alert('ID为' + obj.data.id + ' 的记录详情', {--%>
<%--                    title: '详情信息'--%>
<%--                });--%>
<%--            }--%>
<%--        });--%>

<%--        form.on('submit(searchSubmit)', function(data){--%>
<%--            layer.msg('搜索条件：' + JSON.stringify(data.field));--%>
<%--            return false;--%>
<%--        });--%>
<%--    });--%>
<%--</script>--%>
<%--</body>--%>
<%--</html>--%>