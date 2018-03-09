<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    String tuid=request.getAttribute("tuid").toString();
%>
<html>
<head>
    <meta charset="utf-8">
    <title>婚秀中国网</title>
    <link rel="icon" href="<%=basePath%>/static/images/ico.ico" type="image/x-icon"/>
    <link href="<%=basePath%>/static/css/global.css" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>/static/css/index.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/static/css/normalize.css" />
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/static/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/static/css/demo.css" />
    <link href="<%=basePath%>/static/css/laypage.css" type="text/css" rel="stylesheet" >
    <script src="<%=basePath%>/static/js/laypage.js"></script>
    <script type="text/javascript" src="<%=basePath%>/static/js/jquery1.42.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>/static/js/jquery.SuperSlide.2.1.1.js"></script>

    <script src="<%=basePath%>/static/js/imagesloaded.pkgd.min.js"></script>
    <script src="<%=basePath%>/static/js/masonry.pkgd.min.js"></script>
    <script src="<%=basePath%>/static/js/anime.min.js"></script>
    <script src="<%=basePath%>/static/js/main.js"></script>
    <style type="text/css">
        .studyName {
            padding: 6px 0 22px 0;
        }
        .cityLborder {
            width: 100%;/*668px;*/
            border: 1px solid #eee;
        }
        .studyCont {
            width: 100%;/*668px;*/
            margin: 10px 30px 0 20px;
        }
        .floatClear {
            overflow: hidden;
        }

        .mb20 {
            margin-bottom: 20px;
        }
        .titleBox {
            width: 100%;
            height: 33px;
            border-bottom: 1px solid #eee;
        }
        .listTile {
            float: left;
            padding-left: 15px;
            height: 33px;
            line-height: 33px;
            font-size: 16px;
            color: #00A1E9;
        }
        .schoolInfor {
            width: 100%;/*668px;*/
            margin-left: 8px;
            padding: 19px 0 6px 0;
            overflow: hidden;
        }
        .zy-comment-header {
            background-color: #fff;
            font-size: 18px;
            font-weight: bold;
            line-height: 44px;
            color: #333;
            border-bottom: #db6d4c 4px solid;
            padding-left: 5px;
        }
        .zy-shadow {
            box-shadow: 0 2px 10px 0 rgba(0,0,0,.1);
        }
        .zy-comment-msg {
            padding: 10px 20px;
            background-color: #fff;
        }
        .zy-relative {
            position: relative!important;
        }
        .zy-comment-nologin {
            position: absolute;
            width: 100%;
            min-height: 100px;
            top: 0;
            text-align: center;
            line-height: 100px;
            color: #666;
        }
        .comment-textarea{
            margin: 10px;
            width: 98%;
            height: 80px;
        }
        .px_box11 {
            /* background-color: #fafafa; */
            color: #999;
            height: 40px;
            line-height: 40px;
            padding:15px 15px 0 15px;
            /* border: 1px solid #e1e1e1; */
            margin-bottom: 15px;
        }
    </style>
    <script type="text/javascript">
        $(function(){
            $('.ss_btn').click(function () {
                document.location.href = '<%=basePath%>/seachs/toSeachs.do?seachTxt='+$('.inp_txt').val();
            });
            $('#btn_send').click(function () {
                alert("评论功能暂未开通!");
            });
        });

        $(document).ready(function () {
            //隐藏注册/按钮登录    显示个人中心/个人空间
            var firstname="${userinfo.getFristname()}";

            $("#btn_send").css("display","none");
            if(firstname != ""){
                $("#beferLogin").css("display","none");
                $("#backLogin").css("display","block");
                $(".zy-comment-nologin").css("display","none");
                $("#btn_send").css("display","block");
            }
            var initInfo = getAjaxData("<%=basePath%>/trainMgr/GetTrainDetails.do",{"tuid":"<%=tuid%>"},false);
            $("#trainname").html("");
            $("#trainInfo").html("");
            $("#coursename").text("课程介绍");
            $("#traincontent").html("");

            if(initInfo!=null){
                $("#trainname").html("<span>"+initInfo.trainname+"--"+initInfo.coursename+"</span>  (0次浏览)");
                $("#trainInfo").html("<p>培训费用："+initInfo.price+"</p>\n" +
                        "                                <p>培训方式："+initInfo.trainmethod+" </p>\n" +
                        "                                <p>培训课时："+initInfo.trainclass+" </p>\n" +
                        "                                <%--<p>截止日期：长期 legtime</p>--%>\n" +
                        "                                <p>培训时间："+initInfo.traintime.substr(0,10)+" 至 "+ initInfo.endtime.substr(0,10)+"</p>\n" +
                        "                                <p>咨询电话："+initInfo.phone+"</p>\n" +
                        "                                <p>上课地点："+initInfo.trainaddress+"</p>");
                //$("#coursename").text(initInfo.coursename);
                $("#traincontent").html("&nbsp;&nbsp;&nbsp;"+initInfo.traincontent);

            }
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
                            if (data!=null || data !=undefined)//.code=="0000"
                                rtnVal = data;
                        }
                    }
                },
                error:function (err) {
                }
            });
            return rtnVal;
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

        <div class="px_box11" >
            <b>当前位置：首页&gt;名师面对面 </b>
        </div>

        <main>
            <div class="content content--center">
                <div class="panel panel-default">
                    <%--<div class="panel-heading">Panel heading</div>--%>
                    <div class="panel-body">
                        <div class="cityLborder studyName">
                            <div class="floatClear studyCont" id="trainname">

                            </div>
                            <div class="studyCont" id="trainInfo">

                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <!-- Default panel contents -->
                    <%--<div class="panel-heading">Panel heading</div>--%>
                    <div class="panel-body">
                        <div class="cityLborder mb20" >
                            <div class="titleBox floatClear">
                                <h2 class="listTile" id="coursename"> 课程介绍</h2>
                            </div>
                            <div class="schoolInfor">
                                <p style="margin:5px 0px;padding:0px;color:#999999;font-family:sans-serif;font-size:16px;line-height:20px;">
                                    <strong style="margin:0px;padding:0px;">
                                        <span id="traincontent" style="margin:0px;padding:0px;font-family:微软雅黑, 'Microsoft YaHei';color:#000000;">

                                        </span>
                                    </strong>
                                </p>
                                <%--<p style="margin:0px;padding:0px;color:#999999;font-family:sans-serif;font-size:16px;line-height:25px;">--%>
                                <%--<strong style="margin:0px;padding:0px;"><span style="margin:0px;padding:0px;font-family:微软雅黑, 'Microsoft YaHei';color:#000000;">【教学目标】</span></strong>--%>
                                <%--</p>--%>
                                <%--<p style="margin:0px;padding:0px;color:#999999;font-family:sans-serif;font-size:16px;line-height:25px;">--%>
                                <%--<span style="margin:0px;padding:0px;font-family:微软雅黑, 'Microsoft YaHei';color:#000000;">昂立高考体系名师授课，提前学习新课，教学进度略快于学校，重难点反复演练与讲解，帮助学生在高一阶段打下坚实的基础。</span>--%>
                                <%--</p>--%>
                                <%--<p style="margin:0px;padding:0px;color:#999999;font-family:sans-serif;font-size:16px;line-height:25px;">--%>
                                <%--&nbsp;--%>
                                <%--</p>--%>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="panel panel-default">
                    <!-- Default panel contents -->
                    <%--<div class="panel-heading">Panel heading</div>--%>
                    <div class="panel-body">
                        <div id="comment">
                            <div class="zy-comment-header">
                                评论
                            </div>
                            <div id="comment-body">
                                <div class="zy-comment-msg zy-shadow" id="comment-msg">
                                    <input type="hidden" name="msgid" value="">
                                    <div class="zy-relative">
                                        <textarea name="content" class="comment-textarea"  placeholder="我也来说两句..."></textarea>
                                        <div class="zy-comment-nologin">
                                            未登录，请先登录
                                        </div>
                                    </div>
                                    <div >
                                        <button type="button" class="btn btn-success" id="btn_send">发表</button>
                                    </div>
                                </div>
                            </div>

                            <!-- List group -->
                            <%--<ul class="list-group">--%>
                            <%--<li class="list-group-item">Cras justo odio</li>--%>
                            <%--<li class="list-group-item">Dapibus ac facilisis in</li>--%>
                            <%--<li class="list-group-item">Morbi leo risus</li>--%>
                            <%--<li class="list-group-item">Porta ac consectetur ac</li>--%>
                            <%--<li class="list-group-item">Vestibulum at eros</li>--%>
                            <%--</ul>--%>
                        </div>
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
