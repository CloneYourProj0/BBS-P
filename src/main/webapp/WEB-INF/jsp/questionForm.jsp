<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>发表问题</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="fly,layui,前端社区">
    <meta name="description" content="Fly社区是模块化前端UI框架Layui的官网社区，致力于为web开发提供强劲动力">

    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/global.css">
    <script src="${pageContext.servletContext.contextPath}/assets/layui/layui.js"></script>
    <script src="${pageContext.servletContext.contextPath}/js/jquery-3.2.1.js"></script>

      <style>
          .tribute-container {
              position: absolute;
              top: 0;
              left: 0;
              height: auto;
              max-height: 300px;
              overflow: auto;
              display: block;
              z-index: 999999;
              background: white;
              border: 1px solid #dcdcdc;
              border-radius: 4px;
              box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
          }

          .tribute-container ul {
              margin: 0;
              padding: 0;
              list-style: none;
          }

          .tribute-container li {
              padding: 8px 12px;
              cursor: pointer;
          }

          .tribute-container li.highlight {
              background: #f0f0f0;
          }

          /* 输入框样式 */
          #getaibot {
              width: 100%;
              height: 100px;
              padding: 10px;
              border: 1px solid #dcdcdc;
              border-radius: 4px;
              margin-top: 20px;
          }
          
          /* 图片上传预览样式 */
          .upload-img-box {
              margin-top: 10px;
              margin-bottom: 10px;
          }
          
          .upload-img-box img {
              max-width: 200px;
              max-height: 200px;
              margin-right: 10px;
              margin-bottom: 10px;
              border: 1px solid #ddd;
              padding: 2px;
          }
          
          .upload-img-preview {
              display: flex;
              flex-wrap: wrap;
          }
      </style>
  </head>
  <body>

    <%--公共头部开始--%>
    <jsp:include page="/WEB-INF/jsp/common/head.jsp"></jsp:include>
    <%--公共头部结束--%>

    <div class="main layui-clear">
      <div class="fly-panel" pad20>
        <h2 class="page-title">发表问题</h2>

        <!-- <div class="fly-none">并无权限</div> -->

          <div class="layui-form layui-form-pane">
          <form action="${pageContext.servletContext.contextPath}/ques/save" method="post">
            <div class="layui-form-item">
              <label for="L_title" class="layui-form-label">标题</label>
              <div class="layui-input-block">
                <input type="text" id="L_title" name="title" required lay-verify="required" autocomplete="off" class="layui-input">
              </div>
            </div>
            <div style="color: red;">
            <c:if test='${not empty error}'>
              <p>${error}</p>
            </c:if>
            </div>
              <div class="layui-form-item">
                  <label class="layui-form-label">是否启用AI</label>
                  <div class="layui-input-block">
                      <%--                <input type="checkbox" id="aiResponseCheckbox" name="aiResponseRequested"  lay-skin="primary" >--%>
                      <input id="getaibotx" type="text" name="aiResponseContent"  placeholder="请输入AI回复内容" autocomplete="off" class="layui-input">
                  </div>
                  <%--                     <textarea id="getaibot" placeholder="输入 @ 来提及用户..."></textarea>--%>
              </div>

            <div class="layui-form-item">
              <label class="layui-form-label">上传图片</label>
              <div class="layui-input-inline" style="width: auto;">
                <button type="button" class="layui-btn" id="uploadImage">
                  <i class="layui-icon layui-icon-upload"></i> 选择图片
                </button>
              </div>
              <div class="layui-form-mid layui-word-aux">支持图上传，可在编辑器中插入</div>
            </div>

            <div class="layui-form-item">
              <div class="layui-input-block" style="margin-left: 0;">
                <div class="layui-upload-list">
                  <div id="uploadImagePreview" class="upload-img-preview"></div>
                </div>
                <input type="hidden" name="uploadedImages" id="uploadedImages">
              </div>
            </div>

            <div class="layui-form-item layui-form-text">
              <div class="layui-input-block">
                 <div class="editor">
                    <textarea id="content" name="description" style="width:1040px;height:450px;visibility:hidden;"></textarea>
                 </div>
              </div>
              <label class="layui-form-label" style="top: -2px;">描述</label>
            </div>
            <div class="layui-form-item">
              <label for="L_title" class="layui-form-label">悬赏</label>
              <div class="layui-input-block">
                <input type="number"  name="coin" required lay-verify="required" autocomplete="off" class="layui-input">
              </div>
            </div>

            <div class="layui-form-item">
              <button class="layui-btn" lay-filter="*" lay-submit>立即发布</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <script src="${pageContext.servletContext.contextPath}/js/tribute.min.js"></script>
    <script src="${pageContext.servletContext.contextPath}/css/tribute.css"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var tribute = new Tribute({
                trigger: '@',
                values: function(text, cb) {
                    // 向后端发送请求获取数据
                    fetch('${pageContext.servletContext.contextPath}/AiService/getUserList?query=' + text+'&id=${user.id}')
                        .then(response => response.json())
                        .then(result => {
                            if (result.status === 'success') {
                                // 将后端返回的数据转换成 Tribute 需要的格式
                                const values = result.data.map(user => ({
                                    key: user.username,
                                    value: user.id
                                }));
                                cb(values);
                            } else {
                                cb([]);
                            }
                        })
                        .catch(error => {
                            console.error('Error fetching users:', error);
                            cb([]);
                        });
                },
                menuItemTemplate: function(item) {
                    return item.original.key;
                },
                selectTemplate: function (item) {
                    return '@' + item.original.key;
                },
                    noMatchTemplate: function() {
                        return '<span style="padding: 8px 12px; display: block;">没有找到匹配的用户</span>';
                    },
                    lookup: 'key',
                        fillAttr: 'value',
                        requireLeadingSpace: false,
                        allowSpaces: true,
                        menuShowMinLength: 0,
                        menuContainer: document.body,
                        positionMenu: true,
                        menuItemLimit: 5
            });

            tribute.attach(document.getElementById('getaibotx'));
        });
    </script>





     <script type="text/javascript" charset="utf-8" src="${pageContext.servletContext.contextPath}/js/kindeditor.js"></script>
      <script type="text/javascript">
        KE.show({
            id : 'content',
            resizeMode : 1,
            allowFileManager : true,  // 允许浏览服务器文件
            allowPreviewEmoticons : true, // 允许预览表情
            allowUpload : true,  // 允许上传文件
            syncType : 'auto',  // 自动同步数据
            //cssPath : './index.css',
            items : [
            'fontname', 'fontsize', 'textcolor', 'bgcolor', 'bold', 'italic', 'underline',
            'removeformat', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
            'insertunorderedlist', 'emoticons', 'image', 'link']
        });

        layui.use(['form'], function(){
          var form = layui.form;
          form.render(); // 更新全部
        });
      </script>
      
      <script>
        layui.use(['upload', 'layer'], function(){
          var upload = layui.upload;
          var layer = layui.layer;
          var $ = layui.jquery;
          
          // 存储上传的图片路径
          var uploadedImages = [];
          
          // 图片上传
          upload.render({
            elem: '#uploadImage',
            url: '${pageContext.servletContext.contextPath}/upload/image', // 图片上传接口，需要后端实现
            multiple: true, // 支持多图上传
            accept: 'images', // 只接受图片
            acceptMime: 'image/*', // 只接受图片类型
            before: function(obj){
              // 上传前的回调
              layer.load(); // 加载层
            },
            done: function(res){
              layer.closeAll('loading'); // 关闭加载层
              if(res.code == 0){ // 上传成功
                console.log(res);
                
                // 构建完整的图片URL（包含域名和端口）
                var baseUrl = window.location.protocol + '//' + window.location.host;
                var fullImageUrl = res.data.src;
                console.log(fullImageUrl);
                // 如果图片URL不是以http或https开头，添加baseUrl
                if(!fullImageUrl.startsWith('http://') && !fullImageUrl.startsWith('https://')) {
                  fullImageUrl = baseUrl + (fullImageUrl.startsWith('/') ? '' : '/') + fullImageUrl;
                }
                console.log(fullImageUrl);
                // 添加图片预览和复制路径功能
                $('#uploadImagePreview').append('<div class="upload-img-box">' +
                  '<img src="' + fullImageUrl + '" alt="' + (res.data.title || '上传图片') + '" class="layui-upload-img">' +
                  '<div class="layui-form-item" style="margin-top: 5px;">' +
                  '<div class="layui-input-inline" style="width: 200px;">' +
                  '<input type="text" class="layui-input image-url" value="' + fullImageUrl + '" readonly>' +
                  '</div>' +
                  '<button type="button" class="layui-btn layui-btn-xs layui-btn-normal copy-url">复制</button>' +
                  '<button type="button" class="layui-btn layui-btn-xs layui-btn-danger delete-img" data-index="' + uploadedImages.length + '">删除</button>' +
                  '</div>' +
                  '</div>');
                
                // 保存图片路径（这里也可以选择保存完整路径或相对路径，取决于您的需求）
                uploadedImages.push(fullImageUrl);
                $('#uploadedImages').val(JSON.stringify(uploadedImages));
                
                // 图片插入提示
                layer.msg('上传成功，请复制图片地址后插入编辑器');
              } else {
                layer.msg('上传失败：' + res.msg);
              }
            },
            error: function(){
              layer.closeAll('loading');
              layer.msg('上传出错，请检查网络');
            }
          });
          
          // 复制图片URL
          $(document).on('click', '.copy-url', function(){
            var $input = $(this).parent().find('.image-url');
            $input.select();
            try {
              var successful = document.execCommand('copy');
              if(successful) {
                // layer.msg('已复制图片地址，可在编辑器中使用 <img src="' + $input.val() + '"> 标签插入图片');
                // layer.msg('已复制图片地址，可在编辑器中使用 &lt;img src="' + $input.val() + '"&gt; 标签插入图片');
                layer.msg('已复制图片地址，可在编辑器中使用');
              } else {
                layer.msg('复制失败，请手动复制');
              }
            } catch (err) {
              layer.msg('复制失败: ' + err);
            }
          });
          
          // 删除上传的图片
          $(document).on('click', '.delete-img', function(){
            var index = $(this).data('index');
            uploadedImages.splice(index, 1);
            $('#uploadedImages').val(JSON.stringify(uploadedImages));
            $(this).closest('.upload-img-box').remove();
            
            // 重新计算索引
            $('.delete-img').each(function(i){
              $(this).data('index', i);
            });
            
            layer.msg('已删除');
          });
        });
      </script>
  </body>
</html>