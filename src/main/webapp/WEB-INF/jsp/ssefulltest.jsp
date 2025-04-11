<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SSE全流程测试</title>
    <style>
        body {
            font-family: 'Microsoft YaHei', Arial, sans-serif;
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        .panel {
            background-color: #fff;
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .full-width {
            grid-column: 1 / 3;
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        h2 {
            color: #2196F3;
            margin-top: 0;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
        .messages {
            height: 300px;
            overflow-y: auto;
            border: 1px solid #eee;
            padding: 10px;
            background-color: #f9f9f9;
            margin-top: 10px;
        }
        .message {
            padding: 8px;
            margin-bottom: 8px;
            border-radius: 4px;
            position: relative;
        }
        .received {
            background-color: #e3f2fd;
            border-left: 4px solid #2196F3;
        }
        .sent {
            background-color: #e8f5e9;
            border-left: 4px solid #4CAF50;
            text-align: right;
        }
        .system {
            background-color: #fff3e0;
            border-left: 4px solid #FF9800;
        }
        .timestamp {
            font-size: 12px;
            color: #999;
            margin-top: 4px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }
        input[type="text"], input[type="number"], textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            margin-bottom: 10px;
            font-family: inherit;
        }
        button {
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: #45a049;
        }
        button:disabled {
            background-color: #cccccc;
            cursor: not-allowed;
        }
        button.disconnect {
            background-color: #f44336;
        }
        button.disconnect:hover {
            background-color: #d32f2f;
        }
        button.secondary {
            background-color: #2196F3;
        }
        button.secondary:hover {
            background-color: #0b7dda;
        }
        .status {
            padding: 10px;
            margin-top: 10px;
            border-radius: 4px;
            font-weight: bold;
        }
        .status.connected {
            background-color: #e8f5e9;
            color: #4CAF50;
        }
        .status.disconnected {
            background-color: #ffebee;
            color: #f44336;
        }
        .tab-buttons {
            display: flex;
            margin-bottom: 15px;
        }
        .tab-button {
            padding: 10px 20px;
            background-color: #f5f5f5;
            border: 1px solid #ddd;
            border-bottom: none;
            cursor: pointer;
            border-radius: 4px 4px 0 0;
            margin-right: 5px;
        }
        .tab-button.active {
            background-color: #fff;
            border-bottom: 2px solid #4CAF50;
        }
        .tab-content {
            display: none;
        }
        .tab-content.active {
            display: block;
        }
        .clear-btn {
            background-color: #9e9e9e;
            float: right;
        }
        .clear-btn:hover {
            background-color: #757575;
        }
    </style>
</head>
<body>
<h1>Server-Sent Events 全流程测试</h1>

<div class="container">
    <div class="panel full-width">
        <h2>连接管理</h2>
        <div class="form-group">
            <label for="userId">用户ID：</label>
            <input type="number" id="userId" value="1" min="1">
        </div>
        <button id="connectBtn">建立SSE连接</button>
        <button id="disconnectBtn" class="disconnect" disabled>断开连接</button>
        <button id="checkStatusBtn" class="secondary">检查连接状态</button>
        
        <div id="connectionStatus" class="status disconnected">状态：未连接</div>
    </div>
    
    <div class="panel">
        <h2>发送消息</h2>
        <div class="tab-buttons">
            <div class="tab-button active" data-tab="direct-message">点对点消息</div>
            <div class="tab-button" data-tab="test-message">测试消息</div>
            <div class="tab-button" data-tab="broadcast">广播消息</div>
        </div>
        
        <div class="tab-content active" id="direct-message">
            <div class="form-group">
                <label for="fromUserId">发送方用户ID：</label>
                <input type="number" id="fromUserId" value="2" min="1">
            </div>
            <div class="form-group">
                <label for="toUserId">接收方用户ID：</label>
                <input type="number" id="toUserId" value="1" min="1">
            </div>
            <div class="form-group">
                <label for="messageContent">消息内容：</label>
                <textarea id="messageContent" rows="3" placeholder="请输入消息内容..."></textarea>
            </div>
            <button id="sendBtn" disabled>发送消息</button>
        </div>
        
        <div class="tab-content" id="test-message">
            <div class="form-group">
                <label for="testUserId">目标用户ID：</label>
                <input type="number" id="testUserId" value="1" min="1">
            </div>
            <button id="sendTestBtn" disabled>发送测试消息</button>
            <p>将发送一条带有时间戳的测试消息给指定用户</p>
        </div>
        
        <div class="tab-content" id="broadcast">
            <div class="form-group">
                <label for="broadcastContent">广播内容：</label>
                <textarea id="broadcastContent" rows="3" placeholder="请输入广播内容..."></textarea>
            </div>
            <button id="broadcastBtn">发送广播</button>
            <p>将向所有连接的用户发送同一条消息</p>
        </div>
    </div>
    
    <div class="panel">
        <h2>消息记录</h2>
        <button id="clearMessagesBtn" class="clear-btn">清空记录</button>
        <div class="messages" id="messagesContainer"></div>
    </div>
</div>

<!-- 在JSP中使用EL表达式设置contextPath变量 -->
<script>
    // 使用JSP的EL表达式设置上下文路径变量
    const contextPath = '${pageContext.request.contextPath}';
    
    // DOM 元素
    const connectBtn = document.getElementById('connectBtn');
    const disconnectBtn = document.getElementById('disconnectBtn');
    const checkStatusBtn = document.getElementById('checkStatusBtn');
    const sendBtn = document.getElementById('sendBtn');
    const sendTestBtn = document.getElementById('sendTestBtn');
    const broadcastBtn = document.getElementById('broadcastBtn');
    const clearMessagesBtn = document.getElementById('clearMessagesBtn');
    const connectionStatus = document.getElementById('connectionStatus');
    const messagesContainer = document.getElementById('messagesContainer');
    
    // 全局变量
    let eventSource = null;
    let currentUserId = null;
    
    // 标签页切换
    document.querySelectorAll('.tab-button').forEach(button => {
        button.addEventListener('click', () => {
            // 移除所有活动标签
            document.querySelectorAll('.tab-button').forEach(btn => {
                btn.classList.remove('active');
            });
            document.querySelectorAll('.tab-content').forEach(content => {
                content.classList.remove('active');
            });
            
            // 激活当前标签
            button.classList.add('active');
            const tabId = button.getAttribute('data-tab');
            document.getElementById(tabId).classList.add('active');
        });
    });
    
    // 添加消息到消息容器
    function addMessage(text, type = 'system') {
        const message = document.createElement('div');
        message.className = `message ${type}`;
        
        const content = document.createElement('div');
        content.textContent = text;
        message.appendChild(content);
        
        const timestamp = document.createElement('div');
        timestamp.className = 'timestamp';
        timestamp.textContent = new Date().toLocaleString();
        message.appendChild(timestamp);
        
        messagesContainer.appendChild(message);
        messagesContainer.scrollTop = messagesContainer.scrollHeight;
    }
    
    // 更新连接状态
    function updateConnectionStatus(connected, message) {
        connectionStatus.textContent = message;
        connectionStatus.className = connected ? 'status connected' : 'status disconnected';
        
        // 更新按钮状态
        connectBtn.disabled = connected;
        disconnectBtn.disabled = !connected;
        sendBtn.disabled = !connected;
        sendTestBtn.disabled = !connected;
    }
    
    // 建立SSE连接
    connectBtn.addEventListener('click', () => {
        const userId = document.getElementById('userId').value;
        if (!userId) {
            alert('请输入用户ID');
            return;
        }
        
        currentUserId = userId;
        document.getElementById('toUserId').value = userId;
        
        // 关闭已有连接
        if (eventSource) {
            eventSource.close();
        }
        
        // 建立新连接
        try {
            addMessage(`尝试为用户 ${userId} 建立SSE连接...`);
            eventSource = new EventSource(contextPath + '/sse-full-test/connect?userId=' + userId);
            
            // 连接建立事件
            eventSource.onopen = function() {
                updateConnectionStatus(true, `状态：已连接（用户ID: ${userId}）`);
                addMessage(`用户 ${userId} 已成功建立SSE连接`);
            };
            
            // 接收消息事件
            eventSource.onmessage = function(event) {
                console.log('收到SSE消息:', event.data);
                addMessage(`${event.data}`, 'received');
            };
            
            // 错误处理
            eventSource.onerror = function(event) {
                console.error('SSE连接错误:', event);
                eventSource.close();
                eventSource = null;
                updateConnectionStatus(false, '状态：连接错误');
                addMessage('SSE连接发生错误，已断开', 'system');
            };
        } catch (error) {
            console.error('创建EventSource时出错:', error);
            addMessage(`连接失败: ${error.message}`, 'system');
            alert('连接失败: ' + error.message);
        }
    });
    
    // 断开连接
    disconnectBtn.addEventListener('click', () => {
        if (eventSource) {
            const userId = currentUserId;
            if (!userId) {
                addMessage('无法确定当前用户ID', 'system');
                return;
            }
            
            addMessage('尝试断开SSE连接...', 'system');
            
            // 先关闭客户端的EventSource
            eventSource.close();
            eventSource = null;
            
            // 更新UI状态为正在断开
            updateConnectionStatus(false, '状态：正在断开连接...');
            
            // 向服务器发送一个更可靠的断开信号
            const disconnectUrl = contextPath + '/sse-full-test/check?userId=' + userId + '&action=disconnect';
            
            fetch(disconnectUrl, {
                method: 'GET',  // 明确使用GET避免问题
                headers: {
                    'Cache-Control': 'no-cache'
                },
                credentials: 'same-origin'
            })
            .then(response => response.json())
            .then(data => {
                console.log('断开连接结果:', data);
                // 完成断开连接过程
                currentUserId = null;
                updateConnectionStatus(false, '状态：已断开连接');
                addMessage('已成功断开SSE连接', 'system');
            })
            .catch(error => {
                // 即使请求失败，也保持断开连接的状态
                console.error('断开连接请求出错:', error);
                currentUserId = null;
                updateConnectionStatus(false, '状态：已断开连接（但通知服务器失败）');
                addMessage('断开连接时发生错误: ' + error.message, 'system');
            });
        } else {
            updateConnectionStatus(false, '状态：未连接');
            addMessage('没有活动的SSE连接', 'system');
        }
    });
    
    // 检查连接状态
    checkStatusBtn.addEventListener('click', () => {
        const userId = document.getElementById('userId').value;
        if (!userId) {
            alert('请输入用户ID');
            return;
        }
        
        fetch(contextPath + '/sse-full-test/check?userId=' + userId)
            .then(response => response.json())
            .then(data => {
                addMessage(`用户 ${userId} 的连接状态: ${data.message}`, 'system');
                
                if (data.connected && !eventSource) {
                    addMessage('警告：服务器显示用户已连接，但本地连接已断开。可能存在连接状态不一致。', 'system');
                }
            })
            .catch(error => {
                console.error('检查连接状态时出错:', error);
                addMessage(`检查连接状态失败: ${error.message}`, 'system');
            });
    });
    
    // 发送点对点消息
    sendBtn.addEventListener('click', () => {
        const fromUserId = document.getElementById('fromUserId').value;
        const toUserId = document.getElementById('toUserId').value;
        const content = document.getElementById('messageContent').value;
        
        if (!fromUserId || !toUserId || !content) {
            alert('请填写完整的消息信息');
            return;
        }
        
        const formData = new FormData();
        formData.append('fromUserId', fromUserId);
        formData.append('toUserId', toUserId);
        formData.append('content', content);
        
        fetch(contextPath + '/sse-full-test/send', {
            method: 'POST',
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                console.log('发送结果:', data);
                addMessage(`发送消息（从用户${fromUserId}到用户${toUserId}）: ${content}`, 'sent');
                
                if (data.status === 'error') {
                    addMessage(`发送失败: ${data.message}`, 'system');
                }
                
                // 清空消息输入框
                document.getElementById('messageContent').value = '';
            })
            .catch(error => {
                console.error('发送消息时出错:', error);
                addMessage(`发送失败: ${error.message}`, 'system');
            });
    });
    
    // 发送测试消息
    sendTestBtn.addEventListener('click', () => {
        const userId = document.getElementById('testUserId').value;
        
        if (!userId) {
            alert('请输入目标用户ID');
            return;
        }
        
        fetch(contextPath + '/sse-full-test/send-test?userId=' + userId)
            .then(response => response.json())
            .then(data => {
                console.log('测试消息结果:', data);
                
                if (data.status === 'success') {
                    addMessage(`发送测试消息到用户${userId}: ${data.content}`, 'sent');
                } else {
                    addMessage(`发送测试消息失败: ${data.message}`, 'system');
                }
            })
            .catch(error => {
                console.error('发送测试消息时出错:', error);
                addMessage(`发送测试消息失败: ${error.message}`, 'system');
            });
    });
    
    // 发送广播消息
    broadcastBtn.addEventListener('click', () => {
        const content = document.getElementById('broadcastContent').value;
        
        if (!content) {
            alert('请输入广播内容');
            return;
        }
        
        fetch(contextPath + '/sse-full-test/broadcast?message=' + encodeURIComponent(content))
            .then(response => response.json())
            .then(data => {
                console.log('广播结果:', data);
                addMessage(`广播消息: ${content}`, 'sent');
                
                if (data.status === 'error') {
                    addMessage(`广播失败: ${data.message}`, 'system');
                }
                
                // 清空广播输入框
                document.getElementById('broadcastContent').value = '';
            })
            .catch(error => {
                console.error('发送广播时出错:', error);
                addMessage(`广播失败: ${error.message}`, 'system');
            });
    });
    
    // 清空消息记录
    clearMessagesBtn.addEventListener('click', () => {
        messagesContainer.innerHTML = '';
        addMessage('消息记录已清空', 'system');
    });
    
    // 页面加载后自动填充当前userId到其他输入框
    document.addEventListener('DOMContentLoaded', () => {
        document.getElementById('toUserId').value = document.getElementById('userId').value;
        document.getElementById('testUserId').value = document.getElementById('userId').value;
        
        addMessage('SSE全流程测试页面已加载', 'system');
        addMessage('请点击"建立SSE连接"按钮开始测试', 'system');
    });
    
    // 页面关闭前关闭SSE连接
    window.addEventListener('beforeunload', () => {
        if (eventSource) {
            eventSource.close();
        }
    });
</script>
</body>
</html> 