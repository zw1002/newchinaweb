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
    <script type="text/javascript" src="<%=basePath%>/static/js/jquery1.42.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>/static/js/jquery.SuperSlide.2.1.1.js"></script>
    <script type="text/javascript" src="<%=basePath%>/static/js/common.js"></script>
    <script type="text/javascript" src="<%=basePath%>/static/js/quick_links.js"></script>
    <link href="<%=basePath%>/static/layui/css/layui.css" rel="stylesheet" type="text/css"/>
    <script src="<%=basePath%>/static/layui/layui.js"></script>
    <link href="<%=basePath%>/static/css/base.css" rel="stylesheet" type="text/css" />
    <style>
        .layui-icon{
            font-size: 30px;
            margin-top: 15px;
            margin-left: 15px;
        }
        .cart_num{
            z-index: 999;
            position: fixed;
        }
    </style>
</head>
<body>
<header>
    <div class="top">

        <div class="top_line">
            <div class="top_wid">
                ${userinfo.getFristname()}     欢迎来到婚秀中国网
                <!-- 登录前 -->
                <div id="beferLogin" class="top_pos">
                    <a href="#" onclick="toLogin()">登录</a>|<a href="#" onclick="toRegister()">注册</a>
                </div>
                <!-- 登录后 -->
                <div id="backLogin" class="top_pos" style="display:none;">
                    <a href="#" onclick="toMember()">会员中心</a>|<a href="#" onclick="toHomepage()">会员空间</a>|<a id="car" href="<%=basePath%>/pay/toCar.do"></a>|<a href="<%=basePath%>/signin/signout.do">退出</a>
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
                <li><a class="active" href="#" onclick="toIndex()">首 页 </a> <p class="point_d"></p></li>
                <li><a href="#" onclick="toDesign()">设 计</a> <p class="point_d"></p></li>
                <li><a href="#" onclick="toPhotography()">摄影图库</a> <p class="point_d"></p></li>
                <li><a href="#" onclick="toMultimedia()">道具新品</a> <p class="point_d"></p></li>
                <li><a href="#" onclick="toWedding()">婚 秀</a> <p class="point_d"></p></li>
                <li><a href="#" onclick="toHelp()">求图求助</a> <p class="point_d"></p></li>
                <li><a href="#" onclick="toFree()">免费下载</a> <p class="point_d"></p></li>
            </ul>
        </div><!-- nav -->
    </div><!-- top -->
</header>
<!-- 图片轮播 -->
<div class="turn_pic">
    <div class="bd">
        <ul>
        </ul>
    </div>
    <div class="hd">
        <ul>
            <li class="pngbg"></li>
        </ul>
    </div>
</div>

</div>
<script type="text/javascript">
    $(function(){
        $('.ss_btn').click(function () {
            document.location.href = '<%=basePath%>/seachs/toSeachs.do?seachTxt='+$('.inp_txt').val();
        });
    });
    $(document).ready(function () {
        //隐藏注册/按钮登录    显示个人中心/个人空间
        var firstname="${userinfo.getFristname()}";
        if(firstname != ""){
            $("#beferLogin").css("display","none");
            $.ajax({
                url: "<%=basePath%>/pay/getCarData.do",
                type: "POST",
                async: false,
                success: function (data) {
                    var msg = eval("(" + data + ")");
                    $("#car").text("购物车("+msg.length+")");
                }
            });
            $("#backLogin").css("display","block");
        }
        //轮播图---有问题--图片全填充，会向下平铺，失去特效
        $.ajax({
            url:"<%=basePath%>/index/getPlayImg.do",
            type:"POST",
            success:function(data){
                var msg=eval("("+data+")");
                var str="";
                for(var i=0;i<msg.length;i++){
                    str += "<li style='background:url(<%=basePath%>"+msg[i].imgurl+") center top no-repeat; width: 1349px; height: 520px;'><a href='javascript:'></a></li>";
                }
                $(".turn_pic div ul").append(str);
                jQuery(".turn_pic").slide({ titCell:".hd ul", mainCell:".bd ul", effect:"fold", autoPlay:true, autoPage:true, delayTime:500, trigger:"click",interTime:4000,mouseOverStop:false});
            }
        });
        //交易动态
        getTransaction();
        //获取设计推荐作品
        recommendWorks("00");
        recommendWorks("10");
        recommendWorks("20");
        recommendWorks("30");
        //排行榜
        transactionRanking();
        transactionRankings();
        trainSortRanking();
    });
    //交易排行榜
    function transactionRanking(){
        var count=10;
        $.ajax({
            url: "<%=basePath%>/general/transactionRanking.do",
            type: "POST",
            data: {
                count:count
            },
            success: function (data) {
                var msg = eval("(" + data + ")");
                var str="";
                for(var i=0;i<msg.length;i++){
                    str += '<li> <a href="#"><img style="width:70px" src="<%=basePath%>'+msg[i].worksamllurl+'" /></a>'
                            +'<div class="txt_fr"> <h2><a href="#">'+msg[i].workname+'</a></h2> <p>'+msg[i].uptime+'</p> <p>下载量：'+msg[i].downcount+'</p> </div> </li>';
                }
                $("#jiaoyi ul").append(str);
                jQuery("#jyphb").slide({titCell:".hd ul",mainCell:"#jiaoyi ul",autoPage:true,effect:"top",autoPlay:true,vis:4,trigger:"click"});
            }
        });
    }
    //名师排行榜
    function trainSortRanking(){
        var count=10
        $("#mdm_con ul").html("");
        $.ajax({
            url: "<%=basePath%>/trainMgr/GetTrainList.do",
            type: "POST",
            data: {
                offest:0,count:count
            },
            success: function (data) {
                data=  JSON.parse(data)
                if(data.code !=undefined) {
                    if (data.code == "0000") {
                        var str="";
                        for (var i = 0; i < data.res.length; i++) {
                            str += ' <li>\n' +
                                    '                                <a href="<%=basePath%>/trainMgr/toTrainDetails.do?tuid='+data.res[i].teruid+'">' +
                                    '<img src="<%=basePath%>'+data.res[i].logoimg+'" /></a>\n' +
                                    '                                <div class="txt_fr">\n' +
                                    '                                    <h2><a href="<%=basePath%>/trainMgr/toTrainDetails.do?tuid='+data.res[i].teruid+'">'+data.res[i].trainname+'</a></h2>\n' +
                                    '                                    <p>'+data.res[i].createtime.substr(0,10)+'</p>\n' +
                                    '                                    <p>'+data.res[i].coursename+'</p>\n' +
                                    '                                </div>\n' +
                                    '                            </li>';
                        }
                    }
                    $("#mdm_con ul").append(str);
                    jQuery("#mdm_con").slide({titCell:".hd ul",mainCell:".bd ul",autoPage:true,effect:"top",autoPlay:true,vis:4,trigger:"click"});
                }
            }
        });
    }
    //婚秀排行榜
    function transactionRankings(){
        var count=10;
        $.ajax({
            url: "<%=basePath%>/general/transactionRankings.do",
            type: "POST",
            data: {
                count:count
            },
            success: function (data) {
                var msg = eval("(" + data + ")");
                var str="";
                for(var i=0;i<msg.length;i++){
                    str += '<li> <a href="#"><img src="<%=basePath%>'+msg[i].worksamllurl+'" /></a>'
                            +'<div class="txt_fr"> <h2><a href="#">'+msg[i].workname+'</a></h2> <p>'+msg[i].uptime+'</p> <p>下载量：'+msg[i].downcount+'</p> </div> </li>';
                }
                $("#hunxiu ul").append(str);
                jQuery("#hxphb").slide({titCell:".hd ul",mainCell:".bd ul",autoPage:true,effect:"top",autoPlay:true,vis:4,trigger:"click"});
            }
        });
    }
    //交易动态
    function getTransaction(){
        $(".infoList").html("");
        $.ajax({
            url:"<%=basePath%>/index/getTransaction.do",
            type:"POST",
            success:function(data){
                var msg=eval("("+data+")");
                var str="";
                for(var i=0;i<msg.length;i++){
                    str += "<li><a id='"+msg[i].workid+"' href='<%=basePath%>/design/toDesignDel.do?uid="+msg[i].workid+"' target='_blank'>"+msg[i].workname+"<span class='col_f00'>￥"+msg[i].worksprice+"</span>"+msg[i].time+"</a></li>";
                }
                $(".infoList").append(str);
                jQuery(".txtMarquee-left").slide({mainCell:".bd ul",autoPlay:true,effect:"leftMarquee",vis:4,interTime:50});
            }
        });
    }
    //设计等推荐作品接口
    function recommendWorks(type){
        var count=8;
        $.ajax({
            url: "<%=basePath%>/general/getRecommendWorks.do",
            type: "POST",
            data:{
                type:type,
                count:count
            },
            success: function (data) {
                var msg=eval("("+data+")");
                var str="";
                for(var i=0;i<msg.length;i++){
                    if(type == "00"){
                        str = "<li><a href='<%=basePath%>/design/toDesignDel.do?uid="+msg[i].uid+"'><img src='<%=basePath%>"+msg[i].samllurl+"'/>"
                                +"<div class='botm_txtd'><p>"+msg[i].worksname+"</p> </div> </a></li>";
                        $("#design").append(str);
                    }else if(type == "10"){
                        str = "<li><a href='<%=basePath%>/design/toDesignDel.do?uid="+msg[i].uid+"'><img src='<%=basePath%>"+msg[i].samllurl+"'/>"
                                +"<div class='botm_txtd'><p>"+msg[i].worksname+"</p> </div> </a></li>";
                        $("#photography").append(str);
                    }else if(type == "30"){
                        str = "<li><a href='<%=basePath%>/design/toDesignDel.do?uid="+msg[i].uid+"'><img src='<%=basePath%>"+msg[i].samllurl+"'/>"
                                +"<div class='botm_txtd'><p>"+msg[i].worksname+"</p> </div> </a></li>";
                        $("#wedding").append(str);
                    }else{
                        str = "<li><a href='<%=basePath%>/design/toDesignDel.do?uid="+msg[i].uid+"'><img src='<%=basePath%>"+msg[i].samllurl+"'/>"
                                +"<div class='botm_txtd'><p>"+msg[i].worksname+"</p> </div> </a></li>";
                        $("#multimedia").append(str);
                    }
                }
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
    //跳转到设计明细页面
    function toDesignDel(uid){
        document.location.href = '<%=basePath%>/design/toDesignDel.do?uid='+uid;
    }
    //跳转到摄影图库页面
    function toPhotography(){
        document.location.href = '<%=basePath%>/photography/toPhotography.do';
    }
    //跳转到摄影图库详情页面
    function toPhotographyDel(uid){
        document.location.href = '<%=basePath%>/photography/toPhotographyDel.do?uid='+uid;
    }
    //跳转到婚秀页面
    function toWedding(){
        document.location.href = '<%=basePath%>/wedding/toWedding.do';
    }
    //跳转到婚秀详情页面
    function toWeddingDel(uid){
        document.location.href = '<%=basePath%>/wedding/toWeddingDel.do?uid='+uid;
    }
    //跳转到道具页面
    function toMultimedia(){
        document.location.href = '<%=basePath%>/multimedia/toMultimedia.do';
    }
    //跳转到道具页面
    function toMultimediaDel(uid){
        document.location.href = '<%=basePath%>/multimedia/toMultimediaDel.do';
    }
    //跳转到免费下载页面
    function toFree(){
        document.location.href = '<%=basePath%>/free/toFree.do';
    }
    //跳转到求助求图页面
    function toHelp(){
        document.location.href = '<%=basePath%>/helpd/toHelp.do';
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
</script>

<div class="hei50px">

    <div class="txtMarquee-left">
        <div class="jy_tit"><img src="<%=basePath%>/static/images/jydt_tit.png" height="25" width="77" /></div>
        <div class="bd">
            <ul class="infoList">

            </ul>
        </div>
    </div>
</div><!-- hei50px -->
<!-- 设计 -->
<div class="wrap">
    <div class="tit_pic"><a href="<%=basePath%>/design/toDesign.do"><img src="<%=basePath%>/static/images/tit_pic1.png" height="70" width="207" /></a></div>
    <div class="hei380px">
        <div class="design_list da_img">
            <ul class="clearfix" id="design">
            </ul>
        </div><!-- design_list -->
        <div class="sj_fr">
            <div class="hong_tit"><h2>交易排行榜</h2> <a href="<%=basePath%>/seachs/toSeachs.do?jysort=jy">更多 ></a></div>
            <div class="phb_con" id="jyphb">
                <div class="hd">
                    <ul></ul>
                </div>
                <div id="jiaoyi" class="hxphb bd">
                    <ul>

                    </ul>
                </div>

            </div>
        </div><!-- sj_fr -->

    </div><!-- hei380px -->



</div><!-- wrap -->




<!-- 摄影图库 -->
<div class="bg_hs">
    <div class="wrap">
        <div class="tit_pic"><a href="#" onclick="toPhotography()"><img src="<%=basePath%>/static/images/tit_pic3.png" height="70" width="287" /></a></div>

        <div class="hei380px">


            <div class="design_list">
                <ul class="clearfix" id="photography">

                </ul>
            </div><!-- design_list -->


            <div class="sj_fr">
                <div class="hong_tit col_mdm"><h2>名师面对面</h2> <a href="<%=basePath%>/trainMgr/toTrainList.do">更多 ></a></div>
                <div class="phb_con" id="mdm_con">
                    <div class="hd">
                        <ul></ul>
                    </div>
                    <div class="hxphb bd">
                        <ul>
                            <li>
                                <a href="design_del.html"><img src="<%=basePath%>/static/images/sytk_pic5.png" /></a>
                                <div class="txt_fr">
                                    <h2><a href="design_del.html">天津爱明婚礼会馆</a></h2>
                                    <p>2016-07-08</p>
                                    <p>地址：艾尔艾尔儿</p>
                                </div>
                            </li>
                            <li>
                                <a href="design_del.html"><img src="<%=basePath%>/static/images/sytk_pic6.png" /></a>
                                <div class="txt_fr">
                                    <h2><a href="design_del.html">天津爱明婚礼会馆</a></h2>
                                    <p>2016-07-08</p>
                                    <p>地址：艾尔艾尔儿</p>
                                </div>
                            </li>
                            <li>
                                <a href="design_del.html"><img src="<%=basePath%>/static/images/sytk_pic7.png" /></a>
                                <div class="txt_fr">
                                    <h2><a href="design_del.html">天津爱明天津爱明婚礼会馆婚礼会馆</a></h2>
                                    <p>2016-07-08</p>
                                    <p>地址：艾尔艾艾尔艾尔儿尔儿</p>
                                </div>
                            </li>
                            <li>
                                <a href="design_del.html"><img src="<%=basePath%>/static/images/sytk_pic8.png" /></a>
                                <div class="txt_fr">
                                    <h2><a href="design_del.html">天津爱明婚礼会馆</a></h2>
                                    <p>2016-07-08</p>
                                    <p>地址：艾尔艾尔儿</p>
                                </div>
                            </li>
                            <li>
                                <a href="design_del.html"><img src="<%=basePath%>/static/images/sytk_pic5.png" /></a>
                                <div class="txt_fr">
                                    <h2><a href="design_del.html">天津爱明婚礼会馆</a></h2>
                                    <p>2016-07-08</p>
                                    <p>地址：艾尔艾尔儿</p>
                                </div>
                            </li>
                            <li>
                                <a href="design_del.html"><img src="<%=basePath%>/static/images/sytk_pic6.png" /></a>
                                <div class="txt_fr">
                                    <h2><a href="design_del.html">天津爱明婚礼会馆</a></h2>
                                    <p>2016-07-08</p>
                                    <p>地址：艾尔艾尔儿</p>
                                </div>
                            </li>
                            <li>
                                <a href="design_del.html"><img src="<%=basePath%>/static/images/sytk_pic7.png" /></a>
                                <div class="txt_fr">
                                    <h2><a href="design_del.html">天津爱明天津爱明婚礼会馆婚礼会馆</a></h2>
                                    <p>2016-07-08</p>
                                    <p>地址：艾尔艾艾尔艾尔儿尔儿</p>
                                </div>
                            </li>
                            <li>
                                <a href="design_del.html"><img src="<%=basePath%>/static/images/sytk_pic8.png" /></a>
                                <div class="txt_fr">
                                    <h2><a href="design_del.html">天津爱明婚礼会馆</a></h2>
                                    <p>2016-07-08</p>
                                    <p>地址：艾尔艾尔儿</p>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <script type="text/javascript">
                    jQuery("#mdm_con").slide({titCell:".hd ul",mainCell:".bd ul",autoPage:true,effect:"top",autoPlay:true,vis:4,trigger:"click"});
                </script>

            </div><!-- sj_fr -->

        </div><!-- hei380px -->


    </div><!-- wrap -->
</div><!-- bg_hs -->



<!-- 婚秀 -->
<div class="wrap">
    <div class="tit_pic"><a href="#" onclick="toWedding()"><img src="<%=basePath%>/static/images/tit_pic5.png" height="70" width="260" /></a></div>

    <div class="hei380px">


        <div class="design_list da_img hl_listd">
            <ul class="clearfix" id="wedding">

            </ul>
        </div><!-- design_list -->
        <div class="sj_fr">
            <div class="hong_tit col_hx"><h2>婚秀排行榜</h2> <a href="<%=basePath%>/seachs/toSeachs.do?hxsort=hx" >更多 ></a></div>
            <%--onclick="toWedding()"--%>

            <div class="phb_con" id="hxphb">
                <div class="hd">
                    <ul></ul>
                </div>

                <div id="hunxiu" class="hxphb bd">
                    <ul>

                    </ul>
                </div>
            </div>
        </div><!-- sj_fr -->

    </div><!-- hei380px -->
</div><!-- wrap -->

<!-- 道具新品 -->
<div class="bg_hs">
    <div class="wrap">
        <div class="tit_pic"><a href="#" onclick="toMultimedia()"><img src="<%=basePath%>/static/images/tit_pic4.png" height="70" width="284" /></a></div>
        <div class="hei380px">
            <div class="design_list da_img">
                <ul class="clearfix" id="multimedia">

                </ul>
            </div><!-- design_list -->
            <div class="sj_fr">
                <div class="hong_tit xp_titd col_djxp"><h2>新品发布</h2> <a href="#" onclick="toMultimedia()">更多 ></a></div>
                <div class="xpfb_img"> <a href="#"><img src="<%=basePath%>/static/images/xpfb_pic.png" /></a></div>
            </div><!-- sj_fr -->

        </div><!-- hei380px -->
    </div><!-- wrap -->
</div><!-- bg_hs -->
<div class="find_box">
    <h2>找我们，您就对了</h2>
    欢迎全国行业领先品牌企业、知名集团联系洽谈合作
</div>
<!--购物车-->
<!--
<div class="mui-mbar-tabs">
    <div class="quick_link_mian">
        <div class="quick_links_panel">
            <div id="quick_links" class="quick_links">
                <li id="shopCart">
                    <a href="#" class="message_list">
                        <i class="layui-icon"></i>
                        <div class="span">购物车</div>
                        <span class="cart_num">0</span>
                    </a>
                </li>
            </div>
        </div>
        <div style="margin-top: 60px" id="quick_links_pop" class="quick_links_pop hide">
        </div>
    </div>
</div>
-->
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
