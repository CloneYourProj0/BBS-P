<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 2024/11/14
  Time: 11:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的Bot列表</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!-- 引入 Layui v1.0.9 CSS -->
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/layui/css/layui.css">
    <!-- 引入自定义全局 CSS -->
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/global.css">
</head>
<style>
    .bot-item {
        background-color: #fff;
        border-radius: 5px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        padding: 20px;
        margin-bottom: 20px;
        transition: all 0.3s;
    }

    .bot-item:hover {
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        transform: translateY(-5px);
    }

    .bot-name {
        font-size: 18px;
        color: #333;
        margin-bottom: 10px;
    }

    .bot-time {
        color: #999;
        margin-bottom: 10px;
    }

    .bot-prompt,
    .bot-model {
        color: #666;
        margin-bottom: 5px;
    }

    .bot-actions {
        text-align: right;
    }
</style>
<body>
<%-- 公共头部开始 --%>
<jsp:include page="/WEB-INF/jsp/common/head.jsp"></jsp:include>
<%-- 公共头部结束 --%>

<div class="main layui-clear">
    <div class="wrap">
        <div class="layui-row layui-col-space15">
            <div class="layui-col-md12">
                <div class="layui-card">
                    <div class="layui-card-header">
                        <h1>我的Bot</h1>
                        <button class="layui-btn layui-btn-sm layui-btn-normal" style="float:right;" id="createBotBtn">创建Bot</button>
                    </div>
                    <div class="layui-card-body">
                        <ul id="botList"></ul>
                        <div id="botListPage"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 创建和编辑Bot弹窗（复用） -->
<div id="createBotDialog" class="layui-form" style="display:none; padding: 20px;">
    <input type="hidden" name="id">
    <div class="layui-form-item">
        <label class="layui-form-label">Bot名称</label>
        <div class="layui-input-block">
            <input type="text" name="name" lay-verify="required" placeholder="请输入Bot名称" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">提示语</label>
        <div class="layui-input-block">
            <textarea name="prompt" lay-verify="required" placeholder="请输入提示语" class="layui-textarea"></textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">模型名称</label>
        <div class="layui-input-block">
            <input type="text" name="modelName" lay-verify="required" placeholder="请输入模型名称" autocomplete="off" class="layui-input">
        </div>
    </div>
</div>

<!-- 引入 Layui v1.0.9 JS -->
<script src="${pageContext.servletContext.contextPath}/assets/layui/lay/dest/layui.all.js"></script>
<script>
    layui.use(['laypage', 'layer', 'form'], function() {
        var laypage = layui.laypage;
        var layer = layui.layer;
        var form = layui.form();
        var $ = layui.jquery;

        // 初始化加载Bot列表
        loadInitialBots();

        function loadInitialBots() {
            loadBotList(1);
        }

        // 渲染Bot列表
        function renderBotList(list, totalCount, page) {
            var botListHtml = '';

            if (list.length === 0) {
                $('#botList').html('<p>暂无Bot信息</p>');
                renderPage(totalCount, page);
                return;
            }

            layui.each(list, function(index, bot) {
                botListHtml +=
                    '<div class="bot-item">' +
                    '  <div class="layui-row layui-col-space15">' +
                    '    <div class="layui-col-md8">' +
                    '      <div class="bot-name">' + escapeHtml(bot.name) + '</div>' +
                    '      <div class="bot-time">创建时间: ' + formatDate(bot.createdTime) + '</div>' +
                    '      <div class="bot-prompt">提示语: ' + escapeHtml(bot.prompt) + '</div>' +
                    '      <div class="bot-model">模型名称: ' + escapeHtml(bot.modelName) + '</div>' +
                    '    </div>' +
                    '    <div class="layui-col-md4 bot-actions">' +
                    '      <button class="layui-btn layui-btn-sm" onclick="viewBotDetail(' + bot.id + ')">查看</button>' +
                    '      <button class="layui-btn layui-btn-sm" onclick="editBot(' + bot.id + ')">编辑</button>' +
                    '      <button class="layui-btn layui-btn-sm layui-btn-danger" onclick="deleteBot(' + bot.id + ')">删除</button>' +
                    '    </div>' +
                    '  </div>' +
                    '</div>';
            });

            $('#botList').html(botListHtml);
            renderPage(totalCount, page);
        }

        // 渲染分页（适用于Layui v1.0.9）
        function renderPage(totalCount, page) {
            laypage({
                cont: 'botListPage',
                pages: Math.ceil(totalCount / 1), // 每页10条
                curr: page,
                skin: '#1E9FFF',
                jump: function(obj, first) {
                    if (!first) {
                        loadBotList(obj.curr);
                    }
                }
            });
        }

        // 加载指定页码的Bot列表
        function loadBotList(page) {
            $.ajax({
                url: '${pageContext.servletContext.contextPath}/AiService/getMyBots',
                type: 'GET',
                data: { page: page, limit: 1 },
                dataType: 'json',
                success: function(result) {
                    if (result.code === 0) {
                        var list = result.data.list;
                        var totalCount = result.data.totalCount;
                        renderBotList(list, totalCount, page);
                    } else {
                        layer.msg('加载Bot列表失败: ' + result.msg, {icon: 2});
                    }
                },
                error: function() {
                    layer.msg('请求失败，请稍后重试', {icon: 2});
                }
            });
        }

        // 格式化日期
        function formatDate(datetime) {
            var date = new Date(datetime);
            var Y = date.getFullYear() + '-';
            var M = (date.getMonth()+1 < 10 ? '0' + (date.getMonth()+1) : date.getMonth()+1) + '-';
            var D = (date.getDate() < 10 ? '0' + date.getDate() : date.getDate()) + ' ';
            var h = (date.getHours() < 10 ? '0' + date.getHours() : date.getHours()) + ':';
            var m = (date.getMinutes() < 10 ? '0' + date.getMinutes() : date.getMinutes()) + ':';
            var s = (date.getSeconds() < 10 ? '0' + date.getSeconds() : date.getSeconds());
            return Y + M + D + h + m + s;
        }

        // 防止XSS攻击，转义HTML
        function escapeHtml(text) {
            var map = {
                '&': '&amp;',
                '<': '&lt;',
                '>': '&gt;',
                '"': '&quot;',
                "'": '&#039;'
            };
            return text.replace(/[&<>"']/g, function(m) { return map[m]; });
        }

        // 监听创建Bot按钮点击
        $('#createBotBtn').click(function(){
            var $botDialog = $('#createBotDialog');

            // 检查弹窗是否可见
            if($botDialog.is(':visible')){
                return; // 如果弹窗已经可见,则不做任何操作
            }

            // 检查表单是否有内容
            var hasContent = $botDialog.find('input[name="name"]').val() ||
                $botDialog.find('textarea[name="prompt"]').val() ||
                $botDialog.find('input[name="modelName"]').val();

            // 如果表单有内容,则清空表单字段
            if(hasContent){
                $botDialog.find('input[name="id"]').val('');
                $botDialog.find('input[name="name"]').val('');
                $botDialog.find('textarea[name="prompt"]').val('');
                $botDialog.find('input[name="modelName"]').val('');
                $botDialog.find('input, textarea').prop('readonly', false);
            }

            layer.open({
                type: 1,
                title: '创建新Bot',
                area: ['500px', '400px'],
                content: $botDialog,
                btn: ['立即创建', '取消'],
                yes: function(index, layero){
                    // 获取表单数据
                    var data = {
                        name: $botDialog.find('input[name="name"]').val(),
                        prompt: $botDialog.find('textarea[name="prompt"]').val(),
                        modelName: $botDialog.find('input[name="modelName"]').val()
                    };

                    // 发送创建Bot的请求
                    $.ajax({
                        url: '${pageContext.servletContext.contextPath}/AiService/createBot',
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify(data),
                        success: function(result){
                            if(result.code === 0){
                                $botDialog.hide(); // 创建成功后隐藏弹窗
                                layer.msg("创建成功", {icon: 1});
                                loadBotList(1); // 更新成功后刷新列表
                            } else {
                                layer.msg(result.msg, {icon: 2});
                            }
                        },
                        error: function(){
                            layer.msg("请求失败,请稍后重试", {icon: 2});
                        }
                    });
                    layer.close(index);
                    $botDialog.hide(); // 点击取消按钮隐藏弹窗
                },
                btn2: function(index, layero){
                    $botDialog.hide(); // 点击取消按钮隐藏弹窗
                },
                cancel: function(){
                    $botDialog.hide(); // 点击关闭按钮隐藏弹窗
                }
            });
        });

        // 查看Bot详情
        window.viewBotDetail = function(botId) {
            $.ajax({
                url: '${pageContext.servletContext.contextPath}/AiService/getBotById',
                type: 'GET',
                data: { id: botId },
                dataType: 'json',
                success: function(result) {
                    if (result.code === 0) {
                        var bot = result.data;
                        var $botDialog = $('#createBotDialog');

                        // 填充数据
                        $botDialog.find('input[name="id"]').val(bot.id);
                        $botDialog.find('input[name="name"]').val(bot.name);
                        $botDialog.find('textarea[name="prompt"]').val(bot.prompt);
                        $botDialog.find('input[name="modelName"]').val(bot.modelName);

                        // 设置为只读
                        $botDialog.find('input, textarea').prop('readonly', true);
                        form.render();

                        layer.open({
                            type: 1,
                            title: 'Bot详情',
                            area: ['500px', '400px'],
                            content: $botDialog,
                            btn: ['关闭'],
                            yes: function(index, layero){
                                layer.close(index);
                                $botDialog.hide(); // 点击取消按钮隐藏弹窗
                            },
                            btn2: function(index, layero){
                                $botDialog.hide(); // 点击取消按钮隐藏弹窗
                            },
                            cancel: function(){
                                $botDialog.hide(); // 点击关闭按钮隐藏弹窗
                            },
                            success: function(layero, index){
                                form.render();
                            },
                            end: function(){
                                // 恢复表单可编辑状态
                                $botDialog.find('input, textarea').prop('readonly', false);
                            }
                        });
                    } else {
                        layer.msg('获取Bot详情失败: ' + result.msg, {icon: 2});
                    }
                },
                error: function(){
                    layer.msg('请求失败，请稍后重试', {icon: 2});
                }
            });
        };

        // 编辑Bot
        window.editBot = function(botId) {
            $.ajax({
                url: '${pageContext.servletContext.contextPath}/AiService/getBotById',
                type: 'GET',
                data: { id: botId },
                dataType: 'json',
                success: function(result) {
                    if (result.code === 0) {
                        var bot = result.data;
                        var $botDialog = $('#createBotDialog');

                        // 填充数据
                        $botDialog.find('input[name="id"]').val(bot.id);
                        $botDialog.find('input[name="name"]').val(bot.name);
                        $botDialog.find('textarea[name="prompt"]').val(bot.prompt);
                        $botDialog.find('input[name="modelName"]').val(bot.modelName);

                        // 确保表单可编辑
                        $botDialog.find('input, textarea').prop('readonly', false);
                        form.render();

                        layer.open({
                            type: 1,
                            title: '编辑Bot',
                            area: ['500px', '400px'],
                            content: $botDialog,
                            btn: ['保存修改', '取消'],
                            yes: function(index, layero){
                                // 获取表单数据
                                var data = {
                                    id: $botDialog.find('input[name="id"]').val(),
                                    name: $botDialog.find('input[name="name"]').val(),
                                    prompt: $botDialog.find('textarea[name="prompt"]').val(),
                                    modelName: $botDialog.find('input[name="modelName"]').val()
                                };

                                // 发送更新Bot的请求
                                $.ajax({
                                    url: '${pageContext.servletContext.contextPath}/AiService/updateBot',
                                    type: 'POST',
                                    contentType: 'application/json',
                                    data: JSON.stringify(data),
                                    success: function(result){
                                        if(result.code === 0){
                                            layer.close(index);
                                            layer.msg("更新成功", {icon: 1});
                                            loadBotList(1); // 更新成功后刷新列表
                                        } else {
                                            layer.msg(result.msg, {icon: 2});
                                        }
                                    },
                                    error: function(){
                                        layer.msg("请求失败,请稍后重试", {icon: 2});
                                    }
                                });
                                $botDialog.hide(); // 点击取消按钮隐藏弹窗
                            },
                            btn2: function(index, layero){
                                $botDialog.hide(); // 点击取消按钮隐藏弹窗
                            },
                            cancel: function(){
                                $botDialog.hide(); // 点击关闭按钮隐藏弹窗
                            },
                            success: function(layero, index){
                                form.render();
                            }
                        });
                    } else {
                        layer.msg('获取Bot详情失败: ' + result.msg, {icon: 2});
                    }
                },
                error: function(){
                    layer.msg('请求失败,请稍后重试', {icon: 2});
                }
            });
        };

        // 删除Bot
        window.deleteBot = function(botId) {
            layer.confirm('确定要删除这个Bot吗？', {icon: 3, title:'提示'}, function(index){
                $.ajax({
                    url: '${pageContext.servletContext.contextPath}/AiService/deleteBot',
                    type: 'POST',
                    data: { id: botId },
                    dataType: 'json',
                    success: function(result){
                        if(result.code === 0){
                            layer.close(index);
                            layer.msg("删除成功", {icon: 1});
                            loadBotList(1); // 删除成功后刷新列表
                        } else {
                            layer.msg(result.msg, {icon: 2});
                        }
                    },
                    error: function(){
                        layer.msg('请求失败，请稍后重试', {icon: 2});
                    }
                });
            });
        };

        // 监听表单提交（通用Bot操作）
        form.on('submit(submitBot)', function(data){
            // 这里的提交逻辑已经在创建和编辑按钮的点击事件中处理，无需重复
            return false;
        });

    });
</script>
</body>
</html>
