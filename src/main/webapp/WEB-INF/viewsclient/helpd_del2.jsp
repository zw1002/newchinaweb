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
               <li><a href="<%=basePath%>/helpd/toAboutUs.do" class="active">关于我们</a></li>
           </ul>
       </div>
   
   
    <div class="bg_f5"> 
     <div class="wrap" style="padding-top:15px;">
     
     <div class="xq_txt">
         
          <h2>作品权利保证书作品权利保证书</h2>

 
 
<p>根据2017年度招收飞行学员计划，空军今年将招收第11批女飞行学员35名。</p>
 
<p>招收女飞行学员的基本条件：普通高中应届、往届毕业生，年龄不小于17周岁，不大于20周岁(1997年8月31日至2000年8月31日出生)，身高在165-185cm之间(未满18周岁的身高164cm合格)，体重在标准体重的85-120%之间，双眼裸眼C字表视力均在0.8以上，未做过视力矫治手术，无色盲、色弱、斜视等。</p>
 
<p>2017年，是空军时隔4年后再次招收女飞行学员，与以往相比，第11批女飞招收选拔作出较大调整改进，主要有三个方面：一是扩大招收选拔范围，从第10批的20个省(自治区、直辖市)扩大到今年的31个。二是改进计划下达方式，由过去的分省下达招飞计划，调整为在全国范围内择优录取。三是统一招飞录取原则，要求考生必须政治考核、体格检查、心理选拔全部合格，且高考成绩达到当地一本线，方具备投档资格，空军按"高考成绩与当地一本线的比值"由高到低顺序录取。</p>

 <p style="text-align:center"><img src="<%=basePath%>/static/images/hlx_big.png" /> </p>
 
<p>志在空天、热爱飞行的北京市女高中毕业生，可向北京选拔中心咨询详情，也可通过空军招飞网、"华北招飞"微信公众号(HBZF-2014)了解具体招收办法。</p>
 
<p>随着空军武器装备加速换代，适合女性从事的飞行岗位越来越多，女飞行员有了更大发展空间。这次调整改进招收办法，有利于把最优质的学生选上来，提高空军招飞整体质量，充分展示中华女性自尊、自信、自立、自强的精神风貌。</p>
 
<p>招收的女飞行学员将集中编班组教施训，有助于加强培养管理，提升作战训练水平，也为选拔女飞行领导干部、女航天员提供了更多选择。今后，女飞行员将驾驭更多机种执行多样化任务，广泛参与中外联演联训、国际性交流等活动，更好地展示大国空军、现代空军形象。</p>
 
<p>据悉，空军从1951年开始招收女飞行学员，先后招收10批580余名。60多年来，先后涌现出第一名女试飞员张玉梅、优秀专机机长汪云、中国十大女杰岳喜翠、临危不惧挽救飞机的一等功臣刘晓连、空军第一位女航空兵师长程晓健、战胜疾病重返蓝天的女参谋长刘文力，并输送了刘洋和王亚平两位女航天员，她们不负党和人民重托，矢志空天，奋勇拼搏，向全世界展示了中国新时代女性的巾帼风采，为空军建设和国家载人航天事业发展做出了重要贡献。</p>
 
<h3>报名时间及方法：</h3>
 
<p>符合以上报名基本条件，且预估高考文化成绩可达一本分数线的，可通过以下任意一种方式报考。</p>
 
<p>1.网上报名。登录空军招飞网：www.kjzfw.net，通过"点击进入网上报名"导航条进入报名系统，并报学校备案。</p>
 
<p>2.短信报名。编辑短信：个人姓名、性别、地市、学校、身份证号、文理科、考生号(14位)、家长联系电话，发送到手机15101159341，并报学校备案。</p>
 
<p>报名时间截止到2017年6月27日。</p>
 
<h3>检测安排：</h3>
 
<p>1.资格审查和初选。各地市招生部门与北京选拔中心共同对报考学生进行资格审查。通过资格审查的，北京选拔中心于6月28、29日分两批组织在北京进行初选(以电话或短信通知为准)。</p>
 
<p>检测地点：北京市海淀区昌运宫15号空军航空医学研究所附属医院(466医院)体检中心。具体乘车路线：</p>
 
<p>①北京站乘地铁2号线至西直门站，A1口出站，换乘632路到北洼路站下车，步行500米即到。</p>
 
<p>②北京南站乘地铁4号线至动物园站，A口出站，换乘632或360路到北洼路站下车，步行500米即到。</p>
 
<p>③北京西站乘地铁9号线至国家图书馆站，A口出站，换乘689路到北洼路站下车，步行600米即到。</p>
 
<p>2.定选。初选合格学生，由北京选拔中心统一组织参加空军招飞定选。</p>
 
<p>检测地点：北京市海淀区闵航路25号空军招飞局。</p>
 
<h3>携带物品及注意事项：</h3>
 
<p>(1)参检学生必须携带身份证，自备水杯、洗漱用具、运动内衣和运动鞋。</p>
 
<p>(2)考生必须准时报到，不得私自改变报到日期，如确需调整，提前电话告知北京选拔中心计划科。</p>
 
<p>(3)考生近期务必科学用眼，保护视力，报到前要认真清理个人卫生，保持衣着整洁。</p>
 
<p>(4)考生往返途中尽量减少中转，提高自我保护意识，确保安全。需携带火车、长途汽车等有效票据，作为报销凭据。</p>
 
<p>北京选拔中心定选咨询电话：010-51381710</p>
 
<p>北京检测站咨询电话：15101159341</p>
         
          
          </div>
       
       
        
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
