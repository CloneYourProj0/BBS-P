<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="utf-8">
	<title>问题详情</title>
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="keywords" content="fly,layui,前端社区">
	<meta name="description" content="">
	<link rel="stylesheet" href="${contextPath}/assets/layui-2.8.0/src/css/layui.css">
	<link rel="stylesheet" href="${contextPath}/css/global.css">
	<script src="${contextPath}/assets/layui-2.8.0/src/layui.js"></script>
	<script src="${contextPath}/js/jquery-3.2.1.js"></script>
		<style type="text/css" rel="stylesheet">
		form {
			margin: 0;
		}
		.editor {
			margin-top: 5px;
			margin-bottom: 5px;
		}

		/*by-Claude-opus-关于回答列表的css配置*/
		.jieda-reply-right {
			text-align: right;
		}
		@keyframes highlightAnswer {
			0% { background-color: transparent; }
			20% { background-color: rgba(0, 150, 136, 0.1); }
			80% { background-color: rgba(0, 150, 136, 0.1); }
			100% { background-color: transparent; }
		}
		.highlight {
			animation: highlightAnswer 2s ease-out;
		}
		.detail-jump {
			display: inline-flex;
			align-items: center;
			margin-left: 10px;
			color: #999;
			font-size: 13px;
			transition: color 0.2s;
		}
		.detail-jump:hover {
			color: #009688;
			text-decoration: none;
		}
		.detail-jump .iconfont {
			margin-right: 3px;
			font-size: 14px;
		}
		.detail-jump span {
			vertical-align: middle;
		}
		/*为点赞后的图片改色*/
		.jieda-zan.liked i.icon-zan {
			color: #ff5722;
		}

		.modal {
			display: none;
			position: fixed;
			z-index: 1;
			left: 0;
			top: 0;
			width: 100%;
			height: 100%;
			overflow: auto;
			background-color: rgb(0,0,0);
			background-color: rgba(0,0,0,0.4);
		}

		.modal-content {
			background-color: #fefefe;
			margin: 15% auto;
			padding: 20px;
			border: 1px solid #888;
			width: 80%;
		}

	</style>

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
			/*#getaibotx {*/
			/*	width: 100%;*/
			/*	height: 100px;*/
			/*	padding: 10px;*/
			/*	border: 1px solid #dcdcdc;*/
			/*	border-radius: 4px;*/
			/*	margin-top: 20px;*/
			/*}*/

			 .layui-form-label {
				 background-color: #009688;
			 }

		</style>
	</head>
	<body>
		<%--公共头部开始--%>
		<jsp:include page="/WEB-INF/jsp/common/head.jsp"></jsp:include>
		<%--公共头部结束--%>
		<div class="main layui-clear">
			<div class="wrap">
				<div class="content detail">
					<div class="fly-panel detail-box">
						<h1>${question.title}</h1>
						<div class="fly-tip fly-detail-hint" data-id="">
							<c:if test="${status!=0}">
								rytafsdjahsdj
								<span class="fly-tip-stick">${status}</span>
							</c:if>
							<span class="jie-admin">
							<a href="">点击置顶</a>
						</span>
							<span
								class="layui-btn layui-btn-mini jie-admin">
								<a href="${contextPath}/ques/top?id=${question.id}&status=0">取消置顶</a>
							</span>
							<span class="jie-admin" type="del" style="margin-left: 20px;">
								<a>删除该帖</a> </span>
							</span>
							<div class="fly-list-hint">
								<i class="iconfont" title="回答">&#xe60c;</i> 2
							</div>
						</div>
						<div class="detail-about">
							<a class="jie-user" href=""> <img src="${contextPath}/img/uer.jpg" alt="头像"> <cite> 压缩
									<em><fmt:formatDate value="${question.createtime}" pattern="yyyy-MM-dd" />发布</em> </cite> </a>
							<div class="detail-hits" data-id="{{rows.id}}">
								<span class="layui-btn layui-btn-mini jie-admin">
									<a href="#">已完帖，无法编辑</a>
								</span>
								<span class="layui-btn layui-btn-mini jie-admin" type="collect" data-type="add">
									<a id="collectPost">收藏</a>
								</span>
								<span class="layui-btn layui-btn-mini jie-admin  layui-btn-danger" type="collect" data-type="add">
									<a>取消收藏</a>
								</span>
							</div>
						</div>
						<div class="detail-body photos" style="margin-bottom: 20px;">
							<p>${question.description}</p>
						</div>
					</div>

					<div class="fly-panel detail-box" style="padding-top: 0;">
						<a name="comment"></a>

						<!-- 显示错误消息 -->
						<c:if test="${not empty aiError}">
							<script>
								console.log("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh哈哈哈")
								layui.use(['layer'], function(){
									var layer = layui.layer;
									layer.msg('${aiError}', {icon: 2});
								});
							</script>
						</c:if>

<%--						by-claude-opus，源代码是下面被注释的内容--%>
						<ul class="jieda photos" id="jieda">
							<c:choose>
								<c:when test="${answerList != null}">
									<c:forEach items="${answerList}" var="answer" varStatus="status">
										<li id="answer-${answer.id}" data-id="${answer.id}" class="jieda-daan">
											<div class="detail-about detail-about-reply">
												<a class="jie-user" href="javascript:;">
													<img src="${contextPath}/img/uer.jpg" alt="">
													<cite><i>${answer.loginname}</i></cite>
												</a>
												<div class="detail-hits">
													<span>${answer.createtime}</span>
													<!-- 修改链接格式 -->
													<c:if test="${answer.toanswerid != null && answer.toanswerid !=0}">
														<a href="${contextPath}/ques/detail?id=${answer.question_id}#answer-${answer.toanswerid}"
														   class="detail-jump"
														   onclick="return scrollToAnswer(${answer.toanswerid})">
															<i class="iconfont icon-reply"></i>
															<span>回复于#${answer.toanswerid}</span>
														</a>
													</c:if>
												</div>
												<c:if test='${answer.is_accept eq "1"}'>
													<i class="iconfont icon-caina" title="最佳答案"></i>
												</c:if>
											</div>
											<div class="detail-body jieda-body">
												<p>${answer.content}</p>
											</div>
											<div class="jieda-reply">
												<div class="jieda-reply-right">
													<span class="jieda-zan" type="zan">
													 <i class="iconfont icon-zan"></i>
													 <em>${answer.likes}</em>
													</span>
													<span class="jieda-reply-btn" data-user="${answer.loginname}" data-id="${answer.id}">
													<i class="iconfont icon-svgmoban53"></i>
													回复
												 	</span>
												</div>
											</div>
										</li>
									</c:forEach>
								</c:when>
								<c:when test="${answerList == null}">
									<li class="fly-none">没有任何回答</li>
								</c:when>
							</c:choose>
						</ul>



<%--						<ul class="jieda photos" id="jieda">--%>
<%--							<c:choose>--%>
<%--								<c:when test="${answerList != null}">--%>
<%--									<c:forEach items="${answerList}" var="answer">--%>
<%--										<li data-id="12" class="jieda-daan">--%>
<%--											<div class="detail-about detail-about-reply">--%>
<%--												<a class="jie-user" href="javascript:;">--%>
<%--													<img src="${contextPath}/img/uer.jpg" alt="">--%>
<%--													<cite> <i>${answer.loginname}</i></cite>--%>
<%--												</a>--%>
<%--												<div class="detail-hits">--%>
<%--													<span>3分钟前</span>--%>
<%--												</div>--%>
<%--												<i class="iconfont icon-caina" title="最佳答案"></i>--%>
<%--											</div>--%>
<%--											<div class="detail-body jieda-body">--%>
<%--												<p>${answer.content}</p>--%>
<%--											</div>--%>
<%--											<div class="jieda-reply">--%>
<%--												<span class="jieda-zan zanok" type="zan"><i--%>
<%--													class="iconfont icon-zan"></i><em>12</em>--%>
<%--												</span>--%>
<%--											</div>--%>
<%--										</li>--%>
<%--									</c:forEach>--%>
<%--								</c:when>--%>
<%--								<c:when test="${answerList == null}">--%>
<%--									<li class="fly-none">没有任何回答</li>--%>
<%--								</c:when>--%>
<%--							</c:choose>--%>


<%--							&lt;%&ndash;<li data-id="13"><a name="item-121212121212"></a>--%>
<%--								<div class="detail-about detail-about-reply">--%>
<%--									<a class="jie-user" href=""> <img--%>
<%--										src="res/images/uer.jpg" alt=""> <cite> <i>香菇</i>--%>
<%--											<em style="color:#FF9E3F">活雷锋</em> </cite> </a>--%>
<%--									<div class="detail-hits">--%>
<%--										<span>刚刚</span>--%>
<%--									</div>--%>
<%--								</div>--%>
<%--								<div class="detail-body jieda-body">--%>
<%--									<p>蓝瘦</p>--%>
<%--								</div>--%>
<%--								<div class="jieda-reply">--%>
<%--									<span class="jieda-zan" type="zan"><i--%>
<%--										class="iconfont icon-zan"></i><em>0</em>--%>
<%--									</span>--%>
<%--									<div class="jieda-admin">--%>
<%--										<span type="del"><a href="#" class="layui-btn layui-btn-danger layui-btn-small">删除</a></span>--%>
<%--										<span class="jieda-accept" type="accept">--%>
<%--										<a href="#" class="layui-btn  layui-btn-small">采纳</a></span>--%>
<%--									</div>--%>
<%--								</div></li>&ndash;%&gt;--%>

<%--							<!-- <li class="fly-none">没有任何回答</li> -->--%>
<%--						</ul>--%>

						<span id="toName">@ 压缩(楼主)</span>
						<hr>
						<div class="layui-form layui-form-pane">
							<form action="${contextPath}/ans/save" method="post">
								<div class="layui-form-item">
									<label class="layui-form-label" bgcolor="#009688">启用AI回复</label>
									<div class="layui-input-block">
										<%--                <input type="checkbox" id="aiResponseCheckbox" name="aiResponseRequested"  lay-skin="primary" >--%>
										<input id="getaibotx" type="text" name="aiResponseContent"  lay-verify="required" placeholder="请输入AI回复内容" autocomplete="off" class="layui-input">
									</div>
									<%--                     <textarea id="getaibot" placeholder="输入 @ 来提及用户..."></textarea>--%>
								</div>
								<input type="hidden" name="questionId" value="${question.id}">
								<div class="layui-form-item layui-form-text">
									<div class="layui-input-block">
										<textarea id="L_content" name="content" placeholder="我要回答" class="layui-textarea fly-editor" style="height: 150px;"></textarea>
									</div>
								</div>
								<div class="layui-form-item">
									<button class="layui-btn" lay-filter="*" lay-submit>提交回答</button>
								</div>
							</form>
						</div>

					</div>
				</div>
			</div>

			<div class="edge">
				<dl class="fly-panel fly-list-one">
					<dt class="fly-panel-title">最近热帖</dt>
					<dd>
						<a href="">使用 layui 秒搭后台大布局（基本结构）</a> <span><i
							class="iconfont">&#xe60b;</i> 6087</span>
					</dd>
					<dd>
						<a href="">Java实现LayIM后端的核心代码</a> <span><i class="iconfont">&#xe60b;</i>
							767</span>
					</dd>
					<dd>
						<a href="">使用 layui 秒搭后台大布局（基本结构）</a> <span><i
							class="iconfont">&#xe60b;</i> 6087</span>
					</dd>
					<dd>
						<a href="">Java实现LayIM后端的核心代码</a> <span><i class="iconfont">&#xe60b;</i>
							767</span>
					</dd>
					<dd>
						<a href="">使用 layui 秒搭后台大布局（基本结构）</a> <span><i
							class="iconfont">&#xe60b;</i> 6087</span>
					</dd>
					<dd>
						<a href="">Java实现LayIM后端的核心代码</a> <span><i class="iconfont">&#xe60b;</i>
							767</span>
					</dd>
					<dd>
						<a href="">使用 layui 秒搭后台大布局（基本结构）</a> <span><i
							class="iconfont">&#xe60b;</i> 6087</span>
					</dd>
					<dd>
						<a href="">Java实现LayIM后端的核心代码</a> <span><i class="iconfont">&#xe60b;</i>
							767</span>
					</dd>
				</dl>

				<dl class="fly-panel fly-list-one">
					<dt class="fly-panel-title">近期热议</dt>
					<dd>
						<a href="">使用 layui 秒搭后台大布局之基本结构</a> <span><i
							class="iconfont">&#xe60c;</i> 96</span>
					</dd>
					<dd>
						<a href="">使用 layui 秒搭后台大布局之基本结构</a> <span><i
							class="iconfont">&#xe60c;</i> 96</span>
					</dd>
					<dd>
						<a href="">使用 layui 秒搭后台大布局之基本结构</a> <span><i
							class="iconfont">&#xe60c;</i> 96</span>
					</dd>
					<dd>
						<a href="">使用 layui 秒搭后台大布局之基本结构</a> <span><i
							class="iconfont">&#xe60c;</i> 96</span>
					</dd>
					<dd>
						<a href="">使用 layui 秒搭后台大布局之基本结构</a> <span><i
							class="iconfont">&#xe60c;</i> 96</span>
					</dd>
					<dd>
						<a href="">使用 layui 秒搭后台大布局之基本结构</a> <span><i
							class="iconfont">&#xe60c;</i> 96</span>
					</dd>
					<dd>
						<a href="">使用 layui 秒搭后台大布局之基本结构</a> <span><i
							class="iconfont">&#xe60c;</i> 96</span>
					</dd>
					<dd>
						<a href="">使用 layui 秒搭后台大布局之基本结构</a> <span><i
							class="iconfont">&#xe60c;</i> 96</span>
					</dd>
				</dl>
			</div>


			<!-- 模态窗口 -->
			<div id="replyModal" class="modal" style="display: none;">
				<div class="modal-content">
					<span class="close">&times;</span>
					<br>
					<form action="${contextPath}/ans/save" method="post" id="replyForm">
						<div class="layui-form-item">
							<label class="layui-form-label" bgcolor="#009688">启用AI回复</label>
							<div class="layui-input-block">
								<%--                <input type="checkbox" id="aiResponseCheckbox" name="aiResponseRequested"  lay-skin="primary" >--%>
								<input id="getaibot" type="text" name="aiResponseContent" lay-verify="required" placeholder="请输入AI回复内容" autocomplete="off" class="layui-input">
							</div>
							<%--                     <textarea id="getaibot" placeholder="输入 @ 来提及用户..."></textarea>--%>
						</div>
						<input type="hidden" name="questionId" value="" id="modalQuestionId">
						<input type="hidden" name="toanswerid" value="" id="modalAnswerId">
						<div class="form-item">
							<textarea id="L_content2" name="content" placeholder="请输入回复内容" style="width: 100%; height: 150px;"></textarea>
						</div>
						<div class="form-item">
							<button class="layui-btn" lay-filter="*" lay-submit>提交回答</button>
						</div>
					</form>
				</div>
			</div>





		</div>
	    <script type="text/javascript" charset="utf-8" src="${contextPath}/js/kindeditor.js"></script>
	    <script type="text/javascript">
			KE.show({
				id : 'L_content',
				resizeMode : 1,
				items : [
				'fontname', 'fontsize', 'textcolor', 'bgcolor', 'bold', 'italic', 'underline',
				'removeformat', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
				'insertunorderedlist', 'emoticons', 'image', 'link']
			});
			KE.show({
				id : 'L_content2',
				resizeMode : 1,
				items : [
					'fontname', 'fontsize', 'textcolor', 'bgcolor', 'bold', 'italic', 'underline',
					'removeformat', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
					'insertunorderedlist', 'emoticons', 'image', 'link']
			});
		</script>
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
				tribute.attach(document.getElementById('getaibot'))
			});
		</script>

	<script>
		window.onload = function() {
			var hash = decodeURIComponent(window.location.hash.substring(1));
			var allParagraphs = document.querySelectorAll('.detail-body.jieda-body p');
			for (var i = 0; i < allParagraphs.length; i++) {
				if (allParagraphs[i].textContent.includes(hash)) {
					allParagraphs[i].scrollIntoView();
					break;
				}
			}
		};
	</script>

<%--		by-claude-opus-负责帖子下的回复列表的各种动态操作--%>
	<script>
		// 页面加载完成后检查 URL 是否包含 answer 定位
		document.addEventListener('DOMContentLoaded', function() {
			// 获取 URL hash
			const hash = window.location.hash;
			if (hash && hash.startsWith('#answer-')) {
				const answerId = hash.replace('#answer-', '');
				scrollToAnswer(answerId);
			}
		});

		function scrollToAnswer(answerId) {
			const targetElement = document.getElementById('answer-' + answerId);
			if (targetElement) {
				// 等待一小段时间再滚动，确保页面完全加载
				setTimeout(() => {
					targetElement.scrollIntoView({
						behavior: 'smooth',
						block: 'center'
					});

					// 添加高亮效果
					targetElement.classList.add('highlight');
					setTimeout(() => {
						targetElement.classList.remove('highlight');
					}, 2000);
				}, 100);
			}
			// 返回 false 阻止默认跳转
			return false;
		}
	</script>
<%--		by-claude-opus-对应点赞和评论回复功能--%>
	<script type="text/javascript">
		$(document).ready(function() {
			// 点赞功能
			$('.jieda-zan').click(function() {
				var answerId = $(this).closest('li[id^="answer-"]').data('id');
				var $this = $(this);
				var isLiked = $this.hasClass('liked');
				if (${not empty sessionScope.user}) {
				$.post('${contextPath}/ans/updatalike', {answerId: answerId, isLiked: isLiked}, function(data) {
					console.log(data)
					if (data==="101") {
						var likes = parseInt($this.find('em').text());
						if (isLiked) {
							likes--;
							$this.removeClass('liked');
						} else {
							likes++;
							$this.addClass('liked');
						}
						$this.find('em').text(likes);
					} else {
						alert("有一点小意外!");
					}
				});
				}else {
					alert("请先登录!");
				}
			});

			// 显示模态窗口的函数
			function showModal() {
				$('#replyModal').css('display', 'block');
			}

			// 隐藏模态窗口的函数
			function hideModal() {
				$('#replyModal').css('display', 'none');
			}

			// 点击关闭按钮时，隐藏模态窗口并销毁编辑器
			$('.close').click(function() {
				hideModal();
				if (replyEditor) {
					replyEditor.remove();
					replyEditor = null;
				}
			});

			// 点击回复按钮时，显示模态窗口并初始化编辑器
			$('.jieda-reply-btn').click(function() {
				var answerId = $(this).data('id');
				var questionId = '${question.id}'; // 确保服务器端变量正确输出

				$('#modalAnswerId').val(answerId);
				$('#modalQuestionId').val(questionId);

				showModal();

			});

			// 点击模态窗口外部，关闭模态窗口（可选）
			$(window).click(function(event) {
				if (event.target.id === 'replyModal') {
					hideModal();
					if (replyEditor) {
						replyEditor.remove();
						replyEditor = null;
					}
				}
			});
		});
	</script>
<%--		用于用户登录后看到自己点赞过的answer有高亮图标--%>
	<script>
		$(document).ready(function() {
			// ...existing code...

			// 获取当前用户点赞过的答案
			$.get('${contextPath}/ans/likedAnswers', function(data) {
				if (data.success) {
					var likedAnswerIds = data.likedAnswerIds;

					// 遍历所有答案,为点赞过的答案添加特殊的CSS类
					$('.jieda-zan').each(function() {
						var answerId = $(this).closest('li[id^="answer-"]').data('id');
						if (likedAnswerIds.includes(answerId)) {
							$(this).addClass('liked');
						}
					});
				} else {
					console.error('获取点赞数据失败:', data.message);
				}
			});
		});
	</script>
	</body>
</html>