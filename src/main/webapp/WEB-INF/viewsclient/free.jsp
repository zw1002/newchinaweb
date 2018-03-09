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
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/css/normalize.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/css/demo.css" />
<link href="<%=basePath%>/static/css/laypage.css" type="text/css" rel="stylesheet" >
<script src="<%=basePath%>/static/js/laypage.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/jquery1.42.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/jquery.SuperSlide.2.1.1.js"></script>

    <script src="<%=basePath%>/static/js/imagesloaded.pkgd.min.js"></script>
    <script src="<%=basePath%>/static/js/masonry.pkgd.min.js"></script>
    <script src="<%=basePath%>/static/js/anime.min.js"></script>
    <script src="<%=basePath%>/static/js/main.js"></script>
    <script type="text/javascript">
        $(function(){
            ;
            $('.ss_btn').click(function () {
                document.location.href = '<%=basePath%>/seachs/toSeachs.do?seachTxt='+$('.inp_txt').val();
            });
        });
        var queryPara={worktype:'00,10,20,30',workprice:2,downloadcount:0,newup:0,collectioncount:0,offset:0,count:20};
        $(document).ready(function () {
            //隐藏注册/按钮登录    显示个人中心/个人空间
            var firstname="${userinfo.getFristname()}";
            if(firstname != ""){
                $("#beferLogin").css("display","none");
                $("#backLogin").css("display","block");
            }
            <%--//初始设计分类--%>
            <%--var classData=getAjaxData('<%=basePath%>/general/getGroupClass.do',{type:'设计分类'},false);--%>
            <%--if(classData!=null) {--%>
                <%--$('.fl_nav').html('');--%>
                <%--var htmlVal=" <a uid=\"00\" href=\"javascript:\" class=\"on\">全部</a>";--%>
                <%--for(var i=0;i<classData.content.length;i++){--%>
                    <%--htmlVal+="<a uid='"+classData.content[i].keyvalue+"' href=\"javascript:\">"+classData.content[i].typename+"</a>";--%>
                <%--}--%>

                <%--$('.fl_nav').html(htmlVal);--%>
            <%--}--%>

            $(".fl_nav>a").click(function(){
                $(this).parents(".fl_nav").find("a").removeClass("on");
                $(this).addClass("on");
                queryPara.worktype = $(this).attr('utype')==""?'00,10,20,30':$(this).attr('utype');
                outPutQueryResult( getAjaxData('<%=basePath%>/general/seachWorks.do',queryPara,true),0);
            });

            $(".px_box>a").click(function(){
                $(this).parents(".px_box").find("a").removeClass("on");
                $(this).addClass("on");

                queryPara={worktype:'00,10,20,30',workprice:2,downloadcount:0,newup:0,collectioncount:0,offset:0,count:20};

                queryPara.worktype = $(".fl_nav .on").attr('utype')==""?'00,10,20,30':$(".fl_nav .on").attr('utype');
                if($(this).text()=="热门下载")
                    queryPara.downloadcount=1;
                else  if($(this).text()=="默认排序")
                    queryPara.newup=1;
                else
                    queryPara.collectioncount=1;
                outPutQueryResult( getAjaxData('<%=basePath%>/general/seachWorks.do',queryPara,true),0);
            });
            outPutQueryResult( getAjaxData('<%=basePath%>/general/seachWorks.do',queryPara,true),0);

        });
        function getAjaxData(url,para,isAsync) {
            var rtnVal=null;
            $.ajax({
                url: url,
                type: "POST",
                data:para,
                async: false,
                success: function (data) {
                    if(data!="failed"){
                        data=  JSON.parse(data)
                        if(data.code !=undefined){
                            if(data.code=="0000")
                                rtnVal=data;
                        }
                        else {
                            if (data.length > 0)//.code=="0000"
                                rtnVal = data;
                        }
                    }
                },
                error:function (err) {
                }
            });
            return rtnVal;
        }

        function outPutQueryResult(resultData,isCount) {

            if(resultData!=null){
                var gridItems="<div class=\"grid__sizer\"></div>";
                $('.grid,.grid--type-a').html('');
                if(resultData.length==0)
                {
                    $('.grid,.grid--type-a').html('未加载到数据'); $('.grid,.grid--type-a').css('height','0px');
                    return;
                }
                for(var i=0;i<resultData.length;i++){
                    gridItems+="\t<div class=\"grid__item\">\n" +
                        "\t\t\t\t\t\t<a class=\"grid__link\" href=\"<%=basePath%>/design/toDesignDel.do?uid="+resultData[i].uid+"\"><img class=\"grid__img\" src=\"<%=basePath%>"+resultData[i].worksurl+"\" alt=\"\" /></a>\n" +
                        "                        <div class=\"list_txt_box\">\n" +
                        "                          <h2>"+resultData[i].worksname+"</h2>\n" +
                        "                          <p><a href=\"javascript:\" class=\"zan\">"+resultData[i].ticknums+"</a> | <a href=\"javascript:\" class=\"down\">"+resultData[i].downcount+"</a></p>\n" +
                        "                        </div>\n" +
                        "                      \n" +
                        "\t\t\t\t\t</div>";
                }
                $('.grid,.grid--type-a').html(gridItems);
                gridInit();
            }
            else {$('.grid,.grid--type-a').html('未加载到数据');
                $('.grid,.grid--type-a').css('height','0px');}
            if(isCount==0){
                //重新获取查询结果记录数
                var recordCounts=0;
                queryPara.count=null;
                var rdata =getAjaxData('<%=basePath%>/general/seachWorks.do',queryPara,false)
                queryPara.count=20;
                if(rdata!=null)
                    recordCounts=Math.ceil(rdata.length/queryPara.count);
                //初始化分页控制
                laypage({
                    cont: ('pages'),   //容器。值支持id名、原生dom对象，jquery对象,
                    pages: recordCounts,              //分页数。一般通过服务端返回得到 总页数
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
                        //alert(curr);
                        if(!first){
                            queryPara.offset=(curr-1)*queryPara.count;

                            outPutQueryResult( getAjaxData('<%=basePath%>/general/seachWorks.do',queryPara,true),1);
                        }
                    }

                });
            }
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
      document.location.href = '<%=basePath%>/helpd/toHelp.do';
  }
  //跳转免费下载页面
  function toFreeDel(uid){
      document.location.href = '<%=basePath%>/free/toFreeDel.do?uid='+uid;
  }
  //跳转到求助求图页面
  function toHelp(){
      document.location.href = '<%=basePath%>/help/toHelp.do';
  }
  //跳转到注册页面
  function toRegister(){
      document.location.href = '<%=basePath%>/signin/register.do';
  }
  //跳转到登录页面
  function toLogin(){
      document.location.href = '<%=basePath%>/signin/login.do';
  }
  //跳转到会员中心页面
  function toMember(){
      document.location.href = '<%=basePath%>/member/toMember.do';
  }
  //跳转到会员空间页面
  function toHomepage(){
      document.location.href = '<%=basePath%>/homepage/toHomepage.do';
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
              <li><a href="#" onclick="toDesign()">设 计</a> <p class="point_d"></p></li>
              <li><a href="#" onclick="toPhotography()">摄影图库</a> <p class="point_d"></p></li>
              <li><a href="#" onclick="toMultimedia()">道具新品</a> <p class="point_d"></p></li>
              <li><a href="#" onclick="toWedding()">婚 秀</a> <p class="point_d"></p></li>
              <li><a href="#" onclick="toHelp()">求图求助</a> <p class="point_d"></p></li>
              <li><a class="active" href="#" onclick="toFree()">免费下载</a> <p class="point_d"></p></li>
          </ul>
      </div><!-- nav -->
      
      
      
      </div><!-- top -->
   </header>
   
     <div class="bg_f5"> 
     
   <div class="hlx_banner" style="background:url(<%=basePath%>/static/images/banner_sj.png) no-repeat top center;"></div>
   
 
     <div class="wrap">
     
            <div class="hlx_fld">
              <table width="100%">
                 <tr>
                    <td><b>系列分类：</b></td>
                    <td>
                     <div class="fl_nav">
                       <a href="javascript:" class="on">全部</a>
                       <a utype="00" href="javascript:">设计</a>
                       <a utype="10" href="javascript:">摄影</a>
                       <a utype="30" href="javascript:">婚秀</a>
                       <a utype="20" href="javascript:">道具</a>
                     </div>
                    </td>
                 </tr>
              </table>
            </div>
            
            
            <div class="px_box">
               <a href="javascript:" class="on">默认排序</a>|<a href="javascript:">收藏</a>|<a href="javascript:">热门下载</a>        
            
            </div>
            
            
            <main>
			<div class="content content--center">
				<div class="grid grid--type-a">

				</div><!-- grid -->
				</div>
		</main>

<div id="pages" class="pages_box"></div>
    </div><!-- wrap -->
    </div><!-- bg_f5 -->
   
   <!-- 公共底部 -->
   <footer style="background:#fff;">
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
