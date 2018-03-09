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
<script type="text/javascript" src="<%=basePath%>/static/js/jquery1.42.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/jquery.SuperSlide.2.1.1.js"></script>
<!--校验-->
<script type="text/javascript" src="<%=basePath%>/static/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/jquery.validate.min.js"></script>
<!--消息提醒-->
    <script src="<%=basePath%>/static/js/jquery.noty.packaged.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/showinfo.js"></script>
</head>
<body>
<input type="hidden" id="saveSMS"/>
   <header>
     <div class="top">    
      <div class="top_wid logo_con">
         <a href="index.do" class="fl"><img src="<%=basePath%>/static/images/logo.png" height="62" width="217" /></a>
         <h2 class="titddd fl">新用户注册</h2>
      </div><!-- top_wid -->
      </div><!-- top -->
   </header>
   <div class="bg_f5 pad_topd">
     <div class="login_wid">
        <div class="wid470px">
           <div class="reg_nav">
              <ul class="">
                 <li class="on">普通注册</li>
                 <li>手机快速注册</li>
                 <div class="clear"></div>
              </ul>
           </div>
           <div class="regist_con">
               <ul>
                   <form id="userform" method="post" action="">
                   <div class="login_box">
                      <ul>
                          <!--
                          <li style="height:24px; padding:0 15px;">
                           <table width="100%">
                              <tr>
                                 <td><input name="aa" type="radio" class="fx_wid" value="" checked>&nbsp; &nbsp;设计师 </td>
                                 <td><input name="aa" type="radio" class="fx_wid" value="">&nbsp; &nbsp;摄影师   </td>
                                 <td width="24%"><input name="aa" type="radio" class="fx_wid" value="">&nbsp; &nbsp;婚秀达人 </td>
                              </tr>
                           </table>                        
                          </li>
                          -->
                          <li><div class="inp_bg"><input id="fristname" name="fristname" type="text" placeholder="用户名"></div></li>
                          <li><div class="inp_bg"><input id="account" name="account" type="text" placeholder="账号"></div></li>
                          <li><div class="inp_bg"><input id="password" name="password"  type="password" placeholder="密码"></div></li>
                          <li><div class="inp_bg"><input id="passwords" name="passwords" type="password" placeholder="重复密码"></div></li>
                          <li><div class="inp_bg"><input id="qqid" name="qqid" type="text" placeholder="QQ"></div></li>
                          <!--
                          <li><div class="inp_bg"><input name="" type="text" placeholder="邮箱"></div></li>
                          <li><div class="inp_bg"><input name="" type="text"  placeholder="QQ"></div></li>
                          <li><div class="inp_bg" style="width:55%;"><input name="" type="text" placeholder="手机验证码"></div>
                          <a href="javascript:" class="yzm_btn">获取验证码</a>
                          </li>
                          -->
                          <input name="bb" id="bb" type="checkbox" class="fx_wid" value="">阅读并同意《婚秀中国网服务协议》《委托代收付款协议》
                          <input type="submit" id="ordinaryregister" value="注册并登录" class="login_btn" />
                      </ul>
                   </div>
                </form>
               </ul>
               <ul>
                   <form id="userforms" method="post" action="">
                   <div class="login_box">
                      <ul>
                          <li><div class="inp_bg"><input name="fristname1" id="fristname1" type="text" placeholder="用户名"></div></li>
                          <li><div class="inp_bg"><input name="account1" id="account1" type="text" placeholder="手机号"></div></li>
                          <li><div class="inp_bg"><input id="password1" name="password1"  type="password" placeholder="密码"></div></li>
                          <li><div class="inp_bg"><input id="password2" name="password2" type="password" placeholder="重复密码"></div></li>
                          <li><div class="inp_bg"><input id="qqid1" name="qqid1" type="text" placeholder="QQ"></div></li>
                          <li><div class="inp_bg" style="width:55%;"><input name="mobile" id="mobile" type="text" placeholder="手机验证码"></div>
                          <a href="#" onclick="getSMS()" class="yzm_btn">获取验证码</a>
                          </li>
                          <input name="bb" id="cc" type="checkbox" class="fx_wid" value="" checked>阅读并同意《婚秀中国网服务协议》《委托代收付款协议》
                          <input type="submit" id="submitBtns" value="注册并登录" class="login_btn" />
                      </ul>
                   </div>
                   </form>
               </ul>
           </div><!-- wid470px -->
            <p class="login_lj">已拥有账号？去<a href="#" onclick="toLogin()">登录</a></p>
                <div class="ffl_txt"><p>其他账户登录</p></div>
                <div class="other_img">
                   <ul >
                      <li><a href="javascript:"><img src="<%=basePath%>/static/images/share_icon1.png" /></a></li>
                      <li><a href="javascript:"><img src="<%=basePath%>/static/images/share_icon2.png" /></a></li>
                      <li><a href="javascript:"><img src="<%=basePath%>/static/images/share_icon3.png" /></a></li>
                      <div class="clear"></div>
                   </ul>
                </div>
        </div><!-- wid470px -->
<script type="text/javascript">
    jQuery(".wid470px").slide({titCell:".reg_nav li",mainCell:".regist_con", trigger:"click"});
    $(document).ready(function () {
        //校验
        var validate = $("#userform").validate({
            debug: true, //调试模式取消submit的默认提交功能
            //errorClass: "label.error", //默认为错误的样式类为：error
            focusInvalid: false, //当为false时，验证无效时，没有焦点响应
            onkeyup: false,
            submitHandler: function(){   //表单提交句柄,为一回调函数，带一个参数：form
                ordinarySubmit();
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
        //校验
        var validate = $("#userforms").validate({
            debug: true, //调试模式取消submit的默认提交功能
            //errorClass: "label.error", //默认为错误的样式类为：error
            focusInvalid: false, //当为false时，验证无效时，没有焦点响应
            onkeyup: false,
            submitHandler: function(){   //表单提交句柄,为一回调函数，带一个参数：form
                ordinarySubmits();
            },
            rules:{
                fristname1:{
                    required:true
                },
                account1:{
                    required:true,
                    remote: {
                        url: "<%=basePath%>/signin/checkAccount.do",     //后台处理程序
                        type: "post",               //数据发送方式
                        dataType: "json",           //接受数据格式
                        data: {                     //要传递的数据
                            account: function() {
                                return $("#account1").val();
                            }
                        }
                    }
                },
                password1:{
                    required:true
                },
                password2:{
                    equalTo:"#password1"
                }
            },
            messages:{
                fristname1:{
                    required:"*必填"
                },
                account1:{
                    required:"*必填",
                    remote:"*账号已注册"
                },
                password1:{
                    required: "*不能为空"
                },
                passwords2:{
                    equalTo:"*密码不一致"
                }
            }
        });
        $("#fristname1").focus();//添加焦点
    });
    //获取手机验证码
    function getSMS(){
        var mobile=$("#account1").val();
        $.ajax({
            url:"<%=basePath%>/general/sendSMSGet.do",
            type:"POST",
            data:{
                mobile:mobile
            },
            success:function(data){
                if(data != 000000){
                    $("#saveSMS").val(data);
                }else{
                    alert("获取验证码失败");
                }
            }
        });
    }
    //普通注册提交
    function ordinarySubmit(){
        var result=$("input[id='bb']").is(':checked');
        if(result){
            $("#ordinaryregister").attr("disabled",true);
            var fristname=$("#fristname").val();
            var account=$("#account").val();
            var password=$("#password").val();
            var qqid=$("#qqid").val();
            var flag=1;
            $.ajax({
                url:"<%=basePath%>/signin/registerSubmit.do",
                type:"POST",
                data:{
                    fristname:fristname,
                    account:account,
                    password:password,
                    qqid:qqid,
                    flag:flag
                },
                success:function(data){
                    if(data!=="failed"){
                        successInfo("注册成功，三秒后跳转到登录页面");
                        setTimeout("toLogin()","3000");  //3000毫秒后执行函数，只执行一次。
                    }else{
                        errorInfo("注册失败");
                    }
                }
            });
        }else{
            alert("请同意婚秀中国网服务协议");
        }
    }
    //快捷注册提交
    function ordinarySubmits(){
        var mobile=$("#mobile").val();
        var saveSMS=$("#saveSMS").val();
        if(mobile == saveSMS){
            var result=$("input[id='cc']").is(':checked');
            if(result){
                $("#submitBtns").attr("disabled",true);
                var fristname=$("#fristname1").val();
                var account=$("#account1").val();
                var password=$("#password2").val();
                var qqid=$("#qqid1").val();
                var flag=2;
                $.ajax({
                    url:"<%=basePath%>/signin/registerSubmit.do",
                    type:"POST",
                    data:{
                        fristname:fristname,
                        account:account,
                        password:password,
                        qqid:qqid,
                        flag:flag
                    },
                    success:function(data){
                        if(data!=="failed"){
                            successInfo("注册成功，三秒后跳转到登录页面");
                            setTimeout("toLogin()","3000");  //3000毫秒后执行函数，只执行一次。
                        }else{
                            errorInfo("注册失败");
                        }
                    }
                });
            }else{
                alert("请同意婚秀中国网服务协议");
            }
        }else{
            alert("手机验证码错误");
        }
    }
    //跳转到登录页面
    function toLogin(){
        document.location.href = '<%=basePath%>/signin/login.do';
    }
</script>
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
