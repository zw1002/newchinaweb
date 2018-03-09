<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<html>
<head>
	<meta charset="utf-8">
	<title>婚秀中国网</title>
	<link rel="icon" href="<%=basePath%>/static/images/ico.ico" type="image/x-icon"/>
	<link href="<%=basePath%>/static/css/global.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>/static/css/index.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>/static/css/laypage.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>/static/css/layui.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/css/style.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/css/bootstrap.min.css" />
	<script type="text/javascript" src="<%=basePath%>/static/js/laydate.js"></script>
	<script src="<%=basePath%>/static/layui/layui.js"></script>
	<script src="<%=basePath%>/static/layui/lay/modules/form.js"></script>
	<script src="<%=basePath%>/static/js/laypage.js"></script>
	<script type="text/javascript" src="<%=basePath%>/static/js/jquery1.42.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>/static/js/jquery.SuperSlide.2.1.1.js"></script>
	<style>
		.sc_padd {
			padding: 10px 0px;
		}
		.layui-elem-field legend {
			font-size: 16px;
		}
		.jiange {
			border-top: 1px dashed #e6e6e6;
			margin-top: 30px;
			margin-bottom: 30px;
		}
		.layui-form-item .layui-input-inline {
			float: left;
			width: 380px;
			margin-right: 3px;
		}
		.layui-form-select .layui-input {
			color: #757575;
		}
		.xuqiu {
			margin-top: 10px;
		}
		.layui-btn-primary:hover {
			border-color: #e94653;
		}
		.chankao {
			border: none;
			float: right;
		}
		.xuqiu span {
			font-size: 12px;
		}
		.layui-btn+.layui-btn {
			margin-left: 0px;
		}
		.goumai {
			background-color: #dcdede;
			color: #666;
			margin-top: 5px;
		}
		.goumai:hover {
			background-color: #e94653;
			color: #fff;
		}
		.maiduan {
			background-color: #dcdede;
			color: #666;
			margin-top: 5px;
		}
		.yongtu {
			border: 1px solid #e94653;
			margin-left: 110px;
			padding: 20px 10px;
			display: none;
		}
		.fabu {
			background-color: #E94653;
		}
		.hei40px {
			border: none;
		}
		.jy_tab_con {
			margin-top: -12px;
		}
		.layui-row {
			padding: 10px;
			border-top: 1px solid #efefef;
			margin: 0px auto;
			box-shadow: 0px 2px 3px #eaeaea;
		}
		.suoluotu img {
			width: 100px;
			margin-top: 8px;
		}
		.shuoming {
			text-align: left;
			padding: 5px;
			font-size: 14px;
		}
		.shuoming p {
			padding: 5px;
		}
		.xuanzhong {
			margin-top: 55px;
			text-align: center;
		}
		.xuanzhong1 {
			margin-top: 5px;
			padding: 0px 26px;
		}
		.jiage {
			margin-top: 55px;
		}
		.jiage:hover {
			cursor: pointer;
		}
		.caozuo {
			background: none;
			border: 1px solid #e94653;
			color: #e94653;
			margin-top: 45px;
		}
		.caozuo:hover {
			color: #e94653;
		}
		.layui-layer-page .layui-layer-btn {
			padding-top: 0!important;
			margin-top: -13px;
		}
		.Tid img {
			width: 80px;
			height: 80px;
			border-radius: 50px;
			margin-top: 10px;
		}
		.Tmingzi {
			margin-left: 25px;
			margin-top: 10px;
		}
		.layui-layer-btn a {
			height: 35px!important;
			line-height: 35px!important;
		}
		.shanchu {
			text-align: right;
			padding: 5px 20px;
			color: #e94653;
		}
		.shanchu:hover {
			cursor: pointer;
		}
		.container{
			width: 200px;
			height: 20px;
			margin-top: -22px;
		}
		#progress{
			height: 20px;
			background-color: #e94653;
			display: inline-block;
			color: white;
		}
	</style>
	<script>
		$(function() {
			$('#goumai').click(function() {
				$("#yongtu").toggle();
				$("#goumai").css("background", "#e94653");
				$("#goumai").css("color", "#fff");
				$("#maiduan").css("background", "#dcdede");
				$("#maiduan").css("color", "#666");
			});
			$('#maiduan').click(function() {
				$("#yongtu").hide();
				$("#goumai").css("background", "#dcdede");
				$("#goumai").css("color", "#666");
				$("#maiduan").css("background", "#e94653");
				$("#maiduan").css("color", "#fff");
			});
			getUserMerch();
			getMyGraph();
			getMySubmission();
			getCollectionGraph();
			getCollectionSubmission();
		});
		$(function() {
			layui.use(['form','layer'], function() {
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
		//获取会员店铺信息
		function getUserMerch(){
			//会员ID
			var uid="${userinfo.getUid()}";
			$.ajax({
				url: "<%=basePath%>/merch/getMerchData.do",
				type: "POST",
				data: {
					uid: uid
				},
				success: function (data) {
					var msg = eval("(" + data + ")");
					var res="";
					if(data == "null"){
						$("#balance").text("0.00");
						$("#withcash").text("0.00");
						$("#scroe").text("0.00");
						$("#role").html("");
						res = '<td width="50%"><a href="#" onclick="applyShop()">成为卖家</a></td>';
						$("#role").append(res);
						$("#uploadwork").css("display","none");
					}else{
						$("#balance").text(msg.merchscroe);
						$("#withcash").text(msg.merchscroe);
						$("#scroe").text(msg.merchscroe);
						if(msg.statu == 0){
							$("#role").html("");
							res = '<td width="50%">店铺信息审核中...</td>';
							$("#role").append(res);
							$("#uploadwork").css("display","none");
						}else if(msg.statu == 1){
							$("#role").html("");
							res = '<td width="50%">我是卖家</td>';
							$("#role").append(res);
						}else if(msg.statu == 2){
							$("#role").html("");
							res = '<td width="50%"><a href="#" onclick="applyShop()">申请驳回，完善资料后重新提交!</a></td>';
							$("#role").append(res);
							$("#uploadwork").css("display","none");
						}else{
							$("#role").html("");
							res = '<td width="50%"><a href="#">店铺已经冻结!</a></td>';
							$("#role").append(res);
						}
					}
				}
			});
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
		//跳转到交易页面
		function toTransaction(){
			document.location.href = '<%=basePath%>/personalcenter/toTransaction.do';
		}
		//跳转到会员空间页面
		function toHomepage(){
			var uid="${userinfo.getUid()}";
			document.location.href = '<%=basePath%>/homepage/toHomepage.do?uid='+uid;
		}
		//跳转到我的作品页面
		function personWorks(){
			var uid="${userinfo.getUid()}";
			document.location.href = '<%=basePath%>/personworks/toPersonWorks.do?uid='+uid;
		}
		//跳转到提现页面
		function toWithdrawals(){
			var uid="${userinfo.getUid()}";
			document.location.href = '<%=basePath%>/withdrawals/toWithdrawals.do?uid='+uid;
		}
		//开店
		function applyShop(){
			document.location.href = '<%=basePath%>/applyshop/toApplyShop.do';
		}
		//根据作品类型获取作品分类下拉列表
		layui.use(['layer', 'form','laydate'], function() {
			var form = layui.form;
			var laydate = layui.laydate;
			//常规用法
			laydate.render({
				elem: '#endtime'
			});
			form.on('select(graphtype)', function(data){
				$.getJSON("<%=basePath%>/personalcenter/getWorkClassification.do?workstype="+data.value, function(data){
					var msg=eval(data);
					$("#graphclassification").html("");
					$.each(msg, function(name, value) {
						var varItem2 = new Option(value.keyname,value.keyvalue);
						$("#graphclassification").append(varItem2);
					});
					form.render('select'); //这个很重要
				});
			});
		});
		//校验表单
		function check(){
			var layer = layui.layer;
			if($('#graphtype').val()==""){
				layer.msg("请选择任务类别!",{icon: 5,time:2000});
				$(".layui-layer").css("top","200px");
				return false;
			}
			if($('#graphtitle').val()==""){
				layer.msg("请输入任务标题!",{icon: 5,time:2000});
				$(".layui-layer").css("top","200px");
				return false;
			}
			if($('#graphdetail').val()==""){
				layer.msg("请输入需求详情!",{icon: 5,time:2000});
				$(".layui-layer").css("top","200px");
				return false;
			}
			if($('#moneyreward').val()==""){
				layer.msg("请输入任务赏金!",{icon: 5,time:2000});
				$(".layui-layer").css("top","200px");
				return false;
			}
			if($('#endtime').val()==""){
				layer.msg("请输入任务截止时间!",{icon: 5,time:2000});
				$(".layui-layer").css("top","200px");
				return false;
			}
			var file=document.getElementById('file').files[0];
			if(!file){
				layer.msg("请选择任务附件!",{icon: 5,time:2000});
				$(".layui-layer").css("top","200px");
				return false;
			}
			fabu();
		}
		function fabu(){
			$("#jindu1").css("display","block");
			var fd = new FormData();
			var graphtype=$("#graphtype").val();
			var graphclassification=$("#graphclassification").val();
			var graphtitle=$("#graphtitle").val();
			var graphdetail=$("#graphdetail").val();
			var moneyreward=$("#moneyreward").val();
			var endtime=$("#endtime").val();
			fd.append("file", document.getElementById('file').files[0]);
			fd.append("graphtype", graphtype);
			fd.append("graphclassification", graphclassification);
			fd.append("graphtitle", graphtitle);
			fd.append("graphdetail", graphdetail);
			fd.append("moneyreward", moneyreward);
			fd.append("endtime", endtime);
			var xhr = new XMLHttpRequest();
			xhr.upload.addEventListener("progress", uploadProgress, false);
			xhr.addEventListener("load", uploadComplete, false);
			xhr.addEventListener("error", uploadFailed, false);
			xhr.addEventListener("abort", uploadCanceled, false);
			xhr.open("POST", "<%=basePath%>/graph/filesUpload.do");//修改成自己的接口
			xhr.send(fd);
		}
		function uploadProgress(evt) {
			if (evt.lengthComputable) {
				var percent = Math.round(evt.loaded * 100 / evt.total);
				document.getElementById('progress').innerHTML = percent.toFixed(2) + '%';
				document.getElementById('progress').style.width = percent.toFixed(2) + '%';
			}
			else {
				document.getElementById('progress').innerHTML = 'unable to compute';
			}
		}
		function uploadComplete(evt) {
			if(evt.target.responseText.indexOf("true")){
				alert("发布成功");
				document.location.href = '<%=basePath%>/qiutu/toQiutu.do';
			}else{
				alert("发布失败");
			}
		}
		function uploadFailed(evt) {
			alert("There was an error attempting to upload the file.");
		}
		function uploadCanceled(evt) {
			alert("The upload has been canceled by the user or the browser dropped the connection.");
		}
		//我的任务
		function getMyGraph(){
			$.ajax({
				url: "<%=basePath%>/graph/getMyGraph.do",
				type: "POST",
				success: function (data) {
					if(data!=="failed"){
						var msg = eval("(" + data + ")");
						var res = "";
						for(var i=0;i<msg.length;i++){
							res += '<div class="layui-row"><div class="layui-col-xs9 shuoming">'
									+'<div class="grid-demo"> <p style="color: #EC971F;font-weight: 600;">￥'+msg[i].moneyreward+'</p> <p><strong>标题：</strong>'+msg[i].graphtitle+'</p>'
									+'<p><strong>任务类别：</strong>'+msg[i].graphtype+'&nbsp;&nbsp;&nbsp;&nbsp;<strong>任务分类：</strong>'+msg[i].graphclassification+'</p><p><strong>发布时间：</strong>'+msg[i].addtime+'&nbsp;&nbsp;&nbsp;&nbsp;<strong>收藏量：</strong>'+msg[i].favcount+'&nbsp;&nbsp;&nbsp;&nbsp;<strong>点击量：</strong>'+msg[i].ticknums+'</p> </div> </div> <div class="layui-col-xs1">'
									+'<div class="grid-demo "> <a href="<%=basePath%>/submission/toTouGao.do?uid='+msg[i].uid+'" class="layui-btn caozuo">详情</a> </div> </div> </div>';
						}
						$("#myGraph").append(res);
					}
				}
			});
		}
		//我的稿件
		function getMySubmission(){
			$.ajax({
				url: "<%=basePath%>/graph/getMySubmission.do",
				type: "POST",
				success: function (data) {
					if(data!=="failed"){
						var msg = eval("(" + data + ")");
						var res = "";
						for(var i=0;i<msg.length;i++){
							res += '<div class="layui-col-xs7 shuoming"> <div class="grid-demo"> <p style="color: #EC971F;font-weight: 600;">￥'+msg[i].moneyreward+'</p>'
									+'<p><strong>标题：</strong>'+msg[i].graphtitle+'</p><p><strong>任务类别：</strong>'+msg[i].graphtype+'&nbsp;&nbsp;&nbsp;&nbsp;<strong>任务分类：</strong>'+msg[i].graphclassification+'</p>'
									+'<p><strong>发布时间：</strong>'+msg[i].addtime+'&nbsp;&nbsp;&nbsp;&nbsp;<strong>收藏量：</strong>'+msg[i].favcount+'&nbsp;&nbsp;&nbsp;&nbsp;<strong>点击量：</strong>'+msg[i].ticknums+'</p></div> </div>'
									+'<div class="layui-col-xs2 Tid"> <div class="grid-demo grid-demo-bg1"> <img src="<%=basePath%>'+msg[i].subuserpicurl+'">'
									+'<p class="Tmingzi">'+msg[i].subusername+'</p> </div> </div> <div class="layui-col-xs1">'
									+'<div class="grid-demo "> <a href="<%=basePath%>/graph/downloadFile.do?submission='+msg[i].submissionid+'" class="layui-btn caozuo">下载原件</a> </div> </div> </div>';
						}
						$("#mySubmission").append(res);
					}
				}
			});
		}
		//获取任务收藏
		function getCollectionGraph(){
			$.ajax({
				url: "<%=basePath%>/graph/getCollectionGraph.do",
				type: "POST",
				success: function (data) {
					if(data!=="failed"){
						var msg = eval("(" + data + ")");
						var res = "";
						for(var i=0;i<msg.length;i++){
							res += '<div class="layui-row"><div class="layui-col-xs2 suoluotu"> <div class="grid-demo grid-demo-bg1">'
									+'</div> </div> <div class="layui-col-xs8 shuoming"> <div class="grid-demo">'
									+'<p style="color: #EC971F;font-weight: 600;">￥'+msg[i].moneyreward+'</p> <p>'+msg[i].graphtitle+'</p> <p>任务类别:'+msg[i].graphtype+'&nbsp;&nbsp;&nbsp;&nbsp;任务分类:'+msg[i].graphclassification+'</p> <p>收藏时间:'+msg[i].addtime+'</p> </div> </div>'
									+'<div class="layui-col-xs1"> <div class="grid-demo "><a href="<%=basePath%>/submission/toTouGao.do?uid='+msg[i].graphid+'" class="layui-btn caozuo">详情</a><button style="margin-left:100px;margin-top:-37px" onclick=delCollectionGraph("'+msg[i].graphid+'") class="layui-btn caozuo">取消收藏</button> </div> </div> </div>';
						}
						$("#collectionGraph").append(res);
					}
				}
			});
		}
		//取消收藏任务
		function delCollectionGraph(uid){
			$.ajax({
				url: "<%=basePath%>/collection/delcollectionGraph.do",
				type: "POST",
				async:false,
				data: {
					uid: uid
				},
				success: function (data) {
					if (data !== "failed") {
						alert("取消收藏成功");
					}else{
						alert("取消收藏失败");
					}
				}
			});
		}
		//获取稿件收藏
		function getCollectionSubmission(){
			$.ajax({
				url: "<%=basePath%>/graph/getCollectionSubmission.do",
				type: "POST",
				success: function (data) {
					if(data!=="failed"){
						var msg = eval("(" + data + ")");
						var res = "";
						for(var i=0;i<msg.length;i++){
							res += '<div class="layui-row"> <div class="layui-col-xs2 suoluotu"> <div class="grid-demo grid-demo-bg1"> <a href="<%=basePath%>/submission/toTouGao.do?uid='+msg[i].graphid+'"><img src="<%=basePath%>'+msg[i].waterurl+'"></a>'
									+'</div> </div> <div class="layui-col-xs6 shuoming"> <div class="grid-demo"> <p style="color: #EC971F;font-weight: 600;">￥'+msg[i].moneyreward+'</p>'
									+'<p>'+msg[i].graphtitle+'</p> <p>稿件名称:'+msg[i].worksname+'&nbsp;&nbsp;稿件格式:'+msg[i].imgformart+'&nbsp;&nbsp;稿件颜色模式:'+msg[i].colrmodel+'</p> <p>收藏时间:'+msg[i].addtime+'</p> </div> </div> <div class="layui-col-xs2 Tid">'
									+'<div class="grid-demo grid-demo-bg1"> <img src="<%=basePath%>'+msg[i].userpicurl+'"> <p class="Tmingzi">'+msg[i].username+'</p> </div> </div>'
									+'<div class="layui-col-xs1"> <div class="grid-demo "> <button onclick=delCollectionSubmission("'+msg[i].submissionid+'") class="layui-btn caozuo">取消收藏</button> </div> </div> </div>';
						}
						$("#collectionSubmission").append(res);
					}
				}
			});
		}
		//取消收藏稿件
		function delCollectionSubmission(uid){
				$.ajax({
					url: "<%=basePath%>/collection/delcollectionSubmission.do",
					type: "POST",
					data: {
						uid: uid
					},
					success: function (data) {
						if (data !== "failed") {
							alert("取消收藏成功");
						}else{
							alert("取消收藏失败");
						}
					}
				});
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
	</div>
	<!-- top -->
</header>
<div class="bg_f5">
	<div class="wrap">
		<div class="memder_con">
			<div class="wid260px fl">
				<div class="grzl_box">
					<a href="#" onclick="toHomepage()" class="kj_lj">个人空间 ></a>
					<div class="tx_infor">
						<img src="<%=basePath%>${userinfo.getUsrpicurl()}" />
						<h2>${userinfo.getFristname()}</h2>
					</div>
					<div class="mj_tab">
						<table width="100%">
							<tr id="role">

							</tr>
						</table>
					</div>
				</div>
				<!-- grzl_box -->
				<div class="mem_nav">
					<h2>个人中心</h2>
					<ul>
						<li id="uploadwork"><a class="mem_icon1" href="#" onclick="toUpload()">上传作品</a></li>
						<li><a class="mem_icon9" href="#" onclick="personWorks()">我的作品</a></li>
						<li><a class="mem_icon9" href="<%=basePath%>/personalcenter/toDownload.do" onclick="persoDownload()">我的下载</a></li>
						<li><a class="mem_icon2 active" href="<%=basePath%>/qiutu/toQiutu.do">求助求图</a></li>
						<li><a class="mem_icon2" href="#" onclick="toCollection()">收藏</a></li>
						<li><a class="mem_icon4" href="#" onclick="toTransaction()">交易</a></li>
						<li><a class="mem_icon7" href="#" onclick="toWithdrawals()">提现</a></li>
						<li><a class="mem_icon9" href="<%=basePath%>/persondata/toPersonData.do">个人资料</a></li>
					</ul>
				</div>
			</div>
			<!-- wid260px -->
			<div class="wid925px fr">
				<div class="tran_con" style="margin-top: 0px;">
					<div class="jy_nav">
						<ul class=" clearfix">
							<li>发布任务</li>
							<li>我的任务</li>
							<li>我的稿件</li>
							<li>任务收藏</li>
							<li>稿件收藏</li>
						</ul>
					</div>
					<div class="jy_tab_con">
						<!--发布任务-->
						<ul>
							<form class="layui-form" action="" method="POST" enctype="multipart/form-data">
								<div class="fytd_box">
									<div class="hei40px" style="color: #ffbb76;">
										提示：提交任务虚满足以下条件:1.可用于金额大于等于当前任务金额;2.账户没有被冻结;
									</div>
									<div class="sc_padd">
										<ul class="navd nav-pills nav-justified step step-progress" data-step="7">
											<li class="active">
												<a>提交需求<span class="caret"></span></a>
											</li>
											<li class="active">
												<a>冻结赏金<span class="caret"></span></a>
											</li>
											<li>
												<a>审核发布<span class="caret"></span></a>
											</li>
											<li>
												<a>投稿<span class="caret"></span></a>
											</li>
											<li>
												<a>选稿<span class="caret"></span></a>
											</li>
											<li>
												<a>公示<span class="caret"></span></a>
											</li>
											<li>
												<a>打款<span class="caret"></span></a>
											</li>
										</ul>
										<script type="text/javascript" src="<%=basePath%>/static/js/lib.js"></script>
										<script>
											$(function() {
												bsStep();
												//bsStep(i) i 为number 可定位到第几步 如bsStep(2)/bsStep(3)
											})
										</script>

									</div>
								</div>
								<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
									<legend><span style="color: #C9302C;">*</span>请确认您的联系方式，以便及时沟通</legend>
								</fieldset>
								<div class="layui-form-item">

									<label class="layui-form-label">手机号</label>
									<div class="layui-input-block">
										<input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入您的手机号" class="layui-input">
									</div>

								</div>
								<div class="layui-form-item">

									<label class="layui-form-label">验证码</label>
									<div class="layui-input-block">
										<input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入验证码" class="layui-input" style="width: 668px;float: left;">
										<button class="layui-btn layui-btn-danger" style="position: absolute;float: left;background-color: #e94653;">获取验证码</button>
									</div>

								</div>
								<div class="jiange"></div>
								<div class="layui-form-item">
									<label class="layui-form-label"><span style="color: #C9302C;">*</span>任务分类</label>
									<div class="layui-input-inline">
										<select lay-filter="graphtype" name="graphtype" id="graphtype" lay-verify="required">
											<option value=""></option>
											<option value="00">设计</option>
											<option value="10">摄影</option>
											<option value="20">道具</option>
											<option value="30">婚秀</option>
										</select>
									</div>
									<div class="layui-input-inline">
										<select lay-filter="graphclassification" name="graphclassification" id="graphclassification" lay-verify="required">
										</select>
									</div>

								</div>
								<div class="layui-form-item">
									<label class="layui-form-label"><span style="color: #C9302C;">*</span>任务标题</label>
									<div class="layui-input-block">
										<input type="text" name="graphtitle" id="graphtitle" lay-verify="graphtitle" autocomplete="off" placeholder="请准确填写需求图片的标题，20字以内" class="layui-input">
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label"><span style="color: #C9302C;">*</span>需求详情</label>
									<div class="layui-input-block">
										<textarea placeholder="注意：多条记录已中文分号分号“；”分割" id="graphdetail" name="graphdetail" class="layui-textarea"></textarea>
										<input style="margin-top: 20px" type="file" name="file" id="file">
										<div id="jindu" style="display:none" class='container'>
											<span style="width:230px;text-align: center" id="progress"></span>
										</div>
									</div>
								</div>
								<div class="jiange"></div>
								<!--
								<div class="layui-form-item">
									<label class="layui-form-label"><span style="color: #C9302C;">*</span>征集模式</label>
									<button type="button" class="layui-btn goumai" id="goumai">购买使用权</button>
									<button type="button" class="layui-btn maiduan" id="maiduan">买断版权</button>
									<div class="layui-form-item yongtu" id="yongtu">
										<label class="layui-form-label">作品用途</label>
										<div class="layui-input-inline">
											<select name="quiz2">
												<option value="杭州">用于广告</option>
												<option value="宁波">用于明信片</option>
												<option value="温州">用于产品包装</option>
											</select>
										</div>
									</div>
								</div>
								-->
								<div class="layui-form-item">
									<div class="layui-inline">
										<label class="layui-form-label"><span style="color: #C9302C;">*</span>赏金设置</label>
										<div class="layui-input-inline" style="width: 345px;">
											<input type="text" id="moneyreward" name="moneyreward" placeholder="请输入金额" autocomplete="off" class="layui-input">
										</div>
										<div class="layui-form-mid">元/件</div>
										<!--
										<div class="layui-input-inline" style="width: 345px;">
											<input type="text" name="price_max" placeholder="件数只允许输入1（含）以上的正整数" autocomplete="off" class="layui-input">
										</div>
										<div class="layui-form-mid">件</div>
										-->
									</div>
									<div class="hei40px" style="margin-left: 100px;color: #ffbb76;">
										温馨提示：任务赏金偏低会影响投稿数量及质量，请合理设定任务赏金
									</div>
								</div>
								<div class="layui-form-item">
									<label style="width: 90px;margin-left: -10px;" class="layui-form-label"><span style="color: #C9302C;">*</span>投稿截止时间</label>
									<div class="layui-inline">
										<div class="layui-input-inline">
											<input type="text" class="layui-input" id="endtime" name="endtime" placeholder="yyyy-MM-dd">
										</div>
									</div>
								</div>
								<!--
								<div class="layui-form-item" style="height: 40px">
									<label class="layui-form-label" style="width: 130px;"></label>
									<div class="layui-input-block">
										<input type="checkbox" name="like1[write]" lay-skin="primary" title="《婚秀协议》《婚秀协议》《婚秀协议》《婚秀协议》《婚秀协议》" checked="">
										<div class="layui-unselect layui-form-checkbox layui-form-checked" lay-skin="primary"><span>《婚秀协议》《婚秀协议》《婚秀协议》《婚秀协议》《婚秀协议》</span><i class="layui-icon"></i></div>
									</div>
								</div>
								-->
							</form>
							<div class="anniu">
								<button onclick="check()" class="layui-btn layui-btn-warm fabu">发布</button>
							</div>
						</ul>
						<!--我的任务-->
						<ul>
							<form id="myGraph" class="layui-form" action="">
							</form>
						</ul>
						<!--我的稿件-->
						<ul>
							<form id="mySubmission" class="layui-form" action="">

							</form>
						</ul>
						<!--任务收藏-->
						<ul>
							<form id="collectionGraph" class="layui-form" action="">

							</form>
						</ul>
						<!--稿件收藏-->
						<ul>
							<form id="collectionSubmission" class="layui-form" action="">

							</form>
						</ul>
					</div>

					<script type="text/javascript">
						jQuery(".tran_con").slide({
							titCell: ".jy_nav li",
							mainCell: ".jy_tab_con",
							trigger: "click"
						})
					</script>
					<!--
					<script>
						laypage({
							cont: ('pages'), //容器。值支持id名、原生dom对象，jquery对象,
							pages: 10, //分页数。一般通过服务端返回得到
							curr: 1, //当前页。默认为1
							groups: 5, //连续显示分页数  默认为5
							skin: '#e8474b', //控制分页皮肤。目前支持：molv、yahei、flow  也可以自定义
							skip: true, //是否开启跳页
							first: '首页', //用于控制首页  默认false
							last: '尾页', //用于控制尾页  如：last: '尾页' 如：last: false，则表示不显示首页项
							prev: '上一页', //用于控制上一页。若不显示，设置false即可
							next: '下一页', //用于控制下一页。若不显示，设置false即可
							jump: function(obj, first) {
								//触发分页后的回调，函数返回两个参数。 得到了当前页，用于向服务端请求对应数据
								var curr = obj.curr;
							}

						});
					</script>
-->
				</div>
				<!-- wid925px -->

				<div class="clear"></div>

			</div>
			<!-- mem_ty_box -->

			<div class="clear"></div>

		</div>
		<!-- memder_con -->

	</div>
	<!-- wrap -->
</div>
<!-- bg_f5 -->

<!-- 公共底部 -->
<footer>
	<div class="wrap">
		<div class="bottom clearfix">
			<dl>
				<dt>新手帮助</dt>
				<dd>
					<a href="javascript:">注册/登录</a>
				</dd>
				<dd>
					<a href="javascript:">认证/签约</a>
				</dd>

				<dd>
					<a href="javascript:">条款协议</a>
				</dd>
				<dd>
					<a href="javascript:">版权声明</a>
				</dd>
			</dl>

			<dl>
				<dt>关于婚秀中国</dt>
				<dd>
					<a href="javascript:">婚秀中国简介</a>
				</dd>

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