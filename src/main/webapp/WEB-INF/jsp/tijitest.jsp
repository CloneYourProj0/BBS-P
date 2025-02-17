<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 2024/11/11
  Time: 20:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<html>--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <title>@提及功能示例 - layui v1.0.9 和 Tribute.js</title>--%>
<%--     <!-- 引入 Tribute.js CSS -->--%>
<%--    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/tribute.css">--%>
<%--    <style>--%>
<%--        /* 自定义 Tribute.js 下拉菜单样式以匹配 layui */--%>
<%--        .tribute-container {--%>
<%--            z-index: 1000; /* 确保下拉菜单显示在最前 */--%>
<%--        }--%>
<%--        .tribute-item {--%>
<%--            padding: 5px 10px;--%>
<%--            cursor: pointer;--%>
<%--        }--%>
<%--        .tribute-item:hover, .tribute-item.tribute-active {--%>
<%--            background-color: #e6f7ff;--%>
<%--        }--%>
<%--    </style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="layui-container" style="margin-top: 50px;">--%>
<%--    <form class="layui-form" id="messageForm">--%>
<%--        <div class="layui-form-item">--%>
<%--            <label class="layui-form-label">消息内容</label>--%>
<%--            <div class="layui-input-block">--%>
<%--                <textarea id="messageContent" placeholder="输入消息，使用@提及用户" class="layui-textarea" rows="5"></textarea>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="layui-form-item">--%>
<%--            <button class="layui-btn" type="submit">发送</button>--%>
<%--        </div>--%>
<%--    </form>--%>
<%--</div>--%>

<%--<!-- 引入 jQuery（layui v1.0.9 依赖） -->--%>
<%--<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>--%>
<%--<!-- 引入 layui v1.0.9 JS -->--%>
<%--<script src="${pageContext.servletContext.contextPath}/assets/layui/layui.js"></script>--%>
<%--<!-- 引入 Tribute.js JS -->--%>
<%--<script src="${pageContext.servletContext.contextPath}/js/tribute.min.js"></script>--%>

<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <title>@提及测试</title>--%>
<%--    <!-- 引入 Tribute CSS -->--%>
<%--    <style>--%>
<%--        .tribute-container {--%>
<%--            position: absolute;--%>
<%--            top: 0;--%>
<%--            left: 0;--%>
<%--            height: auto;--%>
<%--            max-height: 300px;--%>
<%--            overflow: auto;--%>
<%--            display: block;--%>
<%--            z-index: 999999;--%>
<%--            background: white;--%>
<%--            border: 1px solid #dcdcdc;--%>
<%--            border-radius: 4px;--%>
<%--            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);--%>
<%--        }--%>

<%--        .tribute-container ul {--%>
<%--            margin: 0;--%>
<%--            padding: 0;--%>
<%--            list-style: none;--%>
<%--        }--%>

<%--        .tribute-container li {--%>
<%--            padding: 8px 12px;--%>
<%--            cursor: pointer;--%>
<%--        }--%>

<%--        .tribute-container li.highlight {--%>
<%--            background: #f0f0f0;--%>
<%--        }--%>

<%--        /* 输入框样式 */--%>
<%--        #getaibot {--%>
<%--            width: 100%;--%>
<%--            height: 100px;--%>
<%--            padding: 10px;--%>
<%--            border: 1px solid #dcdcdc;--%>
<%--            border-radius: 4px;--%>
<%--            margin-top: 20px;--%>
<%--        }--%>
<%--    </style>--%>
<%--    <!-- 引入 Tribute JS -->--%>
<%--    <script src="https://cdn.jsdelivr.net/npm/tributejs@5.1.3/dist/tribute.min.js"></script>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div style="width: 80%; margin: 0 auto;">--%>
<%--    <h2>@提及测试</h2>--%>
<%--    <textarea id="getaibot" placeholder="输入 @ 来提及用户..."></textarea>--%>
<%--</div>--%>

<%--<script>--%>
<%--    document.addEventListener('DOMContentLoaded', function() {--%>
<%--        // 初始化 Tribute--%>
<%--        var tribute = new Tribute({--%>
<%--            trigger: '@',--%>
<%--            values: function (text, cb) {--%>
<%--                // 模拟后端数据--%>
<%--                // const mockData = [--%>
<%--                //     { username: '张三', id: 1 },--%>
<%--                //     { username: '李四', id: 2 },--%>
<%--                //     { username: '王五', id: 3 },--%>
<%--                //     { username: '赵六', id: 4 }--%>
<%--                // ];--%>

<%--                // 模拟异步请求--%>
<%--                setTimeout(() => {--%>
<%--                    const filteredData = mockData.filter(user =>--%>
<%--                        user.username.includes(text)--%>
<%--                    );--%>
<%--                    const values = filteredData.map(user => ({--%>
<%--                        key: user.username,--%>
<%--                        value: user.id--%>
<%--                    }));--%>
<%--                    cb(values);--%>
<%--                }, 100);--%>

<%--                // 如果要连接实际后端，使用下面的代码--%>
<%--                fetch(`${contextPath}/getUserList?query=${text}`)--%>
<%--                        .then(response => response.json())--%>
<%--                        .then(result => {--%>
<%--                            if (result.status === 'success') {--%>
<%--                                const values = result.data.map(user => ({--%>
<%--                                    key: user.username,--%>
<%--                                    value: user.id--%>
<%--                                }));--%>
<%--                                cb(values);--%>
<%--                            }--%>
<%--                        })--%>
<%--                        .catch(error => {--%>
<%--                            console.error('Error:', error);--%>
<%--                            cb([]);--%>
<%--                        });--%>

<%--            },--%>
<%--            menuItemTemplate: function (item) {--%>
<%--                return item.original.key;--%>
<%--            },--%>
<%--            selectTemplate: function (item) {--%>
<%--                return '@' + item.original.key;--%>
<%--            },--%>
<%--            noMatchTemplate: function () {--%>
<%--                return '<span style="padding: 8px 12px; display: block;">没有找到匹配的用户</span>';--%>
<%--            },--%>
<%--            lookup: 'key',--%>
<%--            fillAttr: 'value',--%>
<%--            requireLeadingSpace: false,--%>
<%--            allowSpaces: true,--%>
<%--            menuShowMinLength: 0,--%>
<%--            menuContainer: document.body,--%>
<%--            positionMenu: true,--%>
<%--            menuItemLimit: 5--%>
<%--        });--%>

<%--        // 将 Tribute 附加到输入框--%>
<%--        tribute.attach(document.getElementById('getaibot'));--%>

<%--        // 添加事件监听，用于调试--%>
<%--        document.getElementById('getaibot').addEventListener('tribute-active-true', function() {--%>
<%--            console.log('Tribute menu opened');--%>
<%--        });--%>

<%--        document.getElementById('getaibot').addEventListener('tribute-active-false', function() {--%>
<%--            console.log('Tribute menu closed');--%>
<%--        });--%>
<%--    });--%>
<%--</script>--%>
<%--</body>--%>
<%--</html>--%>





<%--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>--%>
<%--<!DOCTYPE html>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <meta charset="utf-8">--%>
<%--    <title>发表问题</title>--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">--%>
<%--    <meta name="keywords" content="fly,layui,前端社区">--%>
<%--    <meta name="description" content="Fly社区是模块化前端UI框架Layui的官网社区，致力于为web开发提供强劲动力">--%>

<%--    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/layui/css/layui.css">--%>
<%--    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/global.css">--%>
<%--    <script src="${pageContext.servletContext.contextPath}/assets/layui/layui.js"></script>--%>
<%--    <script src="${pageContext.servletContext.contextPath}/js/jquery-3.2.1.js"></script>--%>
<%--</head>--%>
<%--<style>--%>
<%--    .tribute-container {--%>
<%--        position: absolute !important;--%>
<%--        top: 0;--%>
<%--        left: 0;--%>
<%--        height: auto;--%>
<%--        max-height: 300px;--%>
<%--        overflow: auto;--%>
<%--        display: block !important;--%>
<%--        visibility: visible !important;--%>
<%--        opacity: 1 !important;--%>
<%--        z-index: 999999 !important;--%>
<%--        background: white !important;--%>
<%--        border: 1px solid #dcdcdc !important;--%>
<%--        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2) !important;--%>
<%--        min-width: 200px !important;--%>
<%--    }--%>

<%--    .tribute-container ul {--%>
<%--        margin: 0;--%>
<%--        padding: 0;--%>
<%--        list-style: none;--%>
<%--        display: block !important;--%>
<%--        visibility: visible !important;--%>
<%--    }--%>

<%--    .tribute-container li {--%>
<%--        display: block !important;--%>
<%--        padding: 8px 12px !important;--%>
<%--        border-bottom: 1px solid #eee !important;--%>
<%--        cursor: pointer;--%>
<%--    }--%>

<%--    .tribute-container li.highlight {--%>
<%--        background: #f0f0f0;--%>
<%--    }--%>

<%--    #getaibot {--%>
<%--        width: 100%;--%>
<%--        height: 100px;--%>
<%--        padding: 10px;--%>
<%--        border: 1px solid #dcdcdc;--%>
<%--        border-radius: 4px;--%>
<%--    }--%>
<%--</style>--%>
<%--<body>--%>


<%--<!DOCTYPE html>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <meta charset="utf-8">--%>
<%--    <title>测试页面</title>--%>
<%--    &lt;%&ndash; 暂时只保留必要的库 &ndash;%&gt;--%>
<%--    <!-- 1. 先添加 layui -->--%>
<%--    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/layui/css/layui.css">--%>
<%--    <script src="${pageContext.servletContext.contextPath}/assets/layui/layui.js"></script>--%>

<%--    <!-- 2. 再添加 jQuery -->--%>
<%--    <script src="${pageContext.servletContext.contextPath}/js/jquery-3.2.1.js"></script>--%>

<%--    <!-- 3. 最后添加 Tribute -->--%>
<%--    <script src="https://cdn.jsdelivr.net/npm/tributejs@5.1.3/dist/tribute.min.js"></script>--%>
<%--</head>--%>
<%--<style>--%>
<%--    /* 基础样式 */--%>
<%--    #getaibot {--%>
<%--        width: 300px;--%>
<%--        height: 100px;--%>
<%--        padding: 10px;--%>
<%--    }--%>

<%--    /* Tribute样式 */--%>
<%--    .tribute-container {--%>
<%--        position: absolute;--%>
<%--        top: 0;--%>
<%--        left: 0;--%>
<%--        height: auto;--%>
<%--        max-height: 300px;--%>
<%--        overflow: auto;--%>
<%--        display: block;--%>
<%--        background: white;--%>
<%--        border: 1px solid #dcdcdc;--%>
<%--    }--%>

<%--    .tribute-container ul {--%>
<%--        margin: 0;--%>
<%--        padding: 0;--%>
<%--        list-style: none;--%>
<%--    }--%>

<%--    .tribute-container li {--%>
<%--        padding: 8px 12px;--%>
<%--        cursor: pointer;--%>
<%--    }--%>

<%--    .tribute-container li.highlight {--%>
<%--        background: #f0f0f0;--%>
<%--    }--%>
<%--</style>--%>
<%--<body>--%>
<%--<textarea id="getaibot" placeholder="输入 @ 来提及用户..."></textarea>--%>

<%--<script>--%>
<%--    document.addEventListener('DOMContentLoaded', function() {--%>
<%--        var tribute = new Tribute({--%>
<%--            trigger: '@',--%>
<%--            values: [--%>
<%--                { key: '张三', value: '1' },--%>
<%--                { key: '李四', value: '2' },--%>
<%--                { key: '王五', value: '3' }--%>
<%--            ],--%>
<%--            menuItemTemplate: function (item) {--%>
<%--                return item.original.key;--%>
<%--            },--%>
<%--            selectTemplate: function (item) {--%>
<%--                return '@' + item.original.key;--%>
<%--            }--%>
<%--        });--%>

<%--        tribute.attach(document.getElementById('getaibot'));--%>
<%--    });--%>
<%--</script>--%>
<%--</body>--%>
<%--</html>--%>


<!DOCTYPE html>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>Tribute.js 示例</title>
    <!-- 引入 Tribute.js 的 CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tributejs/5.2.3/tribute.css">
</head>
<body>
<!-- 输入框 -->
<textarea id="input" rows="5" cols="50" placeholder="输入@来提及用户..."></textarea>
<button id="submit">提交</button>
<script>
    document.getElementById('submit').addEventListener('click', function () {
        const content = input.value;
        // 使用正则匹配所有@提及的格式
        const regex = /@\[([^\]]+)\]\((\d+)\)/g;
        let match;
        const mentions = [];

        while ((match = regex.exec(content)) !== null) {
            // match[1] 是名字，match[2] 是ID
            mentions.push({ name: match[1], id: match[2] });
        }

        // 例如，提交的内容和提及的用户ID
        console.log('提交内容:', content);
        console.log('提及的用户ID:', mentions);

        // 在这里可以将数据发送到服务器
    });
</script>

<!-- 引入 Tribute.js 的 JS -->
<script src="https://cdn.jsdelivr.net/npm/tributejs@5.1.3/dist/tribute.min.js"></script>
<script>
    // JavaScript 代码将在这里编写
    const users = [
        { id: 1, name: '张三' },
        { id: 2, name: '李四' },
        { id: 3, name: '王五' },
        // 添加更多用户
    ];
    const tribute = new Tribute({
        values: users,
        lookup: 'name', // 用户输入时匹配的字段
        fillAttr: 'name', // 输入框中显示的内容
        selectTemplate: function (item) {
            if (item.original) {
                return `<span>@${item.original.name}</span>`;
            }
        },
        menuItemTemplate: function (item) {
            if (item.original) {
                return `<div>${item.original.name} (ID: ${item.original.id})</div>`;
            }
        }
    });

    // 绑定 Tribute 到输入框
    const input = document.getElementById('input');
    tribute.attach(input);

</script>
</body>
</html>



