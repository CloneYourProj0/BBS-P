<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 2025/2/24
  Time: 3:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理员管理页面</title>
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/layui-2.8.0/dist/css/layui.css">
    <script src="${pageContext.servletContext.contextPath}/assets/layui-2.8.0/dist/layui.js"></script>
    <style>
        /* 整体布局 */
        .layout-admin {
            display: flex;
            min-height: 100vh;
        }

        /* 侧边栏 */
        .admin-sidebar {
            width: 240px;
            background: #001529;
            position: fixed;
            left: 0;
            top: 0;
            bottom: 0;
            z-index: 1000;
            box-shadow: 2px 0 6px rgba(0,21,41,.35);
        }

        .admin-sidebar .logo {
            height: 64px;
            line-height: 64px;
            text-align: center;
            font-size: 20px;
            color: white;
            background: #002140;
        }

        .admin-sidebar .layui-nav {
            background: none;
            padding: 16px 0;
        }

        .admin-sidebar .layui-nav .layui-nav-item {
            padding: 4px 20px;
        }

        .admin-sidebar .layui-nav .layui-nav-item a {
            color: rgba(255,255,255,.65);
            padding: 8px 16px;
            margin: 4px 0;
            border-radius: 4px;
        }

        .admin-sidebar .layui-nav .layui-nav-item a:hover {
            color: white;
            background: #1890ff;
        }

        /* 主内容区 */
        .admin-main {
            flex: 1;
            margin-left: 240px;
            padding: 24px;
            background: #f0f2f5;
            width: calc(100% - 240px - 48px); /* 100%宽度减去侧边栏宽度和内边距 */
        }

        .admin-header {
            background: white;
            padding: 16px 24px;
            margin-bottom: 24px;
            border-radius: 4px;
            box-shadow: 0 1px 4px rgba(0,21,41,.08);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .admin-header h2 {
            margin: 0;
            color: rgba(0,0,0,.85);
            font-size: 20px;
        }

        /* 搜索区域 */
        .search-box {
            background: white;
            padding: 24px;
            margin-bottom: 24px;
            border-radius: 4px;
        }

        .search-box .layui-input {
            width: 320px;
        }

        .search-box .layui-btn {
            margin-left: 16px;
            background: #1890ff;
        }

        /* 表格样式优化 */
        .layui-table {
            margin-top: 0;
            background: white;
            border-radius: 4px;
        }

        .layui-table thead tr {
            background: #fafafa;
        }

        .layui-table td, .layui-table th {
            padding: 12px 16px;
        }

        /* 操作按钮组 */
        .table-actions .layui-btn + .layui-btn {
            margin-left: 8px;
        }

        .table-actions .layui-btn-sm {
            height: 24px;
            line-height: 24px;
            padding: 0 8px;
        }

        /* 响应式适配 */
        @media screen and (max-width: 768px) {
            .admin-sidebar {
                width: 80px;
            }

            .admin-main {
                margin-left: 80px;
            }

            .admin-sidebar .logo {
                font-size: 16px;
            }

            .search-box .layui-input {
                width: 100%;
            }

            .search-box .layui-btn {
                margin: 16px 0 0;
                width: 100%;
            }
        }

        .pagination {
            text-align: center;
            padding: 20px 0;
        }

        .pagination a {
            display: inline-block;
            padding: 8px 12px;
            margin: 0 5px;
            border: 1px solid #e2e2e2;
            text-decoration: none;
            color: #666;
            border-radius: 2px;
        }

        .pagination a:hover {
            background-color: #1E9FFF;
            color: white;
            border-color: #1E9FFF;
        }

        .pagination .active {
            background-color: #1E9FFF;
            color: white;
            border-color: #1E9FFF;
        }

        .pagination .disabled {
            color: #ccc;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
<div class="layout-admin">
    <!-- 侧边栏 -->
    <div class="admin-sidebar">
        <div class="logo">管理系统</div>
        <ul class="layui-nav layui-nav-tree">
            <li class="layui-nav-item">
                <a href="<%= request.getContextPath() %>/admin/dashboard">
                    <i class="layui-icon layui-icon-user"></i> 用户管理
                </a>
            </li>
            <li class="layui-nav-item layui-this">
                <a href="<%= request.getContextPath() %>/admin/viewUserPosts">
                    <i class="layui-icon layui-icon-list"></i> 帖子管理
                </a>
            </li>
            <li class="layui-nav-item">
                <a href="<%= request.getContextPath() %>/admin/viewAnswers">
                    <i class="layui-icon layui-icon-dialogue"></i> 回复管理
                </a>
            </li>
        </ul>
    </div>
    <!-- 主内容区 -->
    <div class="admin-main">
        <!-- 页面标题 -->
        <div class="admin-header">
            <h2>问题管理</h2>
            <h4><a href="<%= request.getContextPath() %>/index" class="return-btn">返回</a></h4>
        </div>

    <!-- 查询条件表单 -->
    <form class="layui-form" id="queryForm" style="margin-bottom: 20px;">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">用户ID</label>
                <div class="layui-input-inline">
                    <input type="text" name="userId" placeholder="请输入用户ID" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">开始时间</label>
                <div class="layui-input-inline">
                    <input type="text" name="startTime" placeholder="yyyy-MM-dd HH:mm:ss" class="layui-input" id="startTime">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">结束时间</label>
                <div class="layui-input-inline">
                    <input type="text" name="endTime" placeholder="yyyy-MM-dd HH:mm:ss" class="layui-input" id="endTime">
                </div>
            </div>
            <div class="layui-inline">
                <button type="button" class="layui-btn" id="searchBtn">查询</button>
            </div>
        </div>
    </form>

    <!-- 数据表格 -->
    <table id="questionTable" lay-filter="questionTable"></table>
</div>

<!-- 工具栏模板 -->
<script type="text/html" id="questionToolbar">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script>
    layui.use(['table', 'laydate'], function(){
        var table = layui.table,
            laydate = layui.laydate;

        // 初始化日期组件
        laydate.render({
            elem: '#startTime',
            type: 'datetime'
        });
        laydate.render({
            elem: '#endTime',
            type: 'datetime'
        });

        // 渲染问题数据表格
        var tableIns = table.render({
            elem: '#questionTable',
            url: '${pageContext.request.contextPath}/admin/questions', // 后台数据接口地址
            page: true,
            cols: [[
                {field: 'id', title: 'ID',width:70},
                {field: 'title', title: '标题'},
                {field: 'description', title: '描述'},
                {field: 'coin', title: '悬赏积分',width:60 },
                {field: 'userId', title: '用户ID', width: 60},
                {field: 'createtime', title: '创建时间',width: 150 },
                {field: 'isUp', title: '是否置顶',width: 120 },
                {field: 'aiResponseRequested', title: 'AI响应',width: 110},
                {field: 'viewCount', title: '浏览数', width: 100},
                {title: '操作', toolbar: '#questionToolbar',width: 120 }
            ]],
            parseData: function(res){
                return {
                    "code": 0,
                    "msg": "",
                    "count": res.total,
                    "data": res.data
                };
            }
        });

        // 工具栏事件监听
        table.on('tool(questionTable)', function(obj){
            var data = obj.data;
            if(obj.event === 'edit'){
                window.location.href = '${pageContext.request.contextPath}/admin/editQuestion?id=' + data.id;
            } else if(obj.event === 'del'){
                layer.confirm('确定删除该问题吗？', function(index){
                    window.location.href = '${pageContext.request.contextPath}/admin/deleteQuestion?id=' + data.id;
                    layer.close(index);
                });
            }
        });

        // 查询按钮事件处理
        document.getElementById('searchBtn').addEventListener('click', function(){
            // 获取查询条件的值
            var userId = document.querySelector("input[name='userId']").value;
            var startTime = document.querySelector("input[name='startTime']").value;
            var endTime = document.querySelector("input[name='endTime']").value;
            // 重新加载表格数据，并传递查询参数
            table.reload('questionTable', {
                where: {
                    userId: userId,
                    startTime: startTime,
                    endTime: endTime
                },
                page: { curr: 1 }
            });
        });
    });
    </script>
    </div>
</body>
</html>
