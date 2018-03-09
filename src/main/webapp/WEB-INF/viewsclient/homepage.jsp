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
    <link href="<%=basePath%>/static/css/laypage.css" rel="stylesheet" type="text/css" />
    <script src="<%=basePath%>/static/js/laypage.js"></script>
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
    </style>
    <script type="text/javascript">
        var flag=1;
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
     //店铺会员ID
     var uid=$("#uid").val();
     var uids="${userinfo.getUid()}";
     if(uid == uids){
        $("#member").css("display","block");
     }
     getUserInfoData();
     getUserMerch();
     getUserFocus();
     getMerchData();
     userBestSellers();
     latestRecommendation();
     getUserFocusOthers();
     getTurnover();
     $("#allWorks").css("display","none");
     $("#allCollection").css("display","none");
     getTransaction();
     //setInterval("getTransaction()", 10000); //每隔10秒刷新交易动态
 });
 //获取会员信息
 function getUserInfoData(){
     //会员ID
     var uid=$("#uid").val();
     $.ajax({
         url: "<%=basePath%>/userinfo/getUserInfo.do",
         type: "POST",
         data: {
             uid: uid
         },
         success: function (data) {
             var msg = eval("(" + data + ")");
             $("#username").text(msg.fristname);
             $("#userpic").attr("src","<%=basePath%>"+msg.usrpicurl+"");
         }
     });
 }
 //店铺成交额
 function getTurnover(){
     var uid=$("#uid").val();
     $.ajax({
         url: "<%=basePath%>/homepage/getTurnover.do",
         type: "POST",
         data: {
             uid: uid
         },
         success: function (data) {
             if(data == "[null]"){
                 $("#turnover").text("0");
             }else{
                 var msg = eval("(" + data + ")");
                 $("#turnover").text(msg[0].turnover);

             }
         }
     });
 }
 //获取会员店铺信息
 function getUserMerch(){
     //会员ID
     var uid=$("#uid").val();
     $.ajax({
         url: "<%=basePath%>/merch/getMerchData.do",
         type: "POST",
         data: {
             uid: uid
         },
         success: function (data) {
             if(data == "null"){
                 $("#worksnums").text("0");
                 $("#dealnums").text("0");
                 $("#merchremark").text("暂时没有店铺信息");
             }else{
                 var msg = eval("(" + data + ")");
                 $("#worksnums").text(msg.worksnums);
                 $("#dealnums").text(msg.dealnums);
                 $("#merchremark").text(msg.remark);
                 $("#merchid").val(msg.uid);
             }
         }
     });
 }
 //获取会员被关注量
 function getUserFocus(){
     var uid=$("#uid").val();
     $.ajax({
         url: "<%=basePath%>/userinfo/getUserFocus.do",
         type: "POST",
         data: {
             uid: uid
         },
         success: function (data) {
             var msg = eval("(" + data + ")");
             $("#focuscount").text(msg.count);
         }
     });
 }
 //获取会员关注信息
 function getUserFocusOthers(){
     var uid=$("#uid").val();
     var count=6;
     $.ajax({
         url: "<%=basePath%>/userinfo/getUserFocusOthers.do",
         type: "POST",
         data: {
             uid: uid,
             count:count
         },
         success: function (data) {
             var msg = eval("(" + data + ")");
             var str="";
             for(var i=0;i<msg.length;i++){
                 str += '<li><a href="#"><img src="<%=basePath%>'+msg[i].userpic+'" /> <p>'+msg[i].username+'</p></a></li>';
                 if(msg[i].uid == uid){
                     $("#focus").text("已关注");
                 }
             }
             $("#userFocusOthers").append(str);
         }
     });
 }
 //获取会员作品-根据下载量排序
function getMerchData(){
    var uid=$("#uid").val();
    var count=6;
    $.ajax({
        url: "<%=basePath%>/homepage/getMerchData.do",
        type: "POST",
        data: {
            uid: uid,
            count:count
        },
        success: function (data) {
            var msg = eval("(" + data + ")");
            var str="";
            for(var i=0;i<msg.length;i++){
                if(msg[i].workstype.substring(0,1) == 3) {//婚秀
                    if(msg[i].samllurl == ""){
                        str += '<li><div class="btn_pos"><a href="#">收藏</a></div>'
                                +'<a href="<%=basePath%>/design/toDesignDel.do?uid='+msg[i].uid+'">'
                                +'<div class="video_box"><video width="100%" height="280"  src="<%=basePath%>'+msg[i].worksurl+'" poster=""></video></div>'
                                +'<h2>'+msg[i].worksname+'</h2></a> <p class="small_txt"><span class="sc_icon">收藏：'+msg[i].favcount+'</span>&nbsp; &nbsp; |&nbsp; &nbsp; <span class="yzx_icon">已下载：'+msg[i].downcount+'</span></p> </li>';
                    }else{
                        str += '<li><div class="btn_pos"><a href="#">收藏</a></div>'
                                +'<a href="<%=basePath%>/design/toDesignDel.do?uid='+msg[i].uid+'">'
                                +'<img src="<%=basePath%>'+msg[i].samllurl+'" />'
                                +'<h2>'+msg[i].worksname+'</h2></a> <p class="small_txt"><span class="sc_icon">收藏：'+msg[i].favcount+'</span>&nbsp; &nbsp; |&nbsp; &nbsp; <span class="yzx_icon">已下载：'+msg[i].downcount+'</span></p> </li>';
                    }
                }else{
                    str += '<li><div class="btn_pos"><a href="#">收藏</a></div>'
                            +'<a href="<%=basePath%>/design/toDesignDel.do?uid='+msg[i].uid+'">'
                            +'<img src="<%=basePath%>'+msg[i].samllurl+'" />'
                            +'<h2>'+msg[i].worksname+'</h2></a> <p class="small_txt"><span class="sc_icon">收藏：'+msg[i].favcount+'</span>&nbsp; &nbsp; |&nbsp; &nbsp; <span class="yzx_icon">已下载：'+msg[i].downcount+'</span></p> </li>';
                }
            }
            $("#userWorks").append(str);
        }
    });
}
 //近三个月热卖
 function userBestSellers(){
     var uid=$("#uid").val();
     var count=6;
     $.ajax({
         url: "<%=basePath%>/homepage/userBestSellers.do",
         type: "POST",
         data: {
             uid: uid,
             count:count
         },
         success: function (data) {
             var msg = eval("(" + data + ")");
             var str="";
             for(var i=0;i<msg.length;i++){
                 if(msg[i].workstype.substring(0,1) == 3) {//婚秀
                     if(msg[i].samllurl == ""){
                         str += '<li><div class="btn_pos"><a href="#">收藏</a></div>'
                                 +'<a href="<%=basePath%>/design/toDesignDel.do?uid='+msg[i].uid+'">'
                                 +'<div class="video_box"><video width="100%" height="280"  src="<%=basePath%>'+msg[i].worksurl+'" poster=""></video></div>'
                                 +'<h2>'+msg[i].worksname+'</h2></a> <p class="small_txt"><span class="sc_icon">收藏：'+msg[i].favcount+'</span>&nbsp; &nbsp; |&nbsp; &nbsp; <span class="yzx_icon">已下载：'+msg[i].downcount+'</span></p> </li>';
                     }else{
                         str += '<li><div class="btn_pos"><a href="#">收藏</a></div>'
                                 +'<a href="<%=basePath%>/design/toDesignDel.do?uid='+msg[i].uid+'">'
                                 +'<img src="<%=basePath%>'+msg[i].samllurl+'" />'
                                 +'<h2>'+msg[i].worksname+'</h2></a> <p class="small_txt"><span class="sc_icon">收藏：'+msg[i].favcount+'</span>&nbsp; &nbsp; |&nbsp; &nbsp; <span class="yzx_icon">已下载：'+msg[i].downcount+'</span></p> </li>';
                     }
                 }else{
                     str += '<li><div class="btn_pos"><a href="#">收藏</a></div>'
                             +'<a href="<%=basePath%>/design/toDesignDel.do?uid='+msg[i].uid+'">'
                             +'<img src="<%=basePath%>'+msg[i].samllurl+'" />'
                             +'<h2>'+msg[i].worksname+'</h2></a> <p class="small_txt"><span class="sc_icon">收藏：'+msg[i].favcount+'</span>&nbsp; &nbsp; |&nbsp; &nbsp; <span class="yzx_icon">已下载：'+msg[i].downcount+'</span></p> </li>';
                 }
             }
             $("#userBestSellers").append(str);
         }
     });
 }
 //最新作品推荐
 function latestRecommendation(){
     var uid=$("#uid").val();
     var count=3;
     $.ajax({
         url: "<%=basePath%>/homepage/latestRecommendation.do",
         type: "POST",
         async:false,
         data: {
             uid: uid,
             count:count
         },
         success: function (data) {
             var msg = eval("(" + data + ")");
             var str="";
             for(var i=0;i<msg.length;i++){
                 if(msg[i].workstype.substring(0,1) == 3) {//婚秀
                     if(msg[i].samllurl == ""){
                         str += '<li><div class="btn_pos"><a href="#">收藏</a></div>'
                                 +'<a href="<%=basePath%>/design/toDesignDel.do?uid='+msg[i].uid+'">'
                                 +'<div class="video_box"><video width="100%" height="280"  src="<%=basePath%>'+msg[i].worksurl+'" poster=""></video></div>'
                                 +'<h2>'+msg[i].worksname+'</h2></a> <p class="small_txt"><span class="sc_icon">收藏：'+msg[i].favcount+'</span>&nbsp; &nbsp; |&nbsp; &nbsp; <span class="yzx_icon">已下载：'+msg[i].downcount+'</span></p> </li>';
                     }else{
                         str += '<li><div class="btn_pos"><a href="#">收藏</a></div>'
                                 +'<a href="<%=basePath%>/design/toDesignDel.do?uid='+msg[i].uid+'">'
                                 +'<img src="<%=basePath%>'+msg[i].samllurl+'" />'
                                 +'<h2>'+msg[i].worksname+'</h2></a> <p class="small_txt"><span class="sc_icon">收藏：'+msg[i].favcount+'</span>&nbsp; &nbsp; |&nbsp; &nbsp; <span class="yzx_icon">已下载：'+msg[i].downcount+'</span></p> </li>';
                     }
                 }else{
                     str += '<li><div class="btn_pos"><a href="#">收藏</a></div>'
                             +'<a href="<%=basePath%>/design/toDesignDel.do?uid='+msg[i].uid+'">'
                             +'<img src="<%=basePath%>'+msg[i].samllurl+'" />'
                             +'<h2>'+msg[i].worksname+'</h2></a> <p class="small_txt"><span class="sc_icon">收藏：'+msg[i].favcount+'</span>&nbsp; &nbsp; |&nbsp; &nbsp; <span class="yzx_icon">已下载：'+msg[i].downcount+'</span></p> </li>';
                 }
             }
             $("#latestRecommendation").append(str);
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
 //获取会员全部作品
    function getUserAllWorks(offset,count){
        $("#userAllWorks").find("li").remove();
        var uid=$("#uid").val();
        $.ajax({
            url: "<%=basePath%>/homepage/getMerchData.do",
            type: "POST",
            async:false,
            data: {
                uid: uid,
                offset:offset,
                count:count
            },
            success: function (data) {
                var msg = eval("(" + data + ")");
                var str="";
                for(var i=0;i<msg.length;i++){
                    if(msg[i].workstype.substring(0,1) == 3) {//婚秀
                        if(msg[i].samllurl == ""){
                            str += '<li><div class="btn_pos"><a href="#">收藏</a></div>'
                                    +'<a href="<%=basePath%>/design/toDesignDel.do?uid='+msg[i].uid+'">'
                                    +'<div class="video_box"><video width="100%" height="280"  src="<%=basePath%>'+msg[i].worksurl+'" poster=""></video></div>'
                                    +'<h2>'+msg[i].worksname+'</h2></a> <p class="small_txt"><span class="sc_icon">收藏：'+msg[i].favcount+'</span>&nbsp; &nbsp; |&nbsp; &nbsp; <span class="yzx_icon">已下载：'+msg[i].downcount+'</span></p> </li>';
                        }else{
                            str += '<li><div class="btn_pos"><a href="#">收藏</a></div>'
                                    +'<a href="<%=basePath%>/design/toDesignDel.do?uid='+msg[i].uid+'">'
                                    +'<img src="<%=basePath%>'+msg[i].samllurl+'" />'
                                    +'<h2>'+msg[i].worksname+'</h2></a> <p class="small_txt"><span class="sc_icon">收藏：'+msg[i].favcount+'</span>&nbsp; &nbsp; |&nbsp; &nbsp; <span class="yzx_icon">已下载：'+msg[i].downcount+'</span></p> </li>';
                        }
                    }else{
                        str += '<li><div class="btn_pos"><a href="#">收藏</a></div>'
                                +'<a href="<%=basePath%>/design/toDesignDel.do?uid='+msg[i].uid+'">'
                                +'<img src="<%=basePath%>'+msg[i].samllurl+'" />'
                                +'<h2>'+msg[i].worksname+'</h2></a> <p class="small_txt"><span class="sc_icon">收藏：'+msg[i].favcount+'</span>&nbsp; &nbsp; |&nbsp; &nbsp; <span class="yzx_icon">已下载：'+msg[i].downcount+'</span></p> </li>';
                    }
                }
                $("#userAllWorks").append(str);
            }
        });
    }
 function toWorks(){
     var div = document.getElementById('work');
     div.setAttribute("class", "active");
     var div1 = document.getElementById('userpages');
     div1.setAttribute("class", "");
     var div2 = document.getElementById('collection');
     div2.setAttribute("class", "");
     $("#allWorks").css("display","block");
     $("#userpage").css("display","none");
     $("#allCollection").css("display","none");
 }
 //获取会员收藏
 function userAllCollection(offset,count){
     $("#userAllCollection").find("li").remove();
     var userid=$("#uid").val();
     $.ajax({
         url: "<%=basePath%>/personalcenter/getCollectionData.do",
         type: "POST",
         data:{
             userid:userid,
             offset:offset,
             count:count
         },
         success: function (data) {
             var msg = eval("(" + data + ")");
             var str="";
             for(var i=0;i<msg.length;i++){
                 if(msg[i].workstype.substring(0,1) == 3) {//婚秀
                     if(msg[i].samllurl == ""){
                         str += '<li><div class="btn_pos"><a href="#">收藏</a></div>'
                                 +'<a href="<%=basePath%>/design/toDesignDel.do?uid='+msg[i].uid+'">'
                                 +'<div class="video_box"><video width="100%" height="280"  src="<%=basePath%>'+msg[i].worksurl+'" poster=""></video></div>'
                                 +'<h2>'+msg[i].worksname+'</h2></a> <p class="small_txt"><span class="sc_icon">收藏：'+msg[i].favcount+'</span>&nbsp; &nbsp; |&nbsp; &nbsp; <span class="yzx_icon">已下载：'+msg[i].downcount+'</span></p> </li>';
                     }else{
                         str += '<li><div class="btn_pos"><a href="#">收藏</a></div>'
                                 +'<a href="<%=basePath%>/design/toDesignDel.do?uid='+msg[i].uid+'">'
                                 +'<img src="<%=basePath%>'+msg[i].samllurl+'" />'
                                 +'<h2>'+msg[i].worksname+'</h2></a> <p class="small_txt"><span class="sc_icon">收藏：'+msg[i].favcount+'</span>&nbsp; &nbsp; |&nbsp; &nbsp; <span class="yzx_icon">已下载：'+msg[i].downcount+'</span></p> </li>';
                     }
                 }else{
                     str += '<li><div class="btn_pos"><a href="#">收藏</a></div>'
                             +'<a href="<%=basePath%>/design/toDesignDel.do?uid='+msg[i].uid+'">'
                             +'<img src="<%=basePath%>'+msg[i].samllurl+'" />'
                             +'<h2>'+msg[i].worksname+'</h2></a> <p class="small_txt"><span class="sc_icon">收藏：'+msg[i].favcount+'</span>&nbsp; &nbsp; |&nbsp; &nbsp; <span class="yzx_icon">已下载：'+msg[i].downcount+'</span></p> </li>';
                 }
             }
             $("#userAllCollection").append(str);
         }
     });
 }
 function toCollertion(){
     var div = document.getElementById('collection');
     div.setAttribute("class", "active");
     var div1 = document.getElementById('userpages');
     div1.setAttribute("class", "");
     var div2 = document.getElementById('work');
     div2.setAttribute("class", "");
     $("#allCollection").css("display","block");
     $("#userpage").css("display","none");
     $("#allWorks").css("display","none");
 }
 function toUserPage(){
     var div = document.getElementById('userpages');
     div.setAttribute("class", "active");
     var div1 = document.getElementById('collection');
     div1.setAttribute("class", "");
     var div2 = document.getElementById('work');
     div2.setAttribute("class", "");
     $("#userpage").css("display","block");
     $("#allCollection").css("display","none");
     $("#allWorks").css("display","none");
 }
//添加关注
 function addFocusOthers(){
     var focus=document.getElementById("focus").innerText;
     if(focus.indexOf("+") != -1){
         var focus_userid=$("#uid").val();
         var focus_merchid=$("#merchid").val();
         var flag="1";
         $.ajax({
             url: "<%=basePath%>/homepage/addFocusOthers.do",
             type: "POST",
             data: {
                 flag:flag,
                 focus_userid: focus_userid,
                 focus_merchid: focus_merchid
             },
             success: function (data) {
                 if(data!=="failed"){
                     alert("关注成功");
                     $("#focus").text("已关注");
                 }else{
                     alert("关注失败");
                 }
             }
         });
     }else{
         alert("已关注");
     }
 }
 //交易动态
 function getTransaction(){
     $("#transaction").html("");
     var count=10;
     $.ajax({
         url:"<%=basePath%>/index/getTransaction.do",
         type:"POST",
         data:{
             count:count
         },
         success:function(data){
             var msg=eval("("+data+")");
             var str="";
             for(var i=0;i<msg.length;i++){
                 str +='<li> <a id="'+msg[i].worksid+'" href="<%=basePath%>/design/toDesignDel.do?uid='+msg[i].worksid+'"><img src="<%=basePath%>'+msg[i].worksamllurl+'" /></a> <div class="txt_fldd">'
                         +'<h2><a href="#">'+msg[i].workname+'</a></h2> <b class="col_f00">￥'+msg[i].worksprice+'</b> <p class="timed">'+msg[i].time+'</p> </div> </li>';
             }
             $("#transaction").append(str);
             if(flag == 1){
                 jQuery("#jyphb").slide({titCell:".hd ul",mainCell:".bd ul",autoPage:true,effect:"top",autoPlay:true,vis:4,trigger:"click"});
             }
             flag=flag+1;
         }
     });
 }
</script>
</head>
<body>
<input id="uid" name="uid" type="hidden" value="<%= request.getAttribute("uid")%>"/>
   <header>
     <div class="top">    
      <div class="top_wid logo_con">
         <a href="#" onclick="toIndex()" class="fl"><img src="<%=basePath%>/static/images/logo.png" height="62" width="217" /></a>
         <div class="nav_new fl">
             <ul class="clearfix">
                 <li style="display:none;" id="member"><a href="<%=basePath%>/member/toMember.do" class="ztit">个人中心</a></li>
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
        <div class="home_top">
          <div class="img_sc"><img src="<%=basePath%>/static/images/hy_banner.png" height="215" width="1200" /></div>
          <div class="tx_zl">
             <div class="zl_tabd fl">
                <table width="100%">
                   <tr>
                      <td><h2 id="focuscount"></h2>关注</td>
                       <td><h2 id="worksnums"></h2>作品数量</td>
                   </tr>
                </table>
             </div>
             <div class="wid180px">
               <img id="userpic" src=""/>
               <h2 id="username"></h2>
               <div class="btn_dd">
                 <a id="focus" href="#" onclick="addFocusOthers()" class="gz_cold">+关注</a>
               </div>
             </div>
             <div class="zl_tabd fr">
                <table width="100%">
                   <tr>
                      <td><h2 id="turnover"></h2>成交额</td>
                      <td><h2 id="dealnums"></h2>交易量</td>
                   </tr>
                </table>
             </div>
          </div><!-- tx_zl -->
        </div><!-- home_top -->
        <div class="home_nav">
           <ul>
              <li><a id="userpages" class="active" href="#" onclick="toUserPage()">主页</a></li>
               <li><a id="work" class="" href="#" onclick="toWorks()">作品</a></li>
               <li><a id="collection" class="" href="#" onclick="toCollertion()">收藏</a></li>
               <!--<li><a class="" href="attention.jsp">关注页面/我的粉丝</a></li>-->
           </ul>
        </div>
       <div class="home_con">
        <div id="userpage" class="wid920px fl">
           <div class="gxq_tit font16px"><h2>会员作品</h2></div>
           <div class="page_list">
              <ul id="userWorks" class="clearfix">

              </ul>
           </div>
           
           <div class="gxq_tit font16px"><h2>近三个月的热卖作品</h2></div>
           <div class="page_list">
              <ul id="userBestSellers" class="clearfix">

              </ul>
           </div>
           
            <div class="gxq_tit font16px"><h2>最新作品推荐</h2></div>
           <div class="page_list">
              <ul id="latestRecommendation" class="clearfix">

              </ul>
           </div>
           
        
        </div><!-- wid920px -->

        <div class="wid260px fr">
          
          <div class="ty_box">
             <div class="tit_zptj"><h2>店铺简介</h2></div>
              <input type="hidden" id="merchid"/>
             <p id="merchremark"></p>
          </div>
          <!--
          <div class="ty_box">
             <div class="tit_zptj"><h2>TA的最新动态</h2> <a href="javascript:">更多>> </a></div>
             <div class="dt_list">
               <ul>
                  <li><a href="#">我发布了“漫婚礼舞台”快来看~</a></li>
                  <li><a href="#">我发布了“浪漫婚礼舞台浪漫婚礼舞台浪漫婚礼舞台”快来看~</a></li>
                  <li><a href="#">我发布了“浪漫婚礼舞台浪漫婚礼舞台浪漫婚礼舞台”快来看~</a></li>
                  <li><a href="#">我发布了“浪漫婚礼舞台浪漫婚礼舞台浪漫婚礼舞台”快来看~</a></li>
                  <li><a href="#">我发布了“浪漫婚礼舞台浪漫婚礼舞台浪漫婚礼舞台”快来看~</a></li>
               </ul>
             </div>
          </div>
          
          <div class="ty_box">
             <div class="tit_zptj"><h2>TA关注的</h2></div>
             <div class="tx_listd">
               <ul id="userFocusOthers" class="clearfix">

               </ul>
             </div>
          </div>
          -->
          <div class="ty_box">
             <div class="tit_zptj"><h2>网站最新交易状态</h2> <a href="javascript:">更多>> </a></div>
             <div class="zt_listdd" id="jyphb">
               <ul id="transaction" class="clearfix">

               </ul>
             </div>
          </div>
        </div><!-- wid260px -->
           <div id="allWorks" class="wid920px fl">
               <div class="gxq_tit font16px"><h2>全部作品</h2> </div>
               <div class="page_list">
                   <ul id="userAllWorks" class="clearfix">

                   </ul>
               </div>
               <div id="pages" class="pages_box2"></div>
               <script>
                   var page=0;
                   var groups=9;
                   var uid=$("#uid").val();
                   $.ajax({
                       url: "<%=basePath%>/homepage/getMerchData.do",
                       type: "POST",
                       async:false,
                       data: {
                           uid: uid
                       },
                       success: function (data) {
                           var msg = eval("(" + data + ")");
                           page=Math.ceil(msg.length/groups);
                       }
                   });
                   laypage({
                       cont: ('pages'),//容器。值支持id名、原生dom对象，jquery对象,
                       pages: page,              //分页数。一般通过服务端返回得到
                       curr:1,                 //当前页。默认为1
                       skin: '#e8474b',           //控制分页皮肤。目前支持：molv、yahei、flow  也可以自定义
                       skip: true,             //是否开启跳页
                       first:'首页',           //用于控制首页  默认false
                       last: '尾页',           //用于控制尾页  如：last: '尾页' 如：last: false，则表示不显示首页项
                       prev:'上一页',           //用于控制上一页。若不显示，设置false即可
                       next:'下一页',           //用于控制下一页。若不显示，设置false即可
                       jump: function(obj, first){
                           //触发分页后的回调，函数返回两个参数。 得到了当前页，用于向服务端请求对应数据
                           var curr = obj.curr;
                           var offset=(curr-1)*groups;
                           getUserAllWorks(offset,groups);
                       }
                   });
               </script>
           </div><!-- wid920px -->
           <div id="allCollection" class="wid920px fl">
               <div class="gxq_tit font16px"><h2>全部收藏</h2> </div>
               <div class="page_list">
                   <ul id="userAllCollection" class="clearfix">

                   </ul>
               </div>
               <div id="pagess" class="pages_box2"></div>
               <script>
                   var page=0;
                   var groups=9;
                   var uid=$("#uid").val();
                   $.ajax({
                       url: "<%=basePath%>/personalcenter/getCollectionData.do",
                       type: "POST",
                       async:false,
                       data: {
                           uid: uid
                       },
                       success: function (data) {
                           var msg = eval("(" + data + ")");
                           page=Math.ceil(msg.length/groups);
                       }
                   });
                   laypage({
                       cont: ('pagess'),   //容器。值支持id名、原生dom对象，jquery对象,
                       pages: page,              //分页数。一般通过服务端返回得到
                       curr:1,                 //当前页。默认为1
                       skin: '#e8474b',           //控制分页皮肤。目前支持：molv、yahei、flow  也可以自定义
                       skip: true,             //是否开启跳页
                       first:'首页',           //用于控制首页  默认false
                       last: '尾页',           //用于控制尾页  如：last: '尾页' 如：last: false，则表示不显示首页项
                       prev:'上一页',           //用于控制上一页。若不显示，设置false即可
                       next:'下一页',           //用于控制下一页。若不显示，设置false即可
                       jump: function(obj, first){
                           //触发分页后的回调，函数返回两个参数。 得到了当前页，用于向服务端请求对应数据
                           var curr = obj.curr;
                           var offset=(curr-1)*groups;
                           userAllCollection(offset,groups);
                       }
                   });
               </script>
           </div><!-- wid920px -->
        <div class="clear"></div>
     </div><!-- home_con -->
     
   
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
