<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 2024/11/8
  Time: 11:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SSE Example</title>
</head>
<body>
<h1>Receiving Server-Sent Events</h1>
<div id="messages"></div>
<script>
    var eventSource = new EventSource('${contextPath}/sse');
    var eventSource2 = new EventSource('${contextPath}/sentmessage');
    eventSource.onmessage = function(event) {
        var messages = document.getElementById('messages');
        var message = document.createElement('div');
        console.log(event.data)
        message.textContent = 'Message from server: ' + event.data;
        messages.appendChild(message);
    };
    eventSource.onerror = function(event) {
        console.error('EventSource failed:', event);
        eventSource.close();
    };
</script>

</body>
</html>
