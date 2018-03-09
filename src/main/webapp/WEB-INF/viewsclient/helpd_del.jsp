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
<script src="<%=basePath%>/static/js/laypage.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/jquery1.42.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/jquery.SuperSlide.2.1.1.js"></script>
    <script type="text/javascript">
        $(function () {
            $('.ss_btn').click(function () {
                document.location.href = '<%=basePath%>/seachs/toSeachs.do?seachTxt='+$('.inp_txt').val();
            });
        })
    </script>
<script type="text/javascript">
 $(document).ready(function () {
	$(".wid260px_help ul li a.curr_tit").click(function(){  
	  if( $(this).parents("li").find(".help_list").css('display') == "none" ){
	      $(this).addClass("active");
		  $(this).find(".arrowd").addClass("active");
	      $(this).parents("li").find(".help_list").slideDown();
		  }
	   else{
        $(this).removeClass("active");
		 $(this).find(".arrowd").removeClass("active");
	    $(this).parents("li").find(".help_list").slideUp(); 
	  }
   });
     //隐藏注册/按钮登录    显示个人中心/个人空间
     var firstname="${userinfo.getFristname()}";
     if(firstname != ""){
         $("#beferLogin").css("display","none");
         $("#backLogin").css("display","block");
     }
 });
 //跳转到会员中心页面
 function toMember(){
     document.location.href = '<%=basePath%>/member/toMember.do';
 }
 //跳转到会员空间页面
 function toHomepage(){
     var uid="${userinfo.getUid()}";
     document.location.href = '<%=basePath%>/homepage/toHomepage.do?uid='+uid;
 }
</script>
</head>
<body>
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
              </div>
          </div>
      </div><!-- top_line -->
      <div class="top_wid logo_con">
         <a href="<%=basePath%>/signin/index.do" class="fl"><img src="<%=basePath%>/static/images/logo.png" height="62" width="217" /></a>
         <div class="phone_fr">
            <h2>400-879-51747</h2>
            <p>24小时服务热线</p>
         </div>
      </div><!-- top_wid -->
      </div><!-- top -->
   </header>
   <div class="help_nav">
           <ul>
              <li><a href="<%=basePath%>/helpd/toHelpd.do">帮助首页</a></li>
              <li><a href="<%=basePath%>/helpd/toAboutUs.do">关于我们</a></li>
           </ul>
       </div>
    <div class="bg_f5">
     <div class="wrap">
     <div class="help_con">
       <div class="wid260px_help fl">
          <h2>帮助中心</h2>
          <ul>
              <li>
                <a href="javascript:" class="curr_tit">注册认证 <span class="arrowd"></span></a>
                <div class="help_list">
                   <a href="javascript:">上传作品</a>
                   <a href="javascript:">下载作品</a>
                   <a href="javascript:">搜索作品</a>
                   <a href="javascript:">保护作品</a>
                   <a href="javascript:">交易评价</a>
                </div> 
              </li>
               <li>
                <a href="javascript:" class="curr_tit">发布交易 <span class="arrowd"></span></a>
                <div class="help_list">
                   <a href="javascript:">上传作品</a>
                   <a href="javascript:">下载作品</a>
                   <a href="javascript:">搜索作品</a>
                   <a href="javascript:" class="active">保护作品</a>
                   <a href="javascript:">交易评价</a>
                </div> 
              </li>
               <li>
                <a href="javascript:" class="curr_tit">账户资金 <span class="arrowd"></span></a>
                <div class="help_list">
                   <a href="javascript:">上传作品</a>
                   <a href="javascript:">下载作品</a>
                   <a href="javascript:">搜索作品</a>
                   <a href="javascript:">保护作品</a>
                   <a href="javascript:">交易评价</a>
                </div> 
              </li>
               <li>
                <a href="javascript:" class="curr_tit">条款协议 <span class="arrowd"></span></a>
                <div class="help_list">
                   <a href="javascript:">上传作品</a>
                   <a href="javascript:">下载作品</a>
                   <a href="javascript:">搜索作品</a>
                   <a href="javascript:">保护作品</a>
                   <a href="javascript:">交易评价</a>
                </div> 
              </li>
               <li>
                <a href="javascript:" class="curr_tit">客户服务 <span class="arrowd"></span></a>
                <div class="help_list">
                   <a href="javascript:">上传作品</a>
                   <a href="javascript:">下载作品</a>
                   <a href="javascript:">搜索作品</a>
                   <a href="javascript:" >保护作品</a>
                   <a href="javascript:">交易评价</a>
                </div> 
              </li>
              <li>
                <a href="javascript:" class="curr_tit">版权知识 <span class="arrowd"></span></a>
                <div class="help_list">
                   <a href="javascript:">上传作品</a>
                   <a href="javascript:">下载作品</a>
                   <a href="javascript:">搜索作品</a>
                   <a href="javascript:">保护作品</a>
                   <a href="javascript:">交易评价</a>
                </div> 
              </li>
              <li>
                <a href="javascript:" class="curr_tit">悬赏任务 <span class="arrowd"></span></a>
                <div class="help_list">
                   <a href="javascript:">上传作品</a>
                   <a href="javascript:">下载作品</a>
                   <a href="javascript:">搜索作品</a>
                   <a href="javascript:">保护作品</a>
                   <a href="javascript:">交易评价</a>
                </div> 
              </li>
          </ul>
       </div><!-- wid260px_help -->
       <div class="wid925px_frd fr">
            <div class="crumbs">当前位置： <a href="javascript:">首页</a> > <a href="javascript:">服务中心</a> > 保护作品</div>
             <div class="xq_txt2">
           <h3> 1.什么是无忧保全  </h3>
<p>无忧保全采用中科院国家授时中心标准时间源，权威证明数据产生的时间，固化电子数据，杜绝电子数据内容和签署时间被伪造和篡改的可能，有效解决电子数据产生的时间证明的问题。使用无忧保全保护的作品，均将拥有“安存”签发的具有法律效力的电子保全证书，用于证明电子数据文件存在时间和内容完整性。</p>
<h3>2、无忧保全的产生背景</h3>
<p>①解决数字时代的版权问题
<p>随着计算机、互联网技术的快速发展，越来越多的作品以数字化形式产生，人们的工作与生活已越来越趋于信息化、无纸化，复制与传播也变得异常简单、便捷，它带给人们便利的同时也造就了权属侵害、恶意抄袭日趋严重的局面，严重侵害了权利人的合法权益。
大数据时代下产生的各类社会矛盾，已经无法完全依赖传统证据形式来解决，人们越来越多的需要电子数据证明来定纷止争。
<p>②满足原创作者的需求
<p>A、根据《中华人民共和国著作权法》作品产生即拥有著作权，一旦出现版权纠纷，规定了原创作者证明自己是作品权利人需要举证。
<p>因此，在创作完成后，作品公开发布前就为作品的创作时间、作品内容等保留足够且不可否认的证据极为重要，以便在证明作品归属或著作权产生纠纷的时候有效的保护自身的权益。
<p>B、数字作品版权通过交易产生巨大价值，作品版权保护是开展版权交易的基础，也是保护交易双方利益的必要手段。
<p>C、数字作品产生快，数量多，需要适合数字作品特点的版权保护途径： 快速、有效、简单、批量、低成本。
<h3>３.关于无忧保全服务</h3>
<p>① 无忧保全特点
<p>先进的"无忧保全系统"，采用中国云计算及应用的高端技术，所有用户经国家密码局核定的486位密码器加密，确保原创作品数据完整有效性及传输安全性。具有不泄露原文件内容、批量保护数字作品、保护快捷等特点特别适合数字化时代的版权保护。
<p>A、法律有效性    
<p>无忧保全符合我国《中华人民共和国电子签名法》、《中华人民著作权法》相关法律规定，是具有法律效力的电子凭证，已经在司法程序上得到认可。
<p>B、时间权威性   
<p>安存无忧保全的时间由我国唯一的法定时间源——中科院国家授时中心负责监控保障，确保了时间的权威性和可靠性。    
<p>C、及时性   
<p>作品在发布成功的瞬间便及时使用无忧保全服务，误差精确到秒。版权保护系统7×24小时全天候为广大著作权人开通。
<p>D、简易性    
<p>无需任何操作,作品发布即自动使用，为作品使用无忧保全版权保护就是这么简单。 
<p>E、保密性   
<p>拥有世界领先技术并获行业权威专业力量支持，用户信息均采用经国家密码局核定的486位密码器加密，确保原创作品数据完整有效性及传输安全性。
<p>②无忧保全的作用
<p>无忧保全能证明权利人在什么时间拥有一个什么样的电子文件（数字作品）。主要用在商业秘密保护、工作文档的责任认定、著作权保护、原创作品、软件代码、发明专利、学术论文、试验数据、电子单据等方面。
使用无忧保全，作品将拥有一个具有法律效力的权属证明。
</div>
       </div><!-- wid925px_frd -->
       <div class="clear"></div>
       </div><!-- help_con -->
     </div><!-- wrap -->
    </div><!-- bg_f5 -->
   <!-- 公共底部 -->
   <footer>
     <div class="wrap">
      <div class="bottom clearfix">
          <dl>
             <dt>新手帮助</dt>
             <dd><a href="javascript:">注册/登录</a></dd>
             <dd><a href="javascript:">认证/签约</a></dd>
             <dd><a href="javascript:">条款协议</a></dd>
             <dd><a href="javascript:">版权声明</a></dd>
          </dl>
          <dl>
             <dt>关于婚秀中国</dt>
             <dd><a href="javascript:">婚秀中国简介</a></dd>
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
