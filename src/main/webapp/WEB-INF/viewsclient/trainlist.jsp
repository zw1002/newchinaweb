<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    //String seachTxt=request.getAttribute("seachTxt").toString();
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
    <link href="<%=basePath%>/static/layui/css/layui.css" type="text/css" rel="stylesheet" >
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

            $('.ss_btn').click(function () {
                document.location.href = '<%=basePath%>/seachs/toSeachs.do?seachTxt='+$('.inp_txt').val();
            });
        });
        var queryPara=null;
        $(document).ready(function () {
            //隐藏注册/按钮登录    显示个人中心/个人空间
            var firstname="${userinfo.getFristname()}";
            if(firstname != ""){
                $("#beferLogin").css("display","none");
                $("#backLogin").css("display","block");
            }


            $("#sortDiv>a").click(function(){
                $(this).parents("div").find("a").removeClass("on");
                $(this).addClass("on");
                if($(this).text()=="阅读数量")
                    queryPara.downloadcount=1;
                else  if($(this).text()=="默认排序")
                    queryPara.newup=1;
                else//评论数量
                    queryPara.collectioncount=1;
                outPutQueryResult( getAjaxData('<%=basePath%>/trainMgr/GetTrainList.do',queryPara,true),0);
            });

            outPutQueryResult( getAjaxData('<%=basePath%>/trainMgr/GetTrainList.do',{offset:0,count:10},true),0);

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
                var gridItems="";
                $('.tralist,.zy-art-list').html('');
                if(resultData.count==0)
                {
                    $('.tralist,.zy-art-list').html('未加载到数据');  $('.tralist,.zy-art-list').css('height','0px');
                    return;
                }
                for(var i=0;i<resultData.res.length;i++){
                    gridItems+="<li class=\"zy-art-item zy-xs-art-item zy-sm-art-item\">\n" +
                        "                            <a target=\"_blank\" class=\"zy-art-img\" href=\"<%=basePath%>/trainMgr/toTrainDetails.do?tuid="+resultData.res[i].teruid+"\">\n" +
                        "                                <img class=\"layui-anim\" src=\"<%=basePath%>"+resultData.res[i].logoimg+"\">\n" +
                        "                            </a>\n" +
                        "                            <div class=\"zy-art-body\">\n" +
                        "                                <div class=\"zy-art-title\">\n" +
                        "                                    <a target=\"_blank\" href=\"<%=basePath%>/trainMgr/toTrainDetails.do?tuid="+resultData.res[i].teruid+"\">"+resultData.res[i].trainname+"--"+resultData.res[i].coursename+"</a>\n" +
                        "                                </div>\n" +
                        "                                <div class=\"zy-art-desc\">\n" +
                        "                                    <p>"+(resultData.res[i].traincontent.length>120?resultData.res[i].traincontent.substr(0,120):resultData.res[i].traincontent)+"</p>\n" +
                        "\n" +
                        "                                </div>\n" +
                        "                                <div class=\"zy-art-attached\">\n" +
                        "\n" +
                        "                                    <span title=\"发布时间："+resultData.res[i].createtime.substr(0,10)+"\">\n" +
                        "                                       发布时间："+resultData.res[i].createtime.substr(0,10)+"\n" +
                        "                                    </span>\n" +
                        "                                    <span class=\"zy-art-tags \">\n" +
                        "                                        培训方式："+resultData.res[i].trainmethod+"\n" +
                        "                                    </span>\n" +
                        "                                    <span class=\"zy-art-attached-right\" title=\"阅读量："+resultData.res[i].vnums+"\">\n" +
                        "                                       阅读量："+resultData.res[i].vnums+"\n" +
                        "                                    </span>\n" +
                        "                                    <span class=\"zy-xs-hide zy-sm-hide\" title=\"评论数："+resultData.res[i].cnums+"\">\n" +
                        "                                       评论数："+resultData.res[i].cnums+"\n" +
                        "                                    </span>\n" +
                        "                                </div>\n" +
                        "                            </div>\n" +
                        "                        </li>";
                }
                $('.tralist,.zy-art-list').html(gridItems);

            }
            else {
                $('.tralist,.zy-art-list').html('未加载到数据');
                $('.tralist,.zy-art-list').css('height','0px');
            }
            if(isCount==0) {
                //重新获取查询结果记录数
                var recordCounts = 0;

                if (resultData.count >0) {
                    recordCounts = Math.ceil(resultData.count / 10);

                }
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
                            curr=(curr-1)*10;

                            outPutQueryResult( getAjaxData('<%=basePath%>/trainMgr/GetTrainList.do',{offset:curr,count:10},true),1);
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
      document.location.href = '<%=basePath%>/free/toFree.do';
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

    <style>
        .tralist{margin-bottom: 20px;}
        .tralist ul{
            margin: 0;
            padding: 0;
            -webkit-tap-highlight-color: rgba(0,0,0,0);
            display: block;
            list-style-type: disc;
            -webkit-margin-before: 1em;
            -webkit-margin-after: 1em;
            -webkit-margin-start: 0px;
            -webkit-margin-end: 0px;
            -webkit-padding-start: 40px;}
        .tralist li{
            list-style: none;
            /*margin: 0;*/
            /*padding: 0;*/
            -webkit-tap-highlight-color: rgba(0,0,0,0);}

        .zy-art-item {
            margin-top: 20px;
            background-color: #e5e9ef;
            background-color: #fff;
            box-shadow: 0 0 2px 0 rgba(0,0,0,.1);
            padding: 15px;
            position: relative;
            border-bottom: 1px solid #fff;
            transition: all .6s;
            border-bottom: 1px solid #ccc;}
        /*.zy-sm-art-item {*/
            /*padding: 10px;*/
        /*}*/
        .zy-art-img {
            display: inline-block;
            overflow: hidden;
            position: absolute;
        }
        .zy-art-item img, .zy-art-img {
            width: 196px;
            height: 150px;
        }
        .zy-art-item a {
            color: #333;
            text-decoration: none;
        }
        .zy-art-item img {
            border-radius: 2px;
            transition: all 1s;
        }
        .zy-art-item .layui-anim {
            -webkit-animation-duration: .3s;
            animation-duration: .3s;
            -webkit-animation-fill-mode: both;
            animation-fill-mode: both;
        }
        .zy-art-item img {
            display: inline-block;
            border: none;
        }
        a {
            color: #333;
            text-decoration: none;
        }
        .zy-art-item a:-webkit-any-link {
            /*color: -webkit-link;*/
            /*text-decoration: underline;*/
            cursor: auto;
        }
        .zy-art-img+.zy-art-body {
            margin-left: 220px;
        }
        .zy-art-body {display: block;
            top: 25px;
            right: 0;
            left: 40px;
        }
        .zy-art-title {
             padding: 5px;
             overflow: hidden;
             text-overflow: ellipsis;
             white-space: nowrap;
             font-size: 18px;
             line-height: 26px;
         }
        .zy-art-img+.zy-art-body .zy-art-desc {
            border-left: 0;
        }
        .zy-art-desc {
            padding: 5px 10px;
            margin-right: 10px;
            overflow: hidden;
            text-overflow: ellipsis;
            color: #999;
            font-size: 14px;
            -webkit-box-orient: vertical;
            -webkit-line-clamp: 3;
            overflow: hidden;
            background: #f8f8f8;
            border-left: 3px solid #009688;
            border-left: 3px solid #69c;
            margin-top: 10px;
            margin-bottom: 10px;
            padding: 15px;
            line-height: 1.5rem;
        }
        .zy-art-desc p {
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-box-orient: vertical;
            -webkit-line-clamp: 3;
        }
         .zy-art-attached  .zy-art-attached a {
            color: #14b0e6;
        }
        .zy-art-attached {
            padding: 5px;
        }
        .zy-art-attached span:first-child {
            margin-left: 10px;    color: #14b0e6;
        }
        .zy-art-attached span {
            margin-right: 30px;    color: #14b0e6;
        }
    </style>
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
                 <a href="#" onclick="toMember()">会员中心</a>|<a href="#" onclick="toHomepage()">会员空间</a>
                 <!--<a href="pay.html" class="vip_lj">成为VIP</a>|<a href="upload.html" class="sc_icon">我要上传</a>|<a href="collection_2.html">我的收藏（<span class="col_f00">2</span>）</a>-->
             </div>
         </div>
      </div><!-- top_line -->
      <div class="top_wid logo_con">
          <a href="#" onclick="toIndex()" class="fl"><img src="<%=basePath%>/static/images/logo.png" height="62" width="217" /></a>
         <div class="ss_bg fl">
            <input name="" type="text" placeholder="请输入搜索内容" value="" class="inp_txt">
            <input type="button" value="搜 索" class="ss_btn" />
         </div>
         
         <div class="phone_fr">
            <h2>400-879-51747</h2>
            <p>24小时服务热线</p>
         </div>
      </div><!-- top_wid -->
      
      <div class="nav">
          <ul class="clearfix">
              <li><a class="active" href="#" onclick="toIndex()">首 页 </a> <p class="point_d"></p></li>
              <li><a href="#" onclick="toDesign()">设 计</a> <p class="point_d"></p></li>
              <li><a href="#" onclick="toPhotography()">摄影图库</a> <p class="point_d"></p></li>
              <li><a href="#" onclick="toMultimedia()">道具新品</a> <p class="point_d"></p></li>
              <li><a href="#" onclick="toWedding()">婚 秀</a> <p class="point_d"></p></li>
              <li><a href="#" onclick="toHelp()">求图求助</a> <p class="point_d"></p></li>
              <li><a  href="#" onclick="toFree()">免费下载</a> <p class="point_d"></p></li>
          </ul>
      </div><!-- nav -->
      
      
      
      </div><!-- top -->
   </header>
   
     <div class="bg_f5">
     <div class="wrap">

            <div class="px_box" >
                <b>当前位置：首页&gt;名师推荐&gt;</b>
                <%--<div id="sortDiv" style="float:right;right:0px;"> 排序方式：--%>
                    <%--<a href="javascript:" class="on">默认排序</a>|<a href="javascript:">浏览数量</a>|<a href="javascript:">评论数量</a>--%>
                <%--</div>--%>
            </div>
            
            <main>
			<div class="content content--center">
				<div class="tralist">
                    <%--<h2>文章推荐</h2>--%>
                    <ul class="zy-art-list">
                    </ul>
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
