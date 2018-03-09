<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<html>
	<head>
		<meta charset="utf-8">
		<title>婚秀中国网</title>
		<link href="<%=basePath%>/static/css/global.css" rel="stylesheet" type="text/css" />
		<link href="<%=basePath%>/static/css/index.css" rel="stylesheet" type="text/css" />
		<link href="<%=basePath%>/static/css/laypage.css" rel="stylesheet" type="text/css" />
		<link href="<%=basePath%>/static/css/layui.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=basePath%>/static/js/laydate.js"></script>
		<script src="<%=basePath%>/static/layui/layui.js"></script>
		<script src="<%=basePath%>/static/layui/lay/modules/form.js"></script>
		<script src="<%=basePath%>/static/js/laypage.js"></script>
		<script type="text/javascript" src="<%=basePath%>/static/js/jquery1.42.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>/static/js/jquery.SuperSlide.2.1.1.js"></script>
		<style>
			.wid1200px {
				width: 1200px;
				background-color: #ffffff;
			}
			
			.layui-row {
				padding: 12px;
				border-top: 1px solid #efefef;
				width: 1100px;
				margin: 0px auto;
				box-shadow: 0px 2px 3px #eaeaea;
				font-size: 16px;
			}
			
		
			#top p {
				margin-bottom: 15px;
			}
			
			#top p font {
				font-size: 14px;
				color: #000;
				margin-right: 15px;
			}
			
			#top p span {
				font-size: 14px;
				color: #666;
				border: 1px solid #E1E1DF;
				display: inline-block;
				padding: 8px;
				cursor: pointer;
				margin: 0 20px 0 0;
				width: 180px;
				height: 40px;
				text-align: center;
			}
			
			#top p span.on {
				border: 2px solid #EC971F;
				padding: 7px;
				background: url(<%=basePath%>/static/images/on.png) no-repeat right bottom;
			}
			
			.layui-row i {
				color: #EC971F;
				font-weight: 600;
				list-style: none;
				font-style: normal;
				font-size: 18px;
			}
			
			.zaixian p {
				font-size: 16px;
				margin: 30px 10px;
			}
			
			.zaixian span {
				font-size: 22px;
				font-weight: bold;
				color: #EC971F;
			}
			
			.layui-tab-title .layui-this {
				color: #666;
				font-size: 16px;
			}
			
			.layui-tab-title li {
				padding: 0 40px;
			}
			
			.layui-tab-content {
				overflow: hidden;
				padding: 0 0 25px 30px;
				border-bottom: 1px dashed #E3E0DE;
			}
			
			.anniu button {
			
				margin-top: 20px;
				margin-right: 20px;
				background-color: #EC971F;
				font-weight: bold;
				color: #FFFFFF;
				border: none;
				width: 250px;
				font-size: 16px;
			}
			.anniu button:hover{
				color: #FFFFFF;
			}
			span img{
				height: 40px;
			}
		</style>
		<script type="text/javascript">
			$(function() {
				layui.use('form', function() {
					var form = layui.form;
					form.render();
				});
				$(".nav_new ul li").hover(function() {
						$(this).find(".nav_list").show();
						$(this).find("a.ztit").addClass("active");
					}, function() {
						$(this).find("a.ztit").removeClass("active");
						$(this).find(".nav_list").hide();
					}
				);
				var price=$("#price").val();
				$("#total").text("￥"+price);
			});
			//跳转到首页
			function toIndex(){
				document.location.href = '<%=basePath%>/signin/index.do';
			}
			//跳转到设计页面
			function toDesign(){
				document.location.href = '<%=basePath%>/design/toDesign.do';
			}
			//跳转到摄影图库页面
			function toPhotography(){
				document.location.href = '<%=basePath%>/photography/toPhotography.do';
			}
			//跳转到婚秀页面
			function toWedding(){
				document.location.href = '<%=basePath%>/wedding/toWedding.do';
			}
			//跳转到道具页面
			function toMultimedia(){
				document.location.href = '<%=basePath%>/multimedia/toMultimedia.do';
			}
			//跳转到免费下载页面
			function toFree(){
				document.location.href = '<%=basePath%>/free/toFree.do';
			}
			//跳转到求助求图页面
			function toHelp(){
				document.location.href = '<%=basePath%>/help/toHelp.do';
			}
			//跳转到上传作品页面
			function toUpload(){
				document.location.href = '<%=basePath%>/uploadFile/toUpload.do';
			}
			//跳转到收藏页面
			function toCollection(){
				document.location.href = '<%=basePath%>/personalcenter/toCollection.do';
			}
			//支付
			function orderPay(){
				var uid=$("#uid").val();
				var price=$("#price").val();
				document.location.href = '<%=basePath%>/pay/orderPay.do?uid='+uid+"&price="+price;
			}
		</script>

	</head>

	<body>
	<!--购物车记录ID串-->
	<input id="uid" name="uid" type="hidden" value="<%= request.getAttribute("uid")%>"/>
	<!--价格总和-->
	<input id="price" name="price" type="hidden" value="<%= request.getAttribute("total")%>"/>
		<header>
			<div class="top">
				<div class="top_wid logo_con">
					<a href="#" onclick="toIndex()" class="fl"><img src="<%=basePath%>/static/images/logo.png" height="62" width="217" /></a>
					<div class="nav_new fl">
						<ul class="clearfix">
							<li><a href="#" onclick="toIndex()" class="ztit">网站首页</a></li>
							<li><a href="javascript:" class="all_fl ztit">所有分类</a>
								<div class="nav_list">
									<a href="#" onclick="toDesign()">设 计</a>
									<a href="#" onclick="toPhotography()">摄影图库</a>
									<a href="#" onclick="toMultimedia()">道具新品</a>
									<a href="#" onclick="toWedding()">婚 秀</a>
									<a href="#" onclick="toHelp()">求图求助</a>
									<a href="#" onclick="toFree()">免费下载</a>
								</div>
							</li>
						</ul>
					</div>
					<div class="ss_bg new_ss fl">
						<input name="" type="text" placeholder="请输入搜索内容" class="inp_txt">
						<input type="submit" value="搜 索" class="ss_btn" />
					</div>
				</div>
				<!-- top_wid -->
			</div>
			<!-- top -->
		</header>
		<div class="bg_f5">
			<div class="wrap" style="padding-top: 20px;">
				<div class="wid1200px">
					<div class="memder_con">
							<div class="layui-row zaixian">
								<p>在线支付:<span id="total"></span></p>
								<div class="layui-tab">
									<ul class="layui-tab-title">
										<li class="layui-this">选择支付方式</li>
									</ul>
									<div class="layui-tab-content">
										<div class="layui-tab-item layui-show">
											<div id="wrap">
												<div id="top">

													<p id='color'>

														<span><img src="<%=basePath%>/static/images/share_icon3.png">&nbsp;&nbsp;支付宝支付</span>
														<span><img src="<%=basePath%>/static/images/share_icon2.png">&nbsp;&nbsp;微信支付</span>
														<span><img src="<%=basePath%>/static/images/share_icon5.png">&nbsp;&nbsp;银联支付</span>
													</p>

												</div>

											</div>
										</div>

									</div>
									<div class="layui-form-item anniu">
										<button onclick="orderPay()" class="layui-btn layui-btn-primary">确认购买</button>
									</div>
								</div>
							</div>
					</div>
				</div>
			</div>
		</div>
		<!-- bg_f5 -->
				<!-- 公共底部 -->
				<footer style="margin-top: 20px;">
					<div class="wrap">
						<div class="bottom clearfix">
							<dl>
								<dt>新手帮助</dt>
								<dd><a href="<%=basePath%>/helpd/toHelpd.do">注册/登录</a></dd>
								<dd><a href="<%=basePath%>/helpd/toHelpd.do">认证/签约</a></dd>
								<dd><a href="<%=basePath%>/helpd/toHelpd.do">条款协议</a></dd>
								<dd><a href="<%=basePath%>/helpd/toHelpd.do">版权声明</a></dd>
							</dl>
							<dl>
								<dt>关于婚秀中国</dt>
								<dd><a href="<%=basePath%>/helpd/toHelpd.do">婚秀中国简介</a></dd>
							</dl>
							<dl>
								<dt>联系我们</dt>
								<dd>客服电话：<b class="col_f00">400-879-51747</b></dd>

							</dl>

							<div class="botm_fr">
								<img src="<%=basePath%>/static/images/logo.png" height="62" width="217" />
								<p>婚庆行业专业的咨询平台</p>
								<div class="zx_box"><img src="<%=basePath%>/static/images/zx_pic.png" height="17" width="22" />咨询时间：8:30-17:00</div>
							</div>

						</div>
					</div>
				</footer>
				<script type="text/javascript">
					var cSpan = document.getElementById('color').getElementsByTagName('span');
					var aSpan = document.getElementsByTagName('span');
					var oModel = document.getElementById('model');

					cSpan[0].className = 'on';

					for(var i = 0; i < aSpan.length; i++) {

						aSpan[i].onclick = function() {
							var siblings = this.parentNode.children;
							for(var j = 0; j < siblings.length; j++) {
								siblings[j].className = '';
							}
							this.className = 'on';

							if(this.parentNode == oModel || this.parentNode == oRom) {
								price();
							}
						};
					};
				</script>
	</body>

</html>