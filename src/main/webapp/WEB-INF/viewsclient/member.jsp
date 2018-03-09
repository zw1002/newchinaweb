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
<link rel="stylesheet"  href="<%=basePath%>/static/css/fsgallery.css" media="all" />
<script type="text/javascript" src="<%=basePath%>/static/js/jquery1.42.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/jquery.SuperSlide.2.1.1.js"></script>
<script type="text/javascript">
    //会员ID
    var userInfoId="${userinfo.getUid()}";
 $(function(){
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
 });
 $(document).ready(function () {
     //修改通知的宽度
    $(".tempWrap").css("width","694");
     getUserMerch();
     getPersonWorksViews();
     getTransaction();
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
    //获取个人浏览记录
    function getPersonWorksViews(){
        var count=4;
        $.ajax({
            url: "<%=basePath%>/personalcenter/getPersonWorksViews.do",
            type: "POST",
            data:{
              count:count
            },
            success: function (data) {
                var msg = eval("(" + data + ")");
                var str="";
                for(var i=0;i<msg.length;i++){
                    if(msg[i].workstype.substring(0,1) == 3) {//婚秀
                        if(msg[i].worksamllurl == ""){
                            str += '<li><a href="<%=basePath%>/design/toDesignDel.do?uid='+msg[i].workid+'"><div class="video_box"><video width="100%" height="280"  src="<%=basePath%>'+msg[i].workurl+'" poster=""></video></div>'
                                    +'<div class="botm_txtd"> <p>'+msg[i].workname+'</p> </div> </a></li>';
                        }else{
                            str += '<li><a href="<%=basePath%>/design/toDesignDel.do?uid='+msg[i].workid+'"><img src="<%=basePath%>'+msg[i].worksamllurl+'" />'
                                    +'<div class="botm_txtd"> <p>'+msg[i].workname+'</p> </div> </a></li>';
                        }
                    }else{
                        str += '<li><a href="<%=basePath%>/design/toDesignDel.do?uid='+msg[i].workid+'"><img src="<%=basePath%>'+msg[i].worksamllurl+'" />'
                        +'<div class="botm_txtd"> <p>'+msg[i].workname+'</p> </div> </a></li>';
                    }
                }
                $("#workview").append(str);
            }
        });
    }
    //交易动态
    function getTransaction(){
        $("#transaction").html("");
        var count=4;
        var uid="${userinfo.getUid()}";
        $.ajax({
            url:"<%=basePath%>/index/getTransaction.do",
            type:"POST",
            data:{
              count:count,
                uid:uid
            },
            success:function(data){
                var msg=eval("("+data+")");
                var str="";
                for(var i=0;i<msg.length;i++){
                    if(msg[i].worktype.substring(0,1) == 3) {//婚秀
                        str += '<li><a href="<%=basePath%>/design/toDesignDel.do?uid='+msg[i].workid+'"><div class="video_box"><video width="100%" height="280"  src="<%=basePath%>'+msg[i].workurl+'" poster="" controls></video></div>'
                                +'<div class="botm_txtd"> <p>'+msg[i].workname+'</p> </div> </a></li>';
                    }else{
                        str += '<li><a href="<%=basePath%>/design/toDesignDel.do?uid='+msg[i].workid+'"><img src="<%=basePath%>'+msg[i].worksamllurl+'" />'
                                +'<div class="botm_txtd"> <p>'+msg[i].workname+'</p> </div> </a></li>';
                    }
                }
                $("#transaction").append(str);
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
                 <div class="tx_infor">
                      <img src="<%=basePath%>${userinfo.getUsrpicurl()}" />
                      <h2>${userinfo.getFristname()}</h2>
                     <!--
                      <p class="sjss">设计师</p>
                      <span class="icon_jf">38728</span> |  <span class="icon_hp">99.28</span>
                      -->
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
                   <li><a class="mem_icon9" href="<%=basePath%>/persondata/toPersonData.do">个人资料</a></li>
                </ul>
             </div>
           </div><!-- wid260px -->
           <div class="wid925px fr">
              <div class="fytd_box">
                 <div class="hei40px">
                 <div class="txtMarquee-left" style="width: 694px">
                   <p class="tit_fl">消息通知：</p>
			<div class="bd">
				<ul class="infoList">
					<li><a href="javascript:" target="_blank">关于会员奖励制度最新改变1<span class="col_999">2016-10-20</span></a></li>
					<li><a href="javascript:" target="_blank">关于会员奖励制度最新改变2<span class="col_999">2016-10-20</span></a></li>
			        <li><a href="javascript:" target="_blank">关于会员奖励制度最新改变3<span class="col_999">2016-10-20</span></a></li>
					<li><a href="javascript:" target="_blank">关于会员奖励制度最新改变4<span class="col_999">2016-10-20</span></a></li>

				</ul>
			</div>
		</div>

		<script type="text/javascript">
		jQuery(".txtMarquee-left").slide({mainCell:".bd ul",autoPlay:true,effect:"leftMarquee",vis:2,interTime:50});
		</script>  
                 </div>
                 <div class="cs_tabd">
                   <table width="100%">
                      <tr>
                         <td><h2 id="balance"></h2>余额</td>
                         <td><h2>￥0.00</h2>已冻结</td>
                         <td><h2 id="withcash"></h2>可提现</td>
                         <td><h2 id="scroe"></h2>积分</td>
                         <td width="120">
                           <div class="tx_btn fr">
                               <!--<a href="recharge.html">充值</a>-->
                               <a href="#" onclick="toWithdrawals()" class="tx_bbt">提现</a>
                           </div>
                         </td>
                      </tr>
                    </table>
                 </div>
              
              </div><!-- fytd_box -->
             <!--
             <div class="dh_mem_list">
                 <ul class="clearfix">
                     <li><a href="upload.jsp"><img src="<%=basePath%>/static/images/mem_icon1.png" />上传作品</a></li>
                     <li><a href="upload.jsp"><img src="<%=basePath%>/static/images/mem_icon2.png" />发布悬赏任务</a></li>
                     <li><a href="upload.jsp"><img src="<%=basePath%>/static/images/mem_icon3.png" />VIP特权</a></li>
                     <li><a href="upload.jsp"><img src="<%=basePath%>/static/images/mem_icon4.png" />精品素材</a></li>
                     <li><a href="upload.jsp"><img src="<%=basePath%>/static/images/mem_icon5.png" />设计作品建议</a></li>
                     <li><a href="upload.jsp"><img src="<%=basePath%>/static/images/mem_icon6.png" />设计工具</a></li>
                 </ul>
             </div>
             -->
             <div class="mem_ty_box">
                 <div class="gxq_tit"><h2>我的足迹</h2> <a href="<%=basePath%>/seachs/toSeachs.do?zjsort=zj">更多>> </a></div>
              <div class="design_list da_img mem_imgd">
              <ul id="workview" class="clearfix">
               
           </ul>
         </div><!-- design_list -->
                 
             </div>
             
             <div class="mem_ty_box">
                 <div class="gxq_tit"><h2>最新交易动态</h2> <a href="<%=basePath%>/seachs/toSeachs.do?myjysort=myjy">更多>> </a></div>
                 
              <div class="design_list da_img mem_imgd">
              <ul id="transaction" class="clearfix">
           </ul>
         </div><!-- design_list -->
             </div>
             </div>

           <div class="clear"></div>
        
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
