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
			.layui-col-xs1 {
				text-align: center;
				padding: 5px;
				font-size: 16px;
			}

			.layui-col-xs2 {
				text-align: center;
				padding: 5px;
				font-size: 16px;
			}

			.layui-col-xs3 {
				text-align: center;
				padding: 5px;
				font-size: 16px;
			}

			.layui-col-xs3 p {
				padding: 5px;
			}

			.layui-col-xs2 img {
				width: 100px;
			}
			.wid1200px{
				width: 1200px;
				background-color: #ffffff;
			}
			.grid-demo p{
				text-align: left;
			}
			.layui-row{
				padding: 10px;
				border-top: 1px solid #efefef;
				width: 1100px;
				margin: 0px auto;
				box-shadow: 0px 2px 3px #eaeaea;
			}
			.layui-input{
				margin-top: 40px;

			}
			.jiage{
				margin-top: 45px;
				color: #EC971F;
				font-size: 20px;
			}
			.shoucang{
				margin-top: 45px;

			    font-size: 16px;
			}
			.shoucang:hover{
				cursor: pointer;
			}
			.layui-form-select .layui-input{
				color: #666;
			}
			.fukuan{
				padding: 20px;
				margin-bottom: 0;
			}
			.fukuan label{
				float: right;
				margin-right: 20px;
			}
			.anniu{
				margin-bottom: 0;
			}
			.anniu button{
				float: right;
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
				)
			});
			$(document).ready(function () {
				getCarData();
			});
			//获取购物车数据
			function getCarData(){
				$.ajax({
					url: "<%=basePath%>/pay/getCarData.do",
					type: "POST",
					async: false,
					success: function (data) {
						var msg = eval("(" + data + ")");
						var str="";
						for(var i=0;i<msg.length;i++) {
							str += '<div class="layui-row"><div class="layui-col-xs1" style="margin-top: 45px;" >'
									+'<input value="'+msg[i].price+'" onclick="changePrice()" id="'+msg[i].workid+'" type="checkbox" name="like1[write]" lay-skin="primary">'
									+'</div> <div class="layui-col-xs2">'
									+'<div style="margin-top:15px" class="grid-demo grid-demo-bg1"> <a href="<%=basePath%>/design/toDesignDel.do?uid='+msg[i].workid+'"> <img src="<%=basePath%>'+msg[i].samllurl+'"> </a> </div> </div>'
									+'<div class="layui-col-xs3"> <div class="grid-demo"> <p style="color: #EC971F;font-weight: 600;">'+msg[i].workname+'</p>'
									+'<p>作品分辨率：'+msg[i].dpinum+'</p> <p>作品格式：'+msg[i].imgformart+'</p> <p>上传者：'+msg[i].username+'</p> </div> </div>'
									+'<div class="layui-col-xs2"> <div class="grid-demo jiage">￥'+msg[i].price+'</div> </div>'
									+'<div style="margin-top: 48px" class="layui-col-xs1"> <a href="<%=basePath%>/pay/delCarData.do?uid='+msg[i].uid+'" class="grid-demo shoucang">删除</a> </div></div>';
						}
						$("#usercardata").append(str);
					}
				});
			}
			//改变已选购作数数和价格
			function changePrice(){
				var worknum=$("#worknum").text();
				var total=$("#total").text();
				var price;
				$("input[name='like1[write]']:checkbox:checked").each(function(){
					price = $(this).attr("value");
				});
				$("#total").text(Number(total)+Number(price));
				$("#worknum").text(Number(worknum)+Number(1));
			}
			//确认购买
			function goPay(){
				var uid="";
				$("input[name='like1[write]']:checkbox:checked").each(function(){
					uid += $(this).attr("id")+",";
				});
				var total=$("#total").text();
				document.location.href = '<%=basePath%>/pay/toPay.do?uid='+uid+"&total="+total;
			}
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
		</script>
	</head>
	<body>
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
					<div class="layui-row">
						<div class="layui-col-xs1">
						</div>
						<div class="layui-col-xs2">
							<div class="grid-demo grid-demo-bg1">图片信息</div>
						</div>
						<div class="layui-col-xs3" style="text-align: left;">
							<div class="grid-demo">作品信息</div>
						</div>
						<div class="layui-col-xs2">
							<div class="grid-demo">价格</div>
						</div>
						<div class="layui-col-xs1">
							<div class="grid-demo">操作</div>
						</div>
					</div>
						<div id="usercardata">
						</div>
						<div class="layui-form-item fukuan">
							<label>
								已选作品
								<span id="worknum" style="font-size: 20px;font-weight: bold;color: #EC971F;">0</span>&nbsp;&nbsp;&nbsp;
								合计:
								<span style="font-size: 30px;color: #EC971F;font-weight: bold;">￥</span>
								<span id="total" style="font-size: 30px;color: #EC971F;font-weight: bold;">0</span>
							</label>
						</div>
						<div class="layui-form-item anniu">
							<button onclick="goPay()" class="layui-btn layui-btn-primary">确认购买</button>
						</div>
					</div>
				</div>
			</div>
		</div>
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

	</body>

</html>