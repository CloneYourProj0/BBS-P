<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.gem.bbs.entity.User" %>
<%@ page import="com.gem.bbs.entity.Question" %>
<%@ page import="com.gem.bbs.entity.Answer" %>
<%@ page import="com.gem.bbs.entity.User" %>
<%@ page import="com.gem.bbs.entity.Question" %>
<%@ page import="com.gem.bbs.entity.PageResult" %>
<%@ page import="com.gem.bbs.entity.*" %>
<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"admin".equals(currentUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/user/loginPage");
        return;
    }

    // 获取用户列表
//    List<User> userList = (List<User>) request.getAttribute("userList");
    PageResult pageResult = (PageResult) request.getAttribute("pageResult");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理员管理页面</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/layui@2.6.8/dist/css/layui.css">
    <script src="https://cdn.jsdelivr.net/npm/layui@2.6.8/dist/layui.js"></script>
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
        }

        .admin-header {
            background: white;
            padding: 16px 24px;
            margin-bottom: 24px;
            border-radius: 4px;
            box-shadow: 0 1px 4px rgba(0,21,41,.08);
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
            <li class="layui-nav-item layui-this">
                <a href="<%= request.getContextPath() %>/admin/dashboard">
                    <i class="layui-icon layui-icon-user"></i> 用户管理
                </a>
            </li>
            <li class="layui-nav-item">
                <a href="<%= request.getContextPath() %>/admin/viewUserPosts">
                    <i class="layui-icon layui-icon-list"></i> 帖子管理
                </a>
            </li>
            <li class="layui-nav-item">
                <a href="<%= request.getContextPath() %>/admin/viewUserAnswers">
                    <i class="layui-icon layui-icon-dialogue"></i> 回复管理
                </a>
            </li>
        </ul>
    </div>

    <!-- 主内容区 -->
    <div class="admin-main">
        <!-- 页面标题 -->
        <div class="admin-header">
            <h2>用户管理</h2>
        </div>

        <!-- 搜索框 -->
        <div class="search-box">
            <div class="layui-form">
                <div class="layui-input-inline">
                    <input type="text" id="searchUser" placeholder="请输入用户名/邮箱搜索" class="layui-input">
                </div>
                <button class="layui-btn" id="searchBtn">
                    <i class="layui-icon layui-icon-search"></i> 搜索
                </button>
            </div>
        </div>

        <!-- 用户列表 -->
        <!-- 只需要一个表格容器 -->
        <table id="userTable" ></table>

        <!-- 操作列模板 -->
        <script type="text/html" id="tableToolbar">
            <a class="layui-btn layui-btn-sm" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-danger layui-btn-sm" lay-event="del">删除</a>
            <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="view">查看帖子</a>
        </script>

        <script>
            layui.use(['table'], function(){
                var table = layui.table;

                //渲染表格
                table.render({
                    elem: '#userTable'
                    ,url: '${pageContext.request.contextPath}/admin/users' //接口URL
                    ,page: true //开启分页
                    ,cellMinWidth: 80
                    ,cols: [[ //表头设置
                        {field: 'id', title: 'ID', width: 80}
                        ,{field: 'loginname', title: '登录名',}
                        ,{field: 'username', title: '用户名', }
                        ,{field: 'nickname', title: '昵称', }
                        ,{field: 'email', title: '邮箱', }
                        ,{field: 'createtime', title: '创建时间',}
                        ,{title: '操作', toolbar: '#tableToolbar', width: 220}
                    ]]
                    ,parseData: function(res){ //转换数据格式以匹配PageResult
                        return {
                            "code": 0
                            ,"msg": ""
                            ,"count": res.total
                            ,"data": res.data
                        };
                    }

                });

                //监听工具条事件
                table.on('tool(userTable)', function(obj){
                    var data = obj.data;
                    if(obj.event === 'edit'){
                        window.location.href = '${pageContext.request.contextPath}/admin/editUser?id=' + data.id;
                    } else if(obj.event === 'del'){
                        layer.confirm('确认删除此用户?', function(index){
                            window.location.href = '${pageContext.request.contextPath}/admin/deleteUser?id=' + data.id;
                            layer.close(index);
                        });
                    } else if(obj.event === 'view'){
                        window.location.href = '${pageContext.request.contextPath}/admin/viewUserPosts?id=' + data.id;
                    }
                });
            });
            </script>
        </div>
    </div>
</body>
</html>