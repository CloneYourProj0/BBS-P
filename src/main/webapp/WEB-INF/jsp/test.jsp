<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 2024/11/7
  Time: 20:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" charset="utf-8" src="${contextPath}/js/kindeditor.js"></script>

</head>
<style>
    .modal-backdrop {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0,0,0,0.5);
        z-index: 1040;
    }

    .modal {
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        z-index: 1050;
        background: white;
        padding: 20px;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    }

    .close {
        float: right;
        font-size: 28px;
        cursor: pointer;
    }
</style>
<body>
<!-- 遮罩 -->
<div id="modalBackdrop" class="modal-backdrop" style="display: none;"></div>

<!-- 弹窗内容 -->
<div id="replyModal" class="modal" style="display: none;">
    <div class="modal-content">
        <span class="close">&times;</span>
        <form action="${contextPath}/ans/save" method="post" id="replyForm">
            <input type="hidden" name="questionId" value="" id="modalQuestionId">
            <input type="hidden" name="toanswerid" value="" id="modalAnswerId">
            <div class="form-item">
                <textarea id="L_content" name="content" placeholder="请输入回复内容" style="width: 100%; height: 150px;"></textarea>
            </div>
            <div class="form-item">
                <button type="submit">提交回答</button>
            </div>
        </form>
    </div>
</div>
<button id="openModal" class="xxx">打开</button>
</body>
<script type="text/javascript">
    KE.show({
        id : 'L_content',
        resizeMode : 1,
        items : [
            'fontname', 'fontsize', 'textcolor', 'bgcolor', 'bold', 'italic', 'underline',
            'removeformat', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
            'insertunorderedlist', 'emoticons', 'image', 'link']
    });
</script>
<script>
    // 确保DOM完全加载后执行
    document.addEventListener('DOMContentLoaded', function() {
        var openButton = document.getElementById('openModal');
        var modal = document.getElementById('replyModal');
        var backdrop = document.getElementById('modalBackdrop');

        openButton.onclick = function() {
            modal.style.display = 'block';
            backdrop.style.display = 'block';
        };

        var closeButton = document.querySelector('.close');
        closeButton.onclick = function() {
            modal.style.display = 'none';
            backdrop.style.display = 'none';
        };
    });
</script>
</html>
