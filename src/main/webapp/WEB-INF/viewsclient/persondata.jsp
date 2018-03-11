
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
	<link href="<%=basePath%>/static/css/layui.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=basePath%>/static/js/jquery1.42.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>/static/js/jquery.SuperSlide.2.1.1.js"></script>
	<script src="<%=basePath%>/static/layui/layui.js"></script>
	<style>
		.layui-input {
			width: 100%;
		}
		.bangding {
			background-color: #5FB878;
		}
		.baocun {
			background-color: #E94653;
		}
		.jinzhi,
		.dianhua {
			width: 525px;
		}

		.layui-input-block {
			margin-left: 0;
			min-height: 0;
		}
		.touxiang {
			float: right;
			margin-right: 150px;
		}
		.touxiang2 {
			float: right;
			margin-right: 150px;
			margin-top: 200px;
		}
		.touxiang img {
			width: 80px;
			height:80px;
			border: 1px solid #a5a5a5;margin-left: 5px;
		}
		.touxiang .layui-input-block {
			float: right;
			position: absolute;
			margin-top: 25px;
		}

		.layui-form-item {
			margin-bottom: 25px;
		}

		.shili {
			position: inherit;
			float: left;
			margin-left: 20px;
		}
		.shili1 {
			position: inherit;
			float: left;
			margin-left: 20px;
		}
		.shili img{
			width: 120px;
		}
		.shili1 p{
			padding: 5px 0;
		}
	</style>
	<script type="text/javascript">
		$(function(){
			getUserMerch();
			$(".nav_new ul li").hover(function(){
						$(this).find(".nav_list").show();
						$(this).find("a.ztit").addClass("active");
					},function(){
						$(this).find("a.ztit").removeClass("active");
						$(this).find(".nav_list").hide();
					}
			);
			$('.ss_btn').click(function () {
				document.location.href = '<%=basePath%>/seachs/toSeachs.do?seachTxt='+$('.inp_txt').val();
			});
			var uzhiye="${userinfo.getZhiye()}";
			$('.div_usertype input[type=checkbox]').each(function() {
				if(uzhiye.indexOf($(this).val())!=-1){
					$(this).attr('checked','');
				}
				else  $(this).removeAttr('checked');
			});

			//获取身份标签
			var ulable="${userinfo.getLabel()}";
			$('.div_userlabel .layui-btn').each(function() {
				if(ulable.indexOf($(this).text())!=-1){
					$(this).removeClass('layui-btn-primary');
					$(this).addClass('layui-btn-warm');
				}
			});
			$('#div_bdinfo').html('');
			var bdinfoHtml="";
			var telphone="${userinfo.getTelephone()}";
			if(telphone!=undefined && telphone!="")
				bdinfoHtml=bdinfoHtml+"<p>手机号："+telphone.replace(/(\d{3})\d{4}(\d{4})/, '$1****$2')+"</p>";
			var strEmail="${userinfo.getEmail()}";
			if(strEmail!=undefined && strEmail!="")
				bdinfoHtml=bdinfoHtml+"<p>电子邮箱："+strEmail.replace(strEmail.substring(3,strEmail.lastIndexOf("@")),'***')+"</p>";
			var strbank="${userinfo.getBankcode()}";
			var selBank="";
			if(strbank!=undefined && strbank!="") {
				var bankinfo ="${userinfo.getBankaddr()}";
				var bankss = bankinfo.split(',');

				bdinfoHtml = bdinfoHtml+"<p>开户银行："+bankss[1]+"</p>";
				bdinfoHtml = bdinfoHtml+"<p>银行卡号：" + strbank.replace(strbank.substring(4),'**** **** ****') + "</p>";
				bdinfoHtml = bdinfoHtml+"<p>开户行地址："+bankss[0]+"</p>";
				selBank=bankss[1];
			}
			$('#div_bdinfo').html(bdinfoHtml);
			$.ajax({
				url: "<%=basePath%>/general/getGroupClass.do",
				type: "POST",
				async:false,
				data: {type:"银行组"},
				success: function (data) {
					data=eval('(' + data + ')');
					if(data.code=="0000"){
						for(var i=0;i<data.content.length;i++){
//                            if(selBank==data.content[i].typename)
//                        		$('#sel_bank').append("<option value='"+data.content[i].typename+"' selected>"+data.content[i].typename+"</option>");
//                            else
							$('#sel_bank').append("<option value='"+data.content[i].typename+"'>"+data.content[i].typename+"</option>");
						}
					}
				}
			});
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
					if(data == "null"){
						$("#role").html("");
						res = '<td width="50%"><a href="#" onclick="applyShop()">成为卖家</a></td>';
						$("#role").append(res);
						$("#uploadwork").css("display","none");
					}else{
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
				<input name="" type="text" placeholder="请输入搜索内容"  class="inp_txt">
				<input type="submit" value="搜 索" class="ss_btn" />
			</div>
		</div><!-- top_wid -->
	</div><!-- top -->
</header>
<div class="bg_f5">
	<div class="wrap">
		<div class="memder_con">
			<div class="wid260px fl">
				<div class="grzl_box">
					<a href="#" onclick="toHomepage()" class="kj_lj">个人空间 ></a>
					<div class="tx_infor" >
						<img  src="<%=basePath%>${userinfo.getUsrpicurl()}"/>
						<h2>${userinfo.getFristname()}</h2>
					</div>
					<div class="mj_tab">
						<table width="100%">
							<tr id="role">

							</tr>
						</table>
					</div>
				</div><!-- grzl_box -->
				<div class="mem_nav">
					<h2>个人中心</h2>
					<ul>
						<li id="uploadwork"><a class="mem_icon1" href="#" onclick="toUpload()">上传作品</a></li>
						<li><a class="mem_icon9" href="#" onclick="personWorks()">我的作品</a></li>
						<li><a class="mem_icon9" href="<%=basePath%>/personalcenter/toDownload.do" onclick="persoDownload()">我的下载</a></li>
						<li><a class="mem_icon2" href="<%=basePath%>/qiutu/toQiutu.do">求助求图</a></li>
						<li><a class="mem_icon2" href="#" onclick="toCollection()">收藏</a></li>
						<li><a class="mem_icon4" href="#" onclick="toTransaction()">交易</a></li>
						<li><a class="mem_icon7" href="#" onclick="toWithdrawals()">提现</a></li>
						<li><a class="mem_icon9 active" href="javascript:;">个人资料</a></li>
					</ul>
				</div>
			</div><!-- wid260px -->
			<div class="wid925px fr">
				<div class="tran_con" style="margin-top: 0px;">
					<div class="jy_nav">
						<ul class=" clearfix">
							<li>基本资料</li>
							<li>账户信息</li>
							<li>认证信息</li>
							<li>密码修改</li>
							<li>登陆日志</li>
						</ul>
					</div>
					<div class="jy_tab_con">
						<!--基本资料-->
						<ul>
							<form class="layui-form" action="" >
								<div class="layui-form-item touxiang">
									<div class="layui-input-block" style="width: 140px;">

										<div class="tx_infor" style="border-bottom: none;">
											<img  id="img_logo" src="<%=basePath%>${userinfo.getUsrpicurl()}">
										</div>

									</div>
									<div  class="layui-input-block" style="margin-top: 110px;margin-left: 28px;">
										<button type="button" id="editLogo" class="layui-btn layui-btn-normal layui-btn-radius bangding">修改头像</button>
									</div>
									<div class="layui-input-block" style="margin-top: 150px;width: 150px;text-align: center;">
										<img title="二维码可右键选择另存为保存下载" alt="二维码可右键选择另存为保存下载" style="width: 80px;height:80px;" id="img_ercode" src="<%=basePath%>${accinfo.getExtend_2()}">
										<div  class="layui-input-block" style="margin-top: 5px;">
											<p>推荐注册码：${accinfo.getExtend_1()}</p>
											<p>此二维码为推广码，可下载分享推荐他人扫描注册，享受交易提成。</p>
										</div>
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label"><span style="color: #C9302C;">*</span>用户名</label>
									<div class="layui-input-block">
										<input type="text" name="txt_nc" id="txt_nc" lay-verify="required" autocomplete="off" class="layui-input dianhua" value="${userinfo.getFristname()}">
									</div>

								</div>
								<div class="layui-form-item">
									<label class="layui-form-label"><span style="color: #C9302C;">*</span>Email</label>
									<div class="layui-input-block">
										<input type="text" name="txt_email" id="txt_email" lay-verify="required|email" autocomplete="off" value="${userinfo.getEmail()}" placeholder="123@qq.com" class="layui-input dianhua" >
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label"><span style="color: #C9302C;">*</span>QQ</label>
									<div class="layui-input-block">
										<input type="text" name="txt_qq" id="txt_qq" lay-verify="title|number" autocomplete=" off"value="${userinfo.getQqid()}" placeholder="123" class="layui-input dianhua" >
									</div>
								</div>
								<div style="display: none" class="layui-form-item">
									<label class="layui-form-label"><span style="color: #C9302C;">*</span>Msn</label>
									<div class="layui-input-block">
										<input type="text" name="txt_msn" id="txt_msn" lay-verify="title" autocomplete="off" value="${userinfo.getMsnid()}" placeholder="123******" class="layui-input dianhua" >
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label">电话</label>
									<div class="layui-input-block">
										<input type="text" name="txt_phone" id="txt_phone" value="${userinfo.getOfphone()}"  autocomplete="off" class="layui-input dianhua" placeholder="请按照*区号*固定电话*格式填写">
									</div>
								</div>

								<div class="layui-form-item" style="display: none;">

									<label class="layui-form-label"><span style="color: #C9302C;">*</span>身份</label>
									<div  class="layui-input-block div_usertype">
										<input type="checkbox" name="like" value="摄影师" title="摄影师" checked="">
										<input type="checkbox" name="like" value="设计师" title="设计师" >
										<input type="checkbox" name="like" value="图片爱好者" title="图片爱好者">
									</div>
								</div>
								<div class="layui-form-item" style="display: none;">
									<label class="layui-form-label"><span style="color: #C9302C;">*</span>技能标签</label>
									<div  class="layui-input-block div_userlabel">
										<button type="button" class="layui-btn layui-btn-primary layui-btn-radius" >图片爱好者</button>
										<button type="button" class="layui-btn layui-btn-primary layui-btn-radius" >摄影爱好者</button>
										<button type="button" class="layui-btn layui-btn-primary layui-btn-radius" >其他</button>
									</div>
								</div>

								<div class="layui-form-item">
									<label class="layui-form-label">所在地</label>
									<div class="layui-input-block">

										<input type="text" name="txt_address" id="txt_address" value="${userinfo.getAddress()}" autocomplete="off" class="layui-input dianhua" placeholder="请输入详细住址" >
									</div>

								</div>
								<div class="anniu" style="text-align: center;">
									<button lay-submit="" lay-filter="baseinfo"  class="layui-btn layui-btn-warm baocun">保存</button>
								</div>
							</form>
						</ul>
						<!--账户资料-->
						<ul>
							<form class="layui-form" action="">
								<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
									<legend>已绑定信息</legend>
								</fieldset>
								<div id="div_bdinfo" style="display: inline-block;line-height: 36px;margin-left: 160px;">
								</div>
								<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
									<legend>重置绑定信息</legend>
								</fieldset>
								<div class="layui-form-item" id="div_phone" disabled="disabled">
									<div class="layui-inline">
										<label class="layui-form-label"  style="width: 130px;">手机号&nbsp;:&nbsp;</label>
										<div class="layui-input-inline">
											<input type="text" name="bd_phone" hiddenphone="${userinfo.getTelephone()}" value="" id="bd_phone" lay-verify="title" autocomplete="off" class="layui-input"  placeholder="请输入手机号">
										</div>
									</div>
									<div class="layui-inline" style="margin-left: -20px;">
										<button id="btn_sendsms" type="button" class="layui-btn layui-btn-sm">发送短信</button>
									</div><div class="layui-inline">
									<div class="layui-input-inline">
										<input type="text" name="bd_vercode" id="bd_vercode" lay-verify="title" autocomplete="off" class="layui-input" placeholder="请输入收到验证码">
									</div>
								</div>
								</div>
								<div class="layui-form-item" id="div_bank">
									<label class="layui-form-label"  style="width: 130px;">银行卡号&nbsp;:&nbsp;</label>
									<div class="layui-input-block">
										<input type="text" name="bd_bank" hiddenbank="${userinfo.getBankcode()}" id="bd_bank" lay-verify="title" autocomplete="off" class="layui-input dianhua" placeholder="请输入银行卡号">
									</div>
									</br>
									<label class="layui-form-label" style="width: 130px;">开户银行&nbsp;:&nbsp;</label>
									<div class="layui-input-block">
										<div class="layui-input-inline">
											<select id="sel_bank" name="sel_bank" style="width: 150px;">
												<option value="">请选择银行</option>

											</select>
										</div>
										<input type="text" name="bd_address" hiddenbankAddr="${userinfo.getBankaddr()}" id="bd_address" lay-verify="title" autocomplete="off"
											   class="layui-input dianhua" style="width: 300px;" placeholder="请输入开户行地址">
									</div>
								</div>
								<div class="anniu" style="text-align: center;">
									<button  lay-submit="" lay-filter="bindinfo" class="layui-btn layui-btn-warm baocun">保存</button>
								</div>
							</form>
						</ul>
						<!--认证信息-->
						<ul>
							<form class="layui-form" action="">
								<div class="layui-form-item">
									<label class="layui-form-label" style="width: 130px;">帐号类型&nbsp;:&nbsp;</label>
									<span style="position: absolute;margin-top: 8px;">个人用户</span>
									<%--<button class="layui-btn layui-btn-primary" style="float: right;"><i class="layui-icon"></i>切换认证方式</button>--%>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label" style="width: 130px;">真实姓名&nbsp;:&nbsp;</label>
									<div class="layui-input-block">
										<input type="text" name="zsname" id="zsname" value="${userinfo.getFristname()}" lay-verify="required" autocomplete="off" class="layui-input dianhua" placeholder="请输入您的姓名">
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label" style="width: 130px;">身份证号&nbsp;:&nbsp;</label>
									<div class="layui-input-block">
										<input type="text" name="sfzcode" value="${userinfo.getIccode()}" id="sfzcode" lay-verify="required|identity" autocomplete="off" class="layui-input dianhua" placeholder="请输入您的身份证号">
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label" style="width: 130px;">性别&nbsp;:&nbsp;</label>
									<div class="layui-input-block">
										<input type="radio" name="sex" value="男" title="男" checked="">
										<input type="radio" name="sex" value="女" title="女">
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label" style="width: 130px;">手持身份证正面照&nbsp;:&nbsp;</label>
									<div class="layui-input-block">
										<%--<div class="layui-upload-drag" id="upFile" style="float: left;">--%>
										<%--<i class="layui-icon" style="color: #5FB878;"></i>--%>
										<%--<p>点击上传，或将文件拖拽到此处</p>--%>
										<%--</div>--%>
										<div class="layui-upload" style="float: left;" id="rzFile">
											<button type="button" class="layui-btn" id="upFile">上传图片</button>
											<div class="layui-upload-list">
												<img class="layui-upload-img" style="width: 320px;height: 220px;" src="<%=basePath%>${userinfo.getIdpic()}" id="upImgUrl" >
												<p id="upImgName"></p>
											</div>
										</div>
										<div class="layui-input-block shili">
											<img src="<%=basePath%>/static/images/sfzdemo.png">
											<p style="text-align: center;">示例</p>
										</div>
										<div class="layui-input-block shili1">
											<p>1.请上传本人手持身份证正面上半身免冠照片;</p>
											<p>2.证件信息清晰可见,且不能被遮挡;</p>
											<%--<p>3.仅支持JPG格式,图片大小不能超过5M;</p>--%>
											<%--<p style="color: #EEA236;">详细>></p>--%>
										</div>
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label" style="width: 130px;">身份证到期时间&nbsp;:&nbsp;</label>
									<div class="layui-input-block">
										<input type="text" name="sfzdate" id="sfzdate" value="${userinfo.getSfzdate()}" lay-verify="required|date" autocomplete="off" class="layui-input dianhua">
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label" style="width: 130px;"></label>

									<div class="layui-input-block">
										<input type="checkbox" id="okXy" title="《婚秀协议》" checked="">
									</div>
								</div>
								<div class="anniu" style="text-align: center;">
									<button  lay-submit="" lay-filter="rzinfo" class="layui-btn layui-btn-warm baocun">保存</button>
								</div>
							</form>
						</ul>
						<!--密码修改-->
						<ul>
							<form class="layui-form" action="">
								<div class="layui-form-item">
									<label class="layui-form-label" style="width: 130px;">当前密码&nbsp;:&nbsp;</label>
									<div class="layui-input-block">
										<input type="password" name="oldPw" id="oldPw" lay-verify="required" autocomplete="off" class="layui-input dianhua" placeholder="请输入当前使用的密码">
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label" style="width: 130px;">新密码&nbsp;:&nbsp;</label>
									<div class="layui-input-block">
										<input type="password" name="newPw" id="newPw" lay-verify="required" autocomplete="off" class="layui-input dianhua" placeholder="6-20个字符，注意区分大小写">
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label" style="width: 130px;">确认新密码&nbsp;:&nbsp;</label>
									<div class="layui-input-block">
										<input type="password" name="okPw" id="okPw" lay-verify="required" autocomplete="off" class="layui-input dianhua" placeholder="同前一密码保持一致">
									</div>
								</div>
								<div class="anniu" style="text-align: center;">
									<button  lay-submit="" lay-filter="pwinfo" class="layui-btn layui-btn-warm baocun">保存</button>
								</div>
							</form>
						</ul>
						<!--登录日志-->
						<ul>
							<form class="layui-form" action="">
								<div class="layui-form-item">
									<div class="layui-input-block">
										<div class="layui-input-inline">
											<select id="sel_LogType">
												<option value="1" selected="">会员登录</option>
												<option value="2">绑定修改</option>
												<option value="3">密码修改</option>
											</select>
										</div>
										<div class="layui-inline">
											<label class="layui-form-label">选择日期</label>
											<div class="layui-input-inline" style="width: 175px;">
												<input type="text" name="date1" id="date1" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
											</div>

											<div class="layui-input-inline" style="width: 180px;">
												<!--<span>至</span>-->
												<input type="text" name="date2" id="date2" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
											</div>
											<div class="layui-input-inline" style="width: 175px;">
												<button id="btn_log" class="layui-btn layui-btn-normal layui-btn-radius bangding">查询</button>
											</div>
										</div>
										<div class="layui-form">
											<table class="layui-table" id="log-table" layui-filter="log-table"></table>
										</div>

									</div>

								</div>
							</form>
						</ul>
					</div>
				</div>
			</div><!-- wid925px -->
			<div class="clear"></div>

			<script type="text/javascript">
				jQuery(".tran_con").slide({
					titCell: ".jy_nav li",
					mainCell: ".jy_tab_con",
					trigger: "click"
				})
			</script>
			<script>
				layui.use(['laydate','laypage','form','table','layer','upload','laydate'], function() {
					var laydate = layui.laydate,form = layui.form,upload = layui.upload;
					var $=layui.jquery;
					var layer = layui.layer;
					var table = layui.table;
					var laydate = layui.laydate;
					//常规用法
					laydate.render({
						elem: '#sfzdate'
					});
					//执行一个laydate实例
					laydate.render({
						elem: '#date1' //指定元素
					});
					laydate.render({
						elem: '#date2' //指定元素
					});
					$('.div_userlabel .layui-btn').click(function () {
						if ($(this).is('.layui-btn-primary')) {
							$(this).removeClass('layui-btn-primary');
							$(this).addClass('layui-btn-warm');
						}
						else {
							$(this).addClass('layui-btn-primary');
							$(this).removeClass('layui-btn-warm');
						}
					});
					var imgLogoUrl="${userinfo.getUsrpicurl()}";
					upload.render({
						elem: '#editLogo'
						,url: "<%=basePath%>/persondata/upFileInfo.do"
						//,auto:false,bindAction:'#btn_rzinfo'
						,data:{upFile:'logoimg'}
						,before: function(obj){
							//预读本地文件示例，不支持ie8
							obj.preview(function(index, file, result){
								$('#img_logo').attr('src', result); //图片链接（base64）
							});
						}
						,done: function(res){
							console.log(res)
							imgLogoUrl=res.data;
							//alert(res.data);
						}
						,error:function (obj) {

						}
					});
					form.on('submit(baseinfo)', function(data){

						//获取职业
						var curType="";
						layui.jquery('.div_usertype input[type=checkbox]:checked').each(function() {
							curType +=$(this).val()+",";
						});
						//alert(curType);
						//获取身份标签
						var curLabel="";
						layui.jquery('.div_userlabel .layui-btn-warm').each(function() {
							curLabel +=$(this).text()+",";
						});
						//alert(curLabel);
						$.ajax({
							url: "<%=basePath%>/persondata/userBaseInfo.do",
							type: "POST",
							async:false,
							data: {
								uid:"${userinfo.getUid()}",
								officephone:data.field.txt_phone,
								email:data.field.txt_email,
								imglogo:imgLogoUrl, //头像logo
								address:data.field.txt_address, //地址
								usertype:curType,//身份标签
								userlabel:curLabel,//标签
								nicheng:data.field.txt_nc,
								qqid:data.field.txt_qq,
								msnid:data.field.txt_msn
							},
							success: function (data) {
								if(data=='success'){layer.msg('信息绑定成功!', {icon: 6});}
								else layer.msg(data+'!', {icon: 5});}
						});
						return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
					});
					form.on('submit(rzinfo)', function(data){
						//alert(data.elem.attributes['lay-filter'].nodeValue);
						rzInfo(data);
						return false;
					});
					form.on('submit(pwinfo)', function(data){
						//alert(data.elem.attributes['lay-filter'].nodeValue);
						restPw(data);
						return false;
					});
					form.on('submit(bindinfo)', function(data){
						if(data.field.bd_vercode==""&& data.field.bd_phone == "" &&
								data.field.bd_bank == "" && data.field.bd_address == "" ){
							return false;
						}
						//alert(data.elem.attributes['lay-filter'].nodeValue);
						var curPhone=$('#bd_phone').attr('hiddenphone')==undefined?"":$('#bd_phone').attr('hiddenphone');//绑定手机
						var curbank=$('#bd_bank').attr('hiddenbank')==undefined?"":$('#bd_bank').attr('hiddenbank');
						var curbankaddr="${userinfo.getBankaddr()}";
						//手机号与绑定手机不一样时，需要填写验证码，否则不需要
						if(data.field.bd_phone!="") {
							if (data.field.bd_phone != curPhone) {
								if (data.field.bd_phone == "" || data.field.bd_vercode == "") {
									layer.msg('请填写绑定手机与短信验证码!', {icon: 5});
									return false;
								}
								else if(data.field.bd_vercode ==acceptSms){
									curPhone = data.field.bd_phone;
								}
								else
								{ layer.msg('短信验证码输入错误，请重新填写!', {icon: 5});
									return false;}
							}
						}
						if(data.field.bd_bank!="") {
							if (curbank != data.field.bd_bank) {
								if (data.field.bd_bank == "" || data.field.bd_address == "" ||data.field.sel_bank=="") {
									layer.msg('请完善银行卡信息!', {icon: 5});
									return false;
								}
								else {
									curbankaddr=data.field.bd_address+","+data.field.sel_bank;
									curbank=data.field.bd_bank;
								}
							}
						}
						bindInfo(curPhone,curbank,curbankaddr);
						return false;
					});
					var acceptSms="";
					//手机短信验证
					$('#btn_sendsms').click(function () {

						if($('#bd_phone').val()==""){
							layer.msg("请填写接收短信手机号!");
							return;
						}
						$.ajax({
							url: "<%=basePath%>/general/sendSMSGet.do",
							type: "POST",
							async:false,
							data: {mobile:$('#bd_phone').val()},
							success: function (data) {
								if(data!='000000'){
									layer.msg("短信已发送，注意查收!", {icon: 6});
									acceptSms=data;
									var m=120;
									$('#btn_sendsms').addClass("layui-btn-disabled");
									var showTimeInterval = window.setInterval(function(){
										if(m==0){
											$('#btn_sendsms').removeClass("layui-btn-disabled");
											window.clearInterval(showTimeInterval);
											$('#btn_sendsms').text("发送短信");
										}
										else
											$('#btn_sendsms').text("已发送("+m+"秒)");
										m--;
									},1000);
								}
								else {
									layer.msg('短信发送失败，稍后重试!', {icon: 5});
									acceptSms="";
								}
							}
						});
						return false;
					});
					//绑定信息提交
					function bindInfo (phonev,bankv,bankaddr) {

						$.ajax({
							url: "<%=basePath%>/persondata/userInfoBind.do",
							type: "POST",
							async:false,
							data: {
								uid:"${userinfo.getUid()}",
								phone: phonev,//fdata.field.bd_phone,//phoneCode:fdata.field.bd_vercode,
								//email:"",
								//weibo:"",
								bankcode:bankv,//fdata.field.bd_bank,
								bankaddr:bankaddr//fdata.field.bd_address
							},
							success: function (data) {
								if(data=='success'){layer.msg('信息绑定成功!', {icon: 6});}
								else layer.msg(data+'!', {icon: 5});}
						});
						return false;
					}
					var upFileUrl="${userinfo.getIdpic()}";
					upload.render({
						elem: '#upFile'
						,url: "<%=basePath%>/persondata/upFileInfo.do"
						//,auto:false,bindAction:'#btn_rzinfo'
						,data:{upFile:'sfzPhoto'}
						,before: function(obj){
							//预读本地文件示例，不支持ie8
							obj.preview(function(index, file, result){
								$('#upImgUrl').attr('src', result); //图片链接（base64）
								$('#upImgUrl').attr('style', "width: 320px;height: 220px;"); //图片链接（base64）
								$('#upImgName').text(file.name);
							});
						}
						,done: function(res){
							console.log(res)
							upFileUrl=res.data;
							//alert(res.data);
						}
						,error:function (obj) {
							upFileUrl="";
						}
					});
					//认证信息保存
					function rzInfo (data) {
						if(window.FormData) {
							//验证信息是否填写 真实姓名  身证号  身证有效日期 协议是否阅读
							if($('#zsname').val()==""){
								layer.msg("请输入真实姓名!",{icon: 5})
								return false;
							}
							if($('#sfzcode').val()==""){
								layer.msg("请输入有效身份证号!",{icon: 5})
								return false;
							}
							if($('#sfzdate').val()==""){
								layer.msg("请输入身份证有效日期!",{icon: 5})
								return false;
							}
							// 验证文件是否上传
							if(upFileUrl==""){//$('#rzFile .layui-upload-file')[0].files.length<=0
								layer.msg("请选择上传的身份证正面照片!",{icon: 5})
								return false;
							}
							var formData = new FormData();
							// 建立一个upload表单项，值为上传的文件
							formData.append('upload', upFileUrl);//$('#rzFile .layui-upload-file')[0].files[0]
							formData.append('zsname', $('#zsname').val());
							formData.append('sfzcode', $('#sfzcode').val());
							formData.append('sex',  $('#sex').val());
							formData.append('sfzdate',$('#sfzdate').val());
							formData.append('uid', "${userinfo.getUid()}");
							$.ajax({
								type: "POST",
								url: "<%=basePath%>/persondata/userSfzUp.do",
								data: formData,
								contentType: false,
								processData: false,
								success: function (data) {
									if(data =="success"){
										layer.msg("认证信息保存成功", {icon: 6});
									}else{
										layer.msg(data+"!", {icon: 5});
									}
								}
							});
						}
						else
							layer.msg("请更换浏览器，当前浏览器不支持文件上传!!");
						return false;
					}
					//密码重置
					function restPw(data) {
						var oldpw = $('#oldPw').val();
						var newpw = $('#newPw').val();
						var okpw = $('#okPw').val();
						if(newpw.length<6){
							layer.msg('密码长度最少为6个字符', {icon: 5});
							return;
						}
						if(newpw!=okpw){
							layer.msg('新密码两次输入不一致,请重新输入!', {icon: 5});
							return;
						}
						$.ajax({
							url: "<%=basePath%>/persondata/restPassword.do",
							type: "POST",
							async:false,
							data: {
								uid:"${userinfo.getUid()}",
								newPassword:newpw,
								oldPassword:oldpw
							},
							success: function (data) {
								if(data=='success'){
									layer.msg('密码重置成功!', {icon: 6});
								}
								else
									layer.msg(data+'!', {icon: 5});
							}
						});
						return false;
					}
					//日志查询
					$('#btn_log').click(function () {

						logTable.reload({
							url:'<%=basePath%>/persondata/getUserOperatLog.do'
							,where:{
								uid:"${userinfo.getUid()}",
								logType:$('#sel_LogType').val()
								,logStime:$('#date1').val()
								,logEtime:$('#date2').val()
							}
							,page:{
								curr: 1 //重新从第 1 页开始
							}
						});
						return false;
					})
					var logTable = table.render({
						elem: '#log-table'
						,url:'<%=basePath%>/persondata/getUserOperatLog.do?uid=${userinfo.getUid()}'
						,page: {
							layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
							,groups: 3 //只显示 1 个连续页码
							,first: true //不显示首页
							,last: true //不显示尾页
						}
						,cols: [[
							{field:'logtime', width:180, title: '登录时间', sort: true}
							,{field:'ipaddress', width:150, title: '登录IP'}
							,{field:'loginfo', width:400, title: '消息内容',align:'center'}
						]]

					})
				})
			</script>
		</div><!-- memder_con -->
	</div><!-- wrap -->
</div><!-- bg_f5 -->
<!-- 公共底部 -->
<footer>
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
			<dl >
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
