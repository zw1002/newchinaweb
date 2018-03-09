<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title></title>
		<link href="<%=basePath%>/static/css/mui.min.css" rel="stylesheet" />
		<link href="<%=basePath%>/static/css/styles.css" rel="stylesheet" />
		<link href="<%=basePath%>/static/css/icons-extra.css" rel="stylesheet" />
		<link href="<%=basePath%>/static/css/global.css" rel="stylesheet" type="text/css" />
		<link href="<%=basePath%>/static/css/index.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=basePath%>/static/js/jquery1.42.min.js"></script>
		<!--校验-->
		<script type="text/javascript" src="<%=basePath%>/static/js/jquery.validate.js"></script>
		<script type="text/javascript" src="<%=basePath%>/static/js/jquery.validate.min.js"></script>
		<!--消息提醒-->
		<script src="<%=basePath%>/static/js/jquery.noty.packaged.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>/static/js/showinfo.js"></script>
	</head>
	<body>
	<script type="text/javascript">
		$(document).ready(function () {
			//校验
			var validate = $("#userform").validate({
				debug: true, //调试模式取消submit的默认提交功能
				//errorClass: "label.error", //默认为错误的样式类为：error
				focusInvalid: false, //当为false时，验证无效时，没有焦点响应
				onkeyup: false,
				submitHandler: function(){   //表单提交句柄,为一回调函数，带一个参数：form
					register();
				},
				rules:{
					fristname:{
						required:true
					},
					account:{
						required:true,
						remote: {
							url: "<%=basePath%>/signin/checkAccount.do",     //后台处理程序
							type: "post",               //数据发送方式
							dataType: "json",           //接受数据格式
							data: {                     //要传递的数据
								account: function() {
									return $("#account").val();
								}
							}
						}
					},
					password:{
						required:true
					},
					passwords:{
						equalTo:"#password"
					}
				},
				messages:{
					fristname:{
						required:"*必填"
					},
					account:{
						required:"*必填",
						remote:"*账号已注册"
					},
					password:{
						required: "*不能为空"
					},
					passwords:{
						equalTo:"*密码不一致"
					}
				}
			});
			$("#fristname").focus();//添加焦点
		});
	function register(){
		var fristname=$("#fristname").val();
		var account=$("#account").val();
		var password=$("#password").val();
		var usercode=$("#usercode").val();
		$.ajax({
			url:"<%=basePath%>/general/recommenRegisterSubmit.do",
			type:"POST",
			data:{
				fristname:fristname,
				account:account,
				password:password,
				usercode:usercode
			},
			success:function(data){
				if(data!=="failed"){
					successInfo("注册成功，请去网页版登录!");
					$("#subbutton").css("display","none");
				}else{
					errorInfo("注册失败");
				}
			}
		})
	}
	</script>
		<div class="zhanghu"><img src="<%=basePath%>/static/images/logo.png"></div>
		<form id="userform" class="mui-input-group">
			<div class="mui-input-row">
				<label><span class="mui-icon mui-icon-person"></span></label>
				<input id="fristname" name="fristname" type="text" class="mui-input-clear mui-input" placeholder="请输入用户名" data-input-clear="3"><span class="mui-icon mui-icon-clear mui-hidden"></span>
			</div>
			<div class="mui-input-row">
				<label><span style=" margin-top:-4px;color: #e94653;margin-top: -4px;" class="mui-icon-extra mui-icon-extra-xiaoshuo"></span></label>
				<input id="account" name="account" type="text" class="mui-input-clear mui-input" placeholder="请输入账号" data-input-clear="2"><span class="mui-icon mui-icon-clear mui-hidden"></span>
			</div>

			<div class="mui-input-row">
				<label><span class="mui-icon mui-icon-locked"></span></label>
				<input id="password" name="password" type="password" class="mui-input-clear mui-input" placeholder="请输入密码" data-input-clear="3"><span class="mui-icon mui-icon-clear mui-hidden"></span>
			</div>

			<div class="mui-input-row">
				<label><span class="mui-icon mui-icon-locked"></span></label>
				<input id="passwords" name="passwords" type="password" class="mui-input-clear mui-input" placeholder="请再次输入密码" data-input-clear="3"><span class="mui-icon mui-icon-clear mui-hidden"></span>
			</div>

			<div class="mui-input-row">
				<label><span style="font-size: 22px;color: #e94653;" class="mui-icon-extra mui-icon-extra-share"></span></label>
				<input id="usercode" name="usercode" readonly type="text" class="mui-input-clear mui-input" value="<%= request.getAttribute("usercode")%>" data-input-clear="3"><span class="mui-icon mui-icon-clear mui-hidden"></span>
			</div>
			<input id="subbutton" type="submit" value="注册并登录" class="login_btn" />
		</form>
	</body>
</html>