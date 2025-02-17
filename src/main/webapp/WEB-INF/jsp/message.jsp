<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 2024/11/8
  Time: 22:02
  To change this template use File | Settings | File Templates.

  By-claude-sonnet-3.5 其实可以删了，没有用到它....
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>消息管理</title>
  <link rel="stylesheet" href="/layui/css/layui.css">
  <script src="/layui/layui.js"></script>
</head>
<body>
<div class="layui-container">
  <!-- 消息列表 -->
  <div class="layui-row">
    <div class="layui-col-md12">
      <div class="layui-card">
        <div class="layui-card-header">
          <h2>消息列表</h2>
        </div>
        <div class="layui-card-body">
          <table id="messageTable" lay-filter="messageTable"></table>
        </div>
      </div>
    </div>
  </div>

  <!-- 回复框模板 -->
  <script type="text/html" id="replyDialog">
    <form class="layui-form" style="padding: 20px;">
      <div class="layui-form-item layui-form-text">
                    <textarea name="content" required lay-verify="required"
                              placeholder="请输入回复内容" class="layui-textarea"></textarea>
      </div>
    </form>
  </script>
</div>

<script>
  layui.use(['layer', 'table', 'form'], function(){
    var layer = layui.layer;
    var table = layui.table;
    var form = layui.form;
    var $ = layui.jquery;

    // SSE连接对象
    let eventSource = null;

    // 建立SSE连接
    function connectSSE() {
      if (eventSource) {
        eventSource.close();
      }

      eventSource = new EventSource('${pageContext.servletContext.contextPath}/message/connect');

      // 监听消息
      eventSource.onmessage = function(event) {
        layer.msg(event.data, {
          offset: 't',
          anim: 6
        });
        // 刷新消息列表
        if (table) {
          table.reload('messageTable');
        }
      };

      // 错误处理
      eventSource.onerror = function(error) {
        console.error('SSE连接错误:', error);
        if (eventSource) {
          eventSource.close();
          eventSource = null;
        }
        // 5秒后重试
        setTimeout(function() {
          if (!eventSource) {
            connectSSE();
          }
        }, 5000);
      };
    }

    // 发送回复
    window.sendReply = function(toUserId, content) {
      $.ajax({
        url: '${pageContext.servletContext.contextPath}/message/reply',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
          toUserId: toUserId,
          content: content
        }),
        success: function(res) {
          if(res === '101') {
            layer.msg('发送成功');
            // 清空输入框
            $('textarea[name="content"]').val('');
            // 关闭回复框
            layer.closeAll();
            // 刷新消息列表
            if (table) {
              table.reload('messageTable');
            }
          } else {
            layer.msg(res || '发送失败');
          }
        },
        error: function() {
          layer.msg('发送请求失败');
        }
      });
    };

    // 标记消息已读
    window.markAsRead = function(messageId) {
      $.post('${pageContext.servletContext.contextPath}/message/read/' + messageId, function(res) {
        if(res === '101') {
          layer.msg('已标记为已读');
          // 刷新消息列表
          if (table) {
            table.reload('messageTable');
          }
        } else {
          layer.msg('操作失败');
        }
      });
    };

    // 初始化消息表格
    if ($('#messageTable').length > 0) {
      table.render({
        elem: '#messageTable'
        ,url: '${pageContext.servletContext.contextPath}/message/unread'
        ,parseData: function(res) {
          // 处理返回的数据
          if (typeof res === 'string') {
            if (res === '用户未登录') {
              layer.msg('请先登录');
              return {
                "code": 1,
                "msg": "请先登录",
                "count": 0,
                "data": []
              };
            }
          }
          return {
            "code": 0,
            "msg": "",
            "count": res.length,
            "data": res
          };
        }
        ,cols: [[
          {field: 'fromUserId', title: '发送人', width: 100}
          ,{field: 'content', title: '消息内容'}
          ,{field: 'createTime', title: '发送时间', width: 200, templet: function(d){
              return new Date(d.createTime).toLocaleString();
            }}
          ,{field: 'status', title: '状态', width: 100, templet: function(d){
              return d.status == 2 ? '已读' : (d.status == 1 ? '已发送' : '未发送');
            }}
          ,{title: '操作', width: 150, templet: function(d){
              var btns = '<a class="layui-btn layui-btn-xs" lay-event="reply">回复</a>';
              if(d.status != 2){
                btns += '<a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="read">标记已读</a>';
              }
              return btns;
            }}
        ]]
        ,page: true
      });

      // 监听工具条事件
      table.on('tool(messageTable)', function(obj){
        var data = obj.data;
        if(obj.event === 'reply'){
          layer.open({
            type: 1
            ,title: '回复消息'
            ,content: $('#replyDialog').html()
            ,area: ['500px', '300px']
            ,btn: ['发送', '取消']
            ,yes: function(index, layero){
              var content = layero.find('textarea[name="content"]').val();
              if(!content){
                layer.msg('请输入回复内容');
                return;
              }
              sendReply(data.fromUserId, content);
            }
          });
        } else if(obj.event === 'read'){
          markAsRead(data.id);
        }
      });
    }

    // 页面关闭前清理SSE连接
    window.onbeforeunload = function() {
      if (eventSource) {
        eventSource.close();
      }
    };

    // 如果在消息页面，自动建立SSE连接
    if ($('#messageTable').length > 0) {
      connectSSE();
    }
  });
</script>
</body>
</html>
