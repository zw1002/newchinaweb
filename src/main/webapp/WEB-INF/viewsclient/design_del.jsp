<%@ page language="java" pageEncoding="UTF-8"
         contentType="text/html;charset=UTF-8" %>
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
<link rel="stylesheet"  href="<%=basePath%>/static/css/fsgallery.css" media="all" />
<script type="text/javascript" src="<%=basePath%>/static/js/jquery1.42.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/jquery.SuperSlide.2.1.1.js"></script>
    <style>
        video::-internal-media-controls-download-button {
            display:none;
        }
        video::-webkit-media-controls-enclosure {
            overflow:hidden;
        }
        video::-webkit-media-controls-panel {
            width: calc(100% + 30px);
        }
        .layui-circle {
            width: 80px;
            height: 80px;
            border-radius: 100%;
        }

        .touxiang {
            float: left;
        }

        .pinglun {
            float: left;
            position: relative;
            margin-left: 20px;
            width: 1060px;
        }

        .yonghu {
            font-weight: bold;
            color: #666;
        }

        .neirong {
            margin-top: 20px;
        }

        .shijian {
            float: right;
            font-size: 12px;
            color: #a7a7a7;
        }

        .pingjia {
            width: 100%;
            height: 100px;
            border-bottom: 1px solid #e4e4e4;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<!--获取作品ID-->
<input id="uid" name="uid" type="hidden" value="<%= request.getAttribute("uid")%>"/>
<input id="merchid" name="merchid" type="hidden"/>
<script type="text/javascript">
    var uid=$("#uid").val();
    var userid;
    $(document).ready(function () {
        //隐藏注册/按钮登录    显示个人中心/个人空间
        var firstname="${userinfo.getFristname()}";
        if(firstname != ""){
            $("#beferLogin").css("display","none");
            $("#backLogin").css("display","block");
        }
        //获取作品信息
        getDisginDel();
        //感兴趣
        interested();
        //会员作品推荐
        getUserInfoWorks();
        $('.ss_btn').click(function () {
            document.location.href = '<%=basePath%>/seachs/toSeachs.do?seachTxt='+$('.inp_txt').val();
        });
        //取消整个页面的右击事件
        document.oncontextmenu = function(){
            return false;
        }
        getLeavelmsg();
    });
    function getDisginDel(){
        //作品ID
        var uid=$("#uid").val();
        $.ajax({
            url: "<%=basePath%>/general/getWorkDetails.do",
            type: "POST",
            async:false,
            data:{
                uid:uid
            },
            success: function (data) {
                var msg = eval("(" + data + ")");
                if(msg.workstype.substring(0,1) == 0){//设计
                    $("#deisgn").attr("class","active");
                    var str="<li> <a style='height:720px' href='<%=basePath%>"+msg.watermakeurl+"' title='点击查看大图' alt=''target='_blank'><img src='<%=basePath%>"+msg.watermakeurl+"' /></a></li>";
                }else if(msg.workstype.substring(0,1) == 1) {//摄影
                    $("#photo").attr("class","active");
                    var str="<li> <a style='height:720px' href='<%=basePath%>"+msg.watermakeurl+"' title='点击查看大图' alt=''target='_blank'><img src='<%=basePath%>"+msg.watermakeurl+"' /></a></li>";
                }else if(msg.workstype.substring(0,1) == 2) {//道具
                    $("#prop").attr("class","active");
                    var str="<li> <a style='height:720px' href='<%=basePath%>"+msg.watermakeurl+"' title='点击查看大图' alt=''target='_blank'><img src='<%=basePath%>"+msg.watermakeurl+"' /></a></li>";
                }else if(msg.workstype.substring(0,1) == 3) {//婚秀
                    $("#wedding").attr("class","active");
                    if(msg.watermakeurl == undefined){
                        var str="<div class='video_box'><video id='video' width='100%' height='720'  src='<%=basePath%>"+msg.worksurl+"' poster='' controls></video></div>";
                        setInterval("refershVideo()", 10000); //每隔10秒刷新点击量
                    }else{
                        var str="<li> <a style='height:720px' href='<%=basePath%>"+msg.watermakeurl+"' title='点击查看大图' alt=''target='_blank'><img src='<%=basePath%>"+msg.watermakeurl+"' /></a></li>";
                    }
                }else{//免费
                    $("#free").attr("class","active");
                    var str="<li> <a style='height:720px' href='<%=basePath%>"+msg.watermakeurl+"' title='点击查看大图' alt=''target='_blank'><img src='<%=basePath%>"+msg.watermakeurl+"' /></a></li>";
                }
                $("#gallery ul").append(str);
                $("#title").text(msg.worksname);
                var stt='<tr> <td width="50"><div class="tx_img"><img style="width:45px" src="<%=basePath%>'+msg.picurl+'" /></div></td>'
                        +'<td> <a href="#" id='+msg.uid+'>'+msg.merchname+'</a>'+msg.grade+' <img src="<%=basePath%>/static/images/icon_dj.png" height="15" width="22" />'
                        +'<p>交易：'+msg.count+' &nbsp; &nbsp;|&nbsp; &nbsp;作品数量：'+msg.workcount+'</p> </td> </tr>';
                $("#merchMessage").append(stt);
                $("#downCount").text("下载量:"+msg.downcount);
                $("#favcount").text("收藏量:"+msg.favcount);
                $("#imgformart").text("格式:"+msg.imgformart);
                $("#imgsize").text("大小:"+msg.imgsize);
                $("#dpinum").text("分辨率:"+msg.dpinum);
                $("#uptime").text("发布时间:"+msg.uptime);
                $("#price").text(msg.price+"元");
                $("#merchid").val(msg.merchid);
                userid=msg.userid;
            }
        });
    }
    //初始化视频
    function refershVideo(){
        var myVideo = document.getElementById('video');
        myVideo.currentTime = 0;    //属性设置或返回音频/视频播放的当前位置（以秒计）。当设置该属性时，播放会跳跃到指定的位置。
        myVideo.pause();
    }
    //感兴趣推荐
    function interested(){
        var type="00";
        var count=6;
        $.ajax({
            url: "<%=basePath%>/general/getRecommendWorks.do",
            type: "POST",
            async: false,
            data: {
                type:type,
                count: count
            },
            success: function (data) {
                var msg = eval("(" + data + ")");
                var str="";
                for(var i=0;i<msg.length;i++) {
                    str += "<li><a href='#' onclick='toDesignDel(" + msg[i].uid + ")'><img src='<%=basePath%>" + msg[i].samllurl + "'/>"
                            + "<div class='botm_txtd'><p>" + msg[i].worksname + "</p> </div> </a></li>";
                }
                $("#interested").append(str);
            }
        });
    }
    //会员作品推荐
    function getUserInfoWorks(){
        var count=2;
        var merchId=$("#merchid").val();
        $.ajax({
            url: "<%=basePath%>/general/getUserInfoWorks.do",
            type: "POST",
            async: false,
            data: {
                count: count,
                merchId: merchId
            },
            success: function (data) {
                var msg = eval("(" + data + ")");
                var str="";
                for(var i=0;i<msg.length;i++) {
                    str += "<li><a href='#' onclick='toDesignDel(" + msg[i].uid + ")'><img src='<%=basePath%>" + msg[i].samllurl + "'/>"
                            + "<div class='botm_txtd'><p>" + msg[i].worksname + "</p> </div> </a></li>";
                }
                $("#userInfoWorks").append(str);
            }
        });
    }
    //跳转到注册页面
    function toRegister(){
        document.location.href = '<%=basePath%>/signin/register.do';
    }
    //跳转到登录页面
    function toLogin(){
        document.location.href = '<%=basePath%>/signin/login.do';
    }
    //跳转到首页
    function toIndex(){
        document.location.href = '<%=basePath%>/signin/index.do';
    }
    //跳转到设计页面
    function toDesign(){
        document.location.href = '<%=basePath%>/design/toDesign.do';
    }
    //跳转到设计页面
    function toDesignDel(uid){
        document.location.href = '<%=basePath%>/design/toDesignDel.do?uid='+uid;
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
    //跳转到会员中心页面
    function toMember(){
        document.location.href = '<%=basePath%>/member/toMember.do';
    }
    //跳转到会员空间页面
    function toHomepage(){
        var uid="${userinfo.getUid()}";
        document.location.href = '<%=basePath%>/homepage/toHomepage.do?uid='+uid;
    }
    //跳转到店铺页面
    function toUserHomepage(){
        document.location.href = '<%=basePath%>/homepage/toHomepage.do?uid='+userid;
    }
    //收藏店铺
    function addFocusOthers(){
        var firstname="${userinfo.getFristname()}";
        if(firstname != ""){
            var focus=document.getElementById("focus").innerText;
            if(focus.indexOf("收藏店铺") != -1){
                var focus_merchid=$("#merchid").val();
                var flag="2";
                $.ajax({
                    url: "<%=basePath%>/homepage/addFocusOthers.do",
                    type: "POST",
                    data: {
                        flag:flag,
                        focus_userid: userid,
                        focus_merchid: focus_merchid
                    },
                    success: function (data) {
                        if(data!=="failed"){
                            alert("收藏成功");
                            $("#focus").text("已收藏");
                        }else{
                            alert("收藏失败");
                        }
                    }
                });
            }else{
                alert("已收藏");
            }
        }else{
            document.location.href = '<%=basePath%>/signin/login.do';
        }
    }
    //添加作品到购物车
    function addShopCar(){
        var firstname="${userinfo.getFristname()}";
        if(firstname != ""){
            $.ajax({
                url: "<%=basePath%>/pay/addShopCar.do",
                type: "POST",
                data: {
                    uid: uid
                },
                success: function (data) {
                    if(data!=="failed"){
                        document.location.href = '<%=basePath%>/pay/toCar.do';
                    }else{
                        alert("添加作品失败");
                    }
                }
            });
        }else{
            document.location.href = '<%=basePath%>/signin/login.do';
        }
    }
    //获取作品评论
    function getLeavelmsg(){
        var uid=$("#uid").val();
        $.ajax({
            url: "<%=basePath%>/member/getLeaveMsg.do",
            type: "POST",
            data: {
                uid: uid
            },
            success: function (data) {
                var msg=eval("("+data+")");
                var str="";
                for(var i=0;i<msg.length;i++) {
                    str += '<div class="pingjia"> <div class="layui-inline touxiang">'
                    +'<img src="<%=basePath%>'+msg[0].userpicurl+'" class="layui-circle">'
                    +'</div> <div class="layui-inline pinglun"> <span class="yonghu">'+msg[0].username+'</span>'
                    +'<span class="shijian">'+msg[0].time+'</span> <p class="neirong">'+msg[0].content+'</p></div></div>';
                }
                $("#leavmsg").append(str);
            }
        });
    }
</script>
   <header>
     <div class="top">
      <div class="top_line">
         <div class="top_wid">
            欢迎来到婚秀中国网
             <!-- 登录前 -->
             <div id="beferLogin" class="top_pos">
                 <a href="#" onclick="toLogin()">登录</a>|<a href="#" onclick="toRegister()">注册</a>
             </div>
             <!-- 登录后 -->
             <div id="backLogin" class="top_pos" style="display:none;">
                 <a href="#" onclick="toMember()">会员中心</a>|<a href="#" onclick="toHomepage()">会员空间</a>|<a href="<%=basePath%>/pay/toCar.do">购物车</a>
                 <!--<a href="pay.html" class="vip_lj">成为VIP</a>|<a href="upload.html" class="sc_icon">我要上传</a>|<a href="collection_2.html">我的收藏（<span class="col_f00">2</span>）</a>-->
             </div>
         </div>
      </div><!-- top_line -->
      <div class="top_wid logo_con">
         <a href="#" onclick="toIndex()" class="fl"><img src="<%=basePath%>/static/images/logo.png" height="62" width="217" /></a>
         <div class="ss_bg fl">
            <input name="" type="text" placeholder="请输入搜索内容"  class="inp_txt">
            <input type="submit" value="搜 索" class="ss_btn" /> 
         </div>
         <div class="phone_fr">
            <h2>400-879-51747</h2>
            <p>24小时服务热线</p>
         </div>
      </div><!-- top_wid -->
      <div class="nav">
          <ul class="clearfix">
              <li><a href="#" onclick="toIndex()">首 页 </a> <p class="point_d"></p></li>
              <li><a id="deisgn" href="#" onclick="toDesign()">设 计</a> <p class="point_d"></p></li>
              <li><a id="photo" href="#" onclick="toPhotography()">摄影图库</a> <p class="point_d"></p></li>
              <li><a id="prop" href="#" onclick="toMultimedia()">道具新品</a> <p class="point_d"></p></li>
              <li><a id="wedding" href="#" onclick="toWedding()">婚 秀</a> <p class="point_d"></p></li>
              <li><a href="#" onclick="toHelp()">求图求助</a> <p class="point_d"></p></li>
              <li><a id="free" href="#" onclick="toFree()">免费下载</a> <p class="point_d"></p></li>
          </ul>
      </div><!-- nav -->
      </div><!-- top -->
   </header>
   <div class="bg_f5">
     <div class="wrap">
     <div class="mbx_box"><a  href="index.jsp">首页</a> > <a href="javascript:">设 计</a> > </div>
     <div class="wed_del">
       <div class="wid780px fl">
         <div class="del_txt">
           <h2 id="title"></h2></a>
         </div>
         <div class="gallery" >
            <div class="turn_pic2">
                <div class="bd" id="gallery">
                    <ul>
                    </ul>
                </div>
            </div>

            <div class="botm_js">
              婚秀中国网正版图库 &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp;
              <a href="javascript:" class="jb_icon">举报</a>
            </div>
         </div>
       </div><!-- wid780px -->
       <div class="wid400px fr">
         <div class="ty_box">
             <div class="xx_tabd">
               <table width="100%" id="merchMessage">

               </table>
                <div class="dp_boxd"><a id="focus" href="#" onclick="addFocusOthers()">收藏店铺</a> <a href="#" onclick="toUserHomepage()">进入店铺</a></div>
             </div>
             <h2>婚庆场景设计模板</h2>
             <p><span class="col_f00">[原创设计]</span> AI矢量图，可任意设置精度，拉大，可做喷绘，写真，内送PSD分层文件放心下载</p>
             <div class="jg_ttx">
              价格：<b id="price" class="col_f00"></b>  <a href="javascript:" class="sh_pos">贴心售后></a>
             </div> 
             <div class="buy_btn">
               <a class="fl" href="#" onclick="addShopCar()">我要购买</a>
               <a href="javascript:" class="wydz fr"><img src="<%=basePath%>/static/images/icon_dz.png" /> 我要定制</a>
             </div>
             <p class="small_txt"><span class="yzx_icon" id="downCount"></span><span class="ll_icon">浏览：8454</span><span class="sc_icon" id="favcount"></span></p>
         </div><!-- ty_box -->
         <div class="ty_box">
              <div class="jj_tabd">
                <table width="100%">
                   <tr>
                      <td id="imgformart"></td>
                      <td id="dpinum"></td>
                   </tr>
                   <tr>
                      <td id="imgsize"></td>
                       <td  colspan="2" id="uptime"></td>
                   </tr>
                   <tr>
                      <!--<td  colspan="2"><p class="fl">分享到：</p>
                      <div class="bdsharebuttonbox fl"><a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a></div>
<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"16"},"share":{},"selectShare":{"bdContainerClass":null,"bdSelectMiniList":["weixin","qzone","tsina","tqq","renren"]}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];
</script>   
                      </td>-->
                   </tr>
                </table>
              </div> 
         </div><!-- ty_box -->
         <div class="ty_box">
             <div class="tit_zptj"><h2>会员作品推荐</h2></div>
             <div class="zp_tj da_img">
              <ul class="clearfix" id="userInfoWorks">
               </ul>
             </div> 
         </div><!-- ty_box -->
       </div><!-- wid400px -->
       <div class="clear"></div>
     </div><!-- wed_del -->
     <div class="gxq_box da_img">
        <div class="gxq_tit"><h2>您可能还感兴趣的</h2></div>
        <ul class="clearfix" id="interested">
           </ul>
     </div>
         <div class="gxq_box da_img" style="height:400px;overflow:auto;">
             <div class="gxq_tit">
                 <h2>作品评价</h2>
             </div>
             <form id="leavmsg" class="layui-form" action="">

             </form>
         </div>
         <p class="sm_txt">【声明】婚秀中国网是正版商业图库，所有原创作品（含预览图）均受著作权 发保护，著作权及相关权利归上传用户所有，未经许可任何人不得擅自使用，否则将依法处理</p>
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
