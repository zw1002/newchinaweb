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
<script type="text/javascript" src="<%=basePath%>/static/js/laydate.js"></script>
<script src="<%=basePath%>/static/js/laypage.js"></script>
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
    </style>
<script type="text/javascript">
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
     getUserMerch();
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
 //根据分类获取会员全部作品
 function getUserAllWorksByType(offset,count,type){
     var uid=$("#uid").val();
     var str="";
     $.ajax({
         url: "<%=basePath%>/personworks/getPersonWorksByType.do",
         type: "POST",
         async:false,
         data: {
             uid: uid,
             offset:offset,
             count:count,
             type:type
         },
         success: function (data) {
             var msg = eval("(" + data + ")");
             for(var i=0;i<msg.length;i++){
                 if(msg[i].workstype.substring(0,1) == 3) {//婚秀
                     if(msg[i].samllurl == ""){
                         str += "<li id="+msg[i].uid+"><div class='btn_pos'><a href='#' onclick=offShelf('"+msg[i].uid+"')>下架</a></div>"
                                 +'<a href="<%=basePath%>/design/toDesignDel.do?uid='+msg[i].uid+'">'
                                 +'<div class="video_box"><video width="100%" height="280"  src="<%=basePath%>'+msg[i].worksurl+'" poster=""></video></div>'
                                 +'</a><h2>'+msg[i].worksname+'</h2><p class="small_txt"><span class="sc_icon">收藏：'+msg[i].favcount+'</span>&nbsp; &nbsp; |&nbsp; &nbsp; <span class="yzx_icon">已下载：'+msg[i].downcount+'</span></p> </li>';
                     }else{
                         str += "<li id="+msg[i].uid+"><div class='btn_pos'><a href='#' onclick=offShelf('"+msg[i].uid+"')>下架</a></div>"
                                 +'<a href="<%=basePath%>/design/toDesignDel.do?uid='+msg[i].uid+'"><img src="<%=basePath%>'+msg[i].samllurl+'" /></a><h2>'+msg[i].worksname+'</h2>'
                                 +'<p class="small_txt"><span class="sc_icon">收藏：'+msg[i].favcount+'</span>&nbsp; &nbsp; |&nbsp; &nbsp; <span class="yzx_icon">已下载：'+msg[i].downcount+'</span></p> </li>';
                     }
                 }else{
                     str += "<li id="+msg[i].uid+"><div class='btn_pos'><a href='#' onclick=offShelf('"+msg[i].uid+"')>下架</a></div>"
                             +'<a href="<%=basePath%>/design/toDesignDel.do?uid='+msg[i].uid+'"><img src="<%=basePath%>'+msg[i].samllurl+'" /></a><h2>'+msg[i].worksname+'</h2>'
                             +'<p class="small_txt"><span class="sc_icon">收藏：'+msg[i].favcount+'</span>&nbsp; &nbsp; |&nbsp; &nbsp; <span class="yzx_icon">已下载：'+msg[i].downcount+'</span></p> </li>';
                 }
             }
         }
     });
     if(type == 00){//设计
         $("#designworks").find("li").remove();
         $("#designworks").append(str);
     }else if(type == 10){//摄影
         $("#photoworks").find("li").remove();
         $("#photoworks").append(str);
     }else if(type == 20){//道具
         $("#multimeworks").find("li").remove();
         $("#multimeworks").append(str);
     }else{//婚秀
         $("#weddingworks").find("li").remove();
         $("#weddingworks").append(str);
     }
 }
    //作品下架
    function offShelf(workid){
            $.ajax({
                url: "<%=basePath%>/personworks/workOffShelf.do",
                type: "POST",
                data: {
                    workid: workid
                },
                success: function (data) {
                    if(data!=="failed"){
                        $("#"+workid).css("display","none");
                        alert("作品下架成功!");
                    }else{
                        alert("作品下架失败!");
                    }
                }
            });
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
<input id="uid" name="uid" type="hidden" value="<%= request.getAttribute("uid")%>"/>
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
                      <img src="<%=basePath%>${userinfo.getUsrpicurl()}"/>
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
                    <li><a class="mem_icon9 active" href="#" onclick="personWorks()">我的作品</a></li>
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
               <div class="tran_con">
                  <div class="jy_nav">
                    <ul class=" clearfix">
                       <li>设计</li>
                       <li>摄影</li>
                       <li>婚秀</li>
                       <li>道具</li>
                    </ul>
                  </div>
                  <div class="jy_tab_con">
                     <!-- 设计 -->
                      <div class="page_list">
                      <ul style="width:890px" id="designworks" class="clearfix">
                      </ul>
                          <div id="pages" class="pages_box"></div>
                      </div>
                     <!-- 摄影 -->
                      <div class="page_list">
                          <ul style="width:890px" id="photoworks" class="clearfix">
                          </ul>
                          <div id="photopages" class="pages_box"></div>
                      </div>
                     <!-- 婚秀 -->
                      <div class="page_list">
                          <ul style="width:890px" id="weddingworks" class="clearfix">
                          </ul>
                          <div id="weddingpages" class="pages_box"></div>
                      </div>
                      <!-- 道具 -->
                      <div class="page_list">
                          <ul style="width:890px" id="multimeworks" class="clearfix">
                          </ul>
                          <div id="multimepages" class="pages_box"></div>
                      </div>
                  </div>
                 </div>
<script type="text/javascript">
    jQuery(".tran_con").slide({titCell:".jy_nav li",mainCell:".jy_tab_con", trigger:"click"})
 </script>     
<script>
    var designpage=0;
    var photopage=0;
    var weddingpage=0;
    var multimepage=0;
    var uid=$("#uid").val();
    var groups=6;
    //设计
    $.ajax({
        url: "<%=basePath%>/personworks/getPersonWorksByType.do",
        type: "POST",
        async:false,
        data: {
            uid: uid,
            type:"00"
        },
        success: function (data) {
            var msg = eval("(" + data + ")");
            designpage=Math.ceil(msg.length/groups);
        }
    });
    laypage({
        cont: ('pages'),   //容器。值支持id名、原生dom对象，jquery对象,
        pages: designpage,              //分页数。一般通过服务端返回得到
        curr:1,                 //当前页。默认为1
        groups: groups,              //连续显示分页数  默认为5
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
            getUserAllWorksByType(offset,groups,"00");
        }
    });
    //摄影
    $.ajax({
        url: "<%=basePath%>/personworks/getPersonWorksByType.do",
        type: "POST",
        async:false,
        data: {
            uid: uid,
            type:"10"
        },
        success: function (data) {
            var msg = eval("(" + data + ")");
            photopage=Math.ceil(msg.length/groups);
        }
    });
    laypage({
        cont: ('photopages'),   //容器。值支持id名、原生dom对象，jquery对象,
        pages: photopage,              //分页数。一般通过服务端返回得到
        curr:1,                 //当前页。默认为1
        groups: groups,              //连续显示分页数  默认为5
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
            getUserAllWorksByType(offset,groups,"10");
        }
    });
    //婚秀
    $.ajax({
        url: "<%=basePath%>/personworks/getPersonWorksByType.do",
        type: "POST",
        async:false,
        data: {
            uid: uid,
            type:"30"
        },
        success: function (data) {
            var msg = eval("(" + data + ")");
            weddingpage=Math.ceil(msg.length/groups);
        }
    });
    laypage({
        cont: ('weddingpages'),   //容器。值支持id名、原生dom对象，jquery对象,
        pages: weddingpage,              //分页数。一般通过服务端返回得到
        curr:1,                 //当前页。默认为1
        groups: groups,              //连续显示分页数  默认为5
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
            getUserAllWorksByType(offset,groups,"30");
        }
    });
    //道具
    $.ajax({
        url: "<%=basePath%>/personworks/getPersonWorksByType.do",
        type: "POST",
        async:false,
        data: {
            uid: uid,
            type:"20"
        },
        success: function (data) {
            var msg = eval("(" + data + ")");
            multimepage=Math.ceil(msg.length/groups);
        }
    });
    laypage({
        cont: ('multimepages'),   //容器。值支持id名、原生dom对象，jquery对象,
        pages: multimepage,              //分页数。一般通过服务端返回得到
        curr:1,                 //当前页。默认为1
        groups: groups,              //连续显示分页数  默认为5
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
            getUserAllWorksByType(offset,groups,"20");
        }
    });
</script>
           </div><!-- wid925px -->
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
