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
 });
</script>
</head>

<body>
   <header>
     <div class="top">
     
      <div class="top_line">
         <div class="top_wid">
            欢迎来到婚秀中国网
            
            <!-- 登录前 -->
            <div class="top_pos">
              <a href="login.jsp">登录</a>|<a href="regist.jsp">注册</a>
            </div>
            
            <!-- 登录后 -->
            <div class="top_pos" style="display:none;">
              <a href="pay.html" class="vip_lj">成为VIP</a>|<a href="upload.jsp" class="sc_icon">我要上传</a>|<a href="collection_2.jsp">我的收藏（<span class="col_f00">2</span>）</a>
            </div>
            
            
         </div>
      </div><!-- top_line -->
      
      <div class="top_wid logo_con">
         <a href="index.jsp" class="fl"><img src="<%=basePath%>/static/images/logo.png" height="62" width="217" /></a>
         <div class="ss_bg fl">
            <input name="" type="text" placeholder="请输入搜索内容"  class="inp_txt">
            <input type="submit" value="搜 索" class="ss_btn" /> 
         </div>
         
         <div class="phone_fr">
            <h2>400-879-51747</h2>
            <p>24小时服务热线</p>
         </div>
      </div><!-- top_wid -->
      

      
      
      </div><!-- top -->
   </header>
   
   <div class="help_nav">
           <ul>
              <li><a href="index.jsp">婚秀首页</a></li>
              <li><a href="javascript:">关于我们</a></li>
              <li><a href="javascript:">成为婚秀达人</a></li>
              <li><a href="javascript:">通知公告</a></li>
              <li><a href="javascript:" class="active">帮助中心</a></li>
              <li><a href="javascript:">法务专栏</a></li>
              <li><a href="javascript:">合作伙伴</a></li>
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
                <a href="javascript:" class="curr_tit active">发布交易 <span class="arrowd"></span></a>
                <div class="help_list" style="display:block;">
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
            
            <div class="list_li">
               <ul>
                 <li><a href="helpd_del.jsp">作品权利保证书作品权利保证书</a></li>
                 <li><a href="helpd_del.jsp">作品自愿出售说明书作品自愿出售说明书</a></li>
                 <li><a href="helpd_del.jsp">图片传代编辑渠道试运行</a></li>
                 <li><a href="helpd_del.jsp">关于作品中涉及到的示例信息展示规范</a></li>
                 <li><a href="helpd_del.jsp">作品权利保证书作品权利保证书</a></li>
                 <li><a href="helpd_del.jsp">作品自愿出售说明书作品自愿出售说明书</a></li>
                 <li><a href="helpd_del.jsp">图片传代编辑渠道试运行</a></li>
                 <li><a href="helpd_del.jsp">关于作品中涉及到的示例信息展示规范</a></li>
                 <li><a href="helpd_del.jsp">作品权利保证书作品权利保证书</a></li>
                 <li><a href="helpd_del.jsp">作品自愿出售说明书作品自愿出售说明书</a></li>
                 <li><a href="helpd_del.jsp">图片传代编辑渠道试运行</a></li>
                 <li><a href="helpd_del.jsp">关于作品中涉及到的示例信息展示规范</a></li>
                 <li><a href="helpd_del.jsp">作品权利保证书作品权利保证书</a></li>
                 <li><a href="helpd_del.jsp">作品自愿出售说明书作品自愿出售说明书</a></li>
                 <li><a href="helpd_del.jsp">图片传代编辑渠道试运行</a></li>
                 <li><a href="helpd_del.jsp">关于作品中涉及到的示例信息展示规范</a></li>
             
              </ul>
            </div>
            
              <div id="pages" class="pages_box2"></div>


								<script>
                                laypage({
                                    cont: ('pages'),   //容器。值支持id名、原生dom对象，jquery对象,
                                    pages: 10,              //分页数。一般通过服务端返回得到
                                    curr:1,                 //当前页。默认为1
                                    groups: 5,              //连续显示分页数  默认为5
                                    skin: '#e8474b',           //控制分页皮肤。目前支持：molv、yahei、flow  也可以自定义 
                                    skip: true,             //是否开启跳页
                                    first:'首页',           //用于控制首页  默认false
                                    last: '尾页',           //用于控制尾页  如：last: '尾页' 如：last: false，则表示不显示首页项
                                    prev:'上一页',           //用于控制上一页。若不显示，设置false即可
                                    next:'下一页',           //用于控制下一页。若不显示，设置false即可
                                    jump: function(obj, first){
                                    //触发分页后的回调，函数返回两个参数。 得到了当前页，用于向服务端请求对应数据
                                     var curr = obj.curr;
                                    }  
                                    
                                });
                                </script>  
            
       
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
