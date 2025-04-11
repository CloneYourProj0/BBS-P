	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<html>
	<head>
		<meta charset="utf-8">
		<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/layui/css/layui.css">
		<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/global.css">
		<script src="${pageContext.servletContext.contextPath}/assets/layui-2.8.0/src/layui.js"></script>
		<script src="${pageContext.servletContext.contextPath}/js/jquery-3.2.1.js"></script>
	</head>
	<body>
	<div class="header">
		<div class="main" style="position: relative;">
			<a class="title" href="${contextPath}/index" target="_parent" title="码氏家族" style="position: absolute; top: 10%;">
				<i class="iconfont icon-jiaoliu layui-hide-xs" style="font-size: 22px;"></i>
				码氏家族问答社区</a>
			<div class="nav">
				<a class="nav-this" href="index.html">
					<i class="iconfont icon-wenda"></i>你问我答</a>
			</div>
			<div class="nav-user">
				<!--
				<a class="avatar" href="">
					<img src="res/images/avatar/11.jpg">
					<cite>贤心</cite>
				</a>
				<div class="nav">
					<a href=""><i class="iconfont icon-tuichu" style="top: 0; font-size: 22px;"></i>退出</a>
				</div>
				 -->



				<a   class="iconfont icon-touxiang layui-hide-xs" style="margin-top: 4px; display: inline-block;">
				</a>
				<div class="nav"  style="font-size:14px;color: white;margin-top: -5px;margin-left: 1px; "  />
				<c:if test="${user == null}">
					<a href="${pageContext.servletContext.contextPath}/user/loginPage"  target="_parent" >登录</a>
					<a href="${pageContext.servletContext.contextPath}/user/registerPage" target="_parent" >注册</a>
				</c:if>
				<c:if test="${user != null}">
					<div class="layui-nav-item">
						<a href="javascript:;">${user.loginname} <span class="layui-nav-more"></span></a>
						<dl class="layui-nav-child"> <!-- 开始下拉菜单内容 -->
							<dd><a href="${pageContext.servletContext.contextPath}/profile?id=${user.id}">个人主页</a></dd>
							<dd><a href="${pageContext.servletContext.contextPath}/admin/dashboard">数据管理</a></dd>
							<dd><a href="${pageContext.servletContext.contextPath}/AiService/botlist">bot列表</a></dd>
							<dd><a href="${pageContext.servletContext.contextPath}/message/?userId=${user.id}&pageNum=1&pageSize=3">消息列表</a></dd>
<%--							<dd><a href="${pageContext.servletContext.contextPath}/user/logout">退出</a></dd>--%>
							<dd><a href="javascript:void(0);" onclick="handleLogout()">退出</a></dd>

						</dl>
					</div>
				</c:if>
			</div>
		</div>
	</div>
	</div>
	</body>
<%--	推荐热点内容--%>
	<script>
		// 推荐功能管理器
		const RecommendationManager = {
			loadRecommendations: function() {
				<c:if test="${user != null}">
				// 获取当前用户ID
				const userId = ${user.id};

				// 发送请求获取推荐
				$.ajax({
					url: '${pageContext.servletContext.contextPath}/recomment',
					type: 'GET',
					data: { userId: userId },
					success: function(response) {
						// 处理成功响应
						if (response && response.length > 0) {
							// 将推荐内容保存到会话存储中
							sessionStorage.setItem('userRecommendations', JSON.stringify(response));

							// 处理推荐内容的展示
							RecommendationManager.displayRecommendations(response);
						}
					},
					error: function(xhr, status, error) {
						console.error('获取推荐失败:', error);
						layui.use(['layer'], function(){
							var layer = layui.layer;
							layer.msg('获取推荐内容失败，请稍后重试', {
								offset: 't',
								icon: 2
							});
						});
					}
				});
				</c:if>
			},

			displayRecommendations: function(recommendations) {
				// 使用 layui 来展示推荐内容
				layui.use(['element', 'layer'], function(){
					var element = layui.element;
					var layer = layui.layer;

					// 构建推荐内容的HTML
					let recommendHtml = '<div class="layui-card">';
					recommendHtml += '<div class="layui-card-header">为您推荐的问题</div>';
					recommendHtml += '<div class="layui-card-body">';

					recommendations.forEach(function(rec) {
						for (let [question, score] of Object.entries(rec)) {
							recommendHtml += `
                                <div class="layui-card-item">
                                    <p>${question}</p>
                                    <div class="layui-progress">
                                        <div class="layui-progress-bar" lay-percent="${score}%"></div>
                                    </div>
                                </div>
                            `;
						}
					});

					recommendHtml += '</div></div>';

					// 更新推荐容器的内容并显示
					$('#recommendationsContainer').html(recommendHtml).show();
					console.log(recommendations)
					// 重新渲染进度条
					element.render('progress');
				});
			}
		};

		// 页面加载完成后执行
		$(document).ready(function() {
			// 如果用户已登录，加载推荐
			<c:if test="${user != null}">
			RecommendationManager.loadRecommendations();
			</c:if>
		});
	</script>

	<!-- 添加SSE管理脚本 -->
	<script>
		(function() {
			let eventSource = null;
			let retryCount = 0;
			const maxRetries = 5;

			function connectSSE() {
				if (eventSource) {
					eventSource.close();
				}

				try {
					eventSource = new EventSource('${pageContext.servletContext.contextPath}/message/connect');

					eventSource.onopen = function(event) {
						console.log('SSE连接已建立');
						retryCount = 0;
					};

					eventSource.onmessage = function(event) {
						console.log('收到消息:', event.data);
						layui.use(['layer'], function(){
							var layer = layui.layer;
							layer.msg(event.data, {
								offset: 't',
								anim: 6
							});
						});
					};

					eventSource.onerror = function(event) {
						console.error('SSE连接错误:', event);
						if (eventSource.readyState === EventSource.CLOSED) {
							eventSource.close();
							eventSource = null;

							if (retryCount < maxRetries) {
								retryCount++;
								const retryDelay = Math.min(1000 * Math.pow(2, retryCount), 10000);
								console.log(`将在 ${retryDelay}ms 后进行第 ${retryCount} 次重试`);
								setTimeout(connectSSE, retryDelay);
							} else {
								console.log('达到最大重试次数，停止重试');
							}
						}
					};
				} catch (error) {
					console.error('创建SSE连接失败:', error);
				}
			}

			// 在页面加载完成后，如果用户已登录则建立SSE连接
			$(document).ready(function() {
				<c:if test="${user != null}">
				connectSSE();
				</c:if>
			});

			// 页面刷新时关闭SSE连接
			window.onbeforeunload = function() {
				if (eventSource) {
					eventSource.close();
					eventSource = null;
					console.log('SSE连接已关闭!!!!!!!!!!!!!!!!!!!!!!!!!!!');
					sessionStorage.removeItem('sseConnected');
				}
			};

			// 暴露给全局的方法，以便其他页面可以调用
			window.SSEManager = {
				connect: connectSSE,
				disconnect: function() {
					if (eventSource) {
						eventSource.close();
						eventSource = null;
					}
				}
			};
		})();
	</script>
	<script>
		// 退出处理逻辑
		function handleLogout() {
			// 先断开SSE连接
			if (window.SSEManager) {
				window.SSEManager.disconnect();
			}
			// 然后跳转到登出URL
			window.location.href = "${pageContext.servletContext.contextPath}/user/logout";
		}
	</script>
	<script>
		layui.use(['element', 'jquery'], function(){
			var element = layui.element;
			var $ = layui.jquery;

			// 点击用户名显示下拉菜单
			$('.layui-nav-item > a').on('click', function(e) {
				// 只有点击用户名（即包含下拉菜单的a标签）时阻止默认行为
				e.preventDefault();
				$(this).siblings('.layui-nav-child').toggle(); // 切换下拉菜单
			});

			// 允许下拉菜单中的链接正常工作
			$('.layui-nav-child a').on('click', function(e) {
				e.stopPropagation(); // 阻止事件冒泡到父元素
			});
		});
	</script>
	</html>