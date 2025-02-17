<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 2024/11/13
  Time: 10:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>KindEditor with Tribute</title>
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/layui/css/layui.css">
<%--    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/tribute.css">--%>
    <script src="https://cdn.jsdelivr.net/npm/tributejs@5.1.3/dist/tribute.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/tributejs@5.1.3/dist/tribute.min.css" rel="stylesheet">
</head>
<body>

<div class="layui-form">
    <div class="layui-form-item layui-form-text">
        <div class="layui-input-block">
            <div class="editor">
                <textarea id="content" name="description" style="width:1040px;height:450px;visibility:hidden;"></textarea>
            </div>
        </div>
        <label class="layui-form-label" style="top: -2px;">描述</label>
    </div>
</div>

<script src="${pageContext.servletContext.contextPath}/assets/layui/layui.js"></script>
<script src="${pageContext.servletContext.contextPath}/js/kindeditor.js"></script>

<script>
    KE.show({
        id : 'content',
        resizeMode : 1,
        afterCreate: function(id) {
            // 创建下拉菜单元素
            const dropdownMenu = document.createElement('div');
            dropdownMenu.style.cssText = `
            position: fixed;
            display: none;
            background: white;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            z-index: 9999;
            min-width: 120px;
        `;
            document.body.appendChild(dropdownMenu);

            // 测试数据
            const users = [
                { name: '张三' },
                { name: '李四' },
                { name: '王五' },
                { name: '赵六' }
            ];

            // 获取iframe和其document
            const iframe = document.getElementsByClassName("ke-iframe")[0];
            const iframeDoc = iframe.contentDocument;

            // 存储最后的鼠标位置
            let lastMouseX = 0;
            let lastMouseY = 0;

            // 监听iframe内的鼠标移动
            iframeDoc.addEventListener('mousemove', function(e) {
                const iframeRect = iframe.getBoundingClientRect();
                lastMouseX = e.clientX + iframeRect.left;
                lastMouseY = e.clientY + iframeRect.top;
            });

            // 监听输入事件
            iframeDoc.body.addEventListener('input', function(e) {
                const selection = iframe.contentWindow.getSelection();
                const range = selection.getRangeAt(0);
                const text = range.startContainer.textContent;
                const position = range.startOffset;

                // 检查是否输入了@
                if (text.charAt(position - 1) === '@') {
                    // 使用鼠标位置设置下拉菜单
                    dropdownMenu.style.display = 'block';
                    dropdownMenu.style.top = `${lastMouseY + 20}px`; // 向下偏移一点，避免遮挡
                    dropdownMenu.style.left = `${lastMouseX}px`;

                    // 渲染用户列表
                    dropdownMenu.innerHTML = users.map(user => `
                    <div style="padding: 8px 12px; cursor: pointer; transition: background-color 0.2s;">
                        ${user.name}
                    </div>
                `).join('');

                    // 为每个选项添加点击事件
                    const items = dropdownMenu.getElementsByTagName('div');
                    Array.from(items).forEach(item => {
                        item.addEventListener('click', function() {
                            // 插入选中的用户名
                            const userName = this.textContent.trim();
                            const insertText = `@${userName} `;

                            // 删除@符号
                            range.setStart(range.startContainer, position - 1);
                            range.setEnd(range.startContainer, position);
                            range.deleteContents();

                            // 插入新文本
                            const textNode = iframeDoc.createTextNode(insertText);
                            range.insertNode(textNode);

                            // 移动光标到插入文本的末尾
                            range.setStartAfter(textNode);
                            range.setEndAfter(textNode);
                            selection.removeAllRanges();
                            selection.addRange(range);

                            // 隐藏下拉菜单
                            dropdownMenu.style.display = 'none';
                        });

                        // 添加鼠标悬停效果
                        item.addEventListener('mouseover', function() {
                            this.style.backgroundColor = '#f5f5f5';
                        });
                        item.addEventListener('mouseout', function() {
                            this.style.backgroundColor = 'white';
                        });
                    });
                }
            });

            // 点击其他地方时隐藏下拉菜单
            document.addEventListener('click', function(e) {
                if (!dropdownMenu.contains(e.target)) {
                    dropdownMenu.style.display = 'none';
                }
            });

            // 处理iframe滚动时隐藏菜单
            iframeDoc.addEventListener('scroll', function() {
                dropdownMenu.style.display = 'none';
            });

            // 监听window滚动
            window.addEventListener('scroll', function() {
                if (dropdownMenu.style.display === 'block') {
                    dropdownMenu.style.display = 'none';
                }
            });
        },
        items : [
            'fontname', 'fontsize', 'textcolor', 'bgcolor', 'bold', 'italic', 'underline',
            'removeformat', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
            'insertunorderedlist', 'emoticons', 'image', 'link'
        ]
    });
</script>


<%--<script type="text/javascript">--%>


<%--    KE.show({--%>
<%--        id : 'content',--%>
<%--        resizeMode : 1,--%>
<%--        afterCreate: function(id) {--%>
<%--            console.log("回调开始！")--%>
<%--            var iframe = document.getElementsByClassName("ke-iframe")[0];--%>
<%--            console.log(iframe)--%>
<%--            // 监听 <iframe> 的 load 事件--%>
<%--                // 获取 <iframe> 内部的 <body> 元素--%>
<%--                iframeBody = iframe.contentDocument.body;--%>
<%--                console.log("获取到body：")--%>
<%--                console.log(iframeBody)--%>
<%--                // 监听 <body> 元素的 input 事件--%>
<%--                iframeBody.addEventListener('input', function() {--%>
<%--                    console.log('Updated iframeBody innerHTML:', this.innerHTML);--%>
<%--                });--%>
<%--                console.log("tribute开始工作！！！")--%>
<%--                tribute.attach(iframeBody);--%>
<%--                console.log(iframeBody)--%>
<%--            },--%>
<%--        items : [--%>
<%--            'fontname', 'fontsize', 'textcolor', 'bgcolor', 'bold', 'italic', 'underline',--%>
<%--            'removeformat', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',--%>
<%--            'insertunorderedlist', 'emoticons', 'image', 'link'--%>
<%--        ]--%>
<%--    });--%>

<%--</script>--%>
<%--<script>--%>
<%--    setTimeout(() => {--%>
<%--        var tribute = new Tribute({--%>
<%--            values: [--%>
<%--                {key: 'Katniss Everdeen', value: 'Kat_Catching_Fire'},--%>
<%--                {key: 'Foxface', value: 'foxyweapons'}--%>
<%--            ]--%>
<%--        });--%>

<%--        var iframeBody;--%>
<%--        var iframe = document.getElementsByClassName("ke-iframe")[0];--%>
<%--        console.log(iframe);--%>

<%--        iframeBody = iframe.contentDocument.body;--%>
<%--        console.log("获取到body：");--%>
<%--        console.log(iframeBody);--%>

<%--        console.log("tribute开始工作！！！");--%>
<%--        tribute.attach(iframeBody);--%>
<%--    }, 1000);  // 1000毫秒 = 1秒--%>
<%--</script>--%>

</body>
</html>
