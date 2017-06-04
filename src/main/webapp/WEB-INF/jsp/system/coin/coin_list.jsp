<%@page import="com.privatenode.util.DateUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <!-- jsp文件头和头部 -->
    <%@ include file="../index/top.jsp" %>
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

    <!-- bootstrap & fontawesome -->
    <link rel="stylesheet" href="assets/css/bootstrap.css" />
    <link rel="stylesheet" href="assets/css/font-awesome.css" />

    <!-- page specific plugin styles -->

    <!-- text fonts -->
    <link rel="stylesheet" href="assets/css/ace-fonts.css" />

    <!-- ace styles -->
    <link rel="stylesheet" href="assets/css/ace.css" class="ace-main-stylesheet" id="main-ace-style" />

    <!--[if lte IE 9]>
    <link rel="stylesheet" href="assets/css/ace-part2.css" class="ace-main-stylesheet" />
    <![endif]-->

    <!--[if lte IE 9]>
    <link rel="stylesheet" href="assets/css/ace-ie.css" />
    <![endif]-->

    <!-- inline styles related to this page -->

    <!-- ace settings handler -->
    <script src="assets/js/ace-extra.js"></script>

    <!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->

    <!--[if lte IE 8]>
    <script src="assets/js/html5shiv.js"></script>
    <script src="assets/js/respond.js"></script>
    <script src="assets/js/jquery.js"></script>

    <!-- <![endif]-->

    <!--[if IE]>
    <script src="assets/js/jquery1x.js"></script>
    <![endif]-->
    <script type="text/javascript">
        if('ontouchstart' in document.documentElement) document.write("<script src='assets/js/jquery.mobile.custom.js'>"+"<"+"/script>");
    </script>
    <script src="assets/js/bootstrap.js"></script>

    <!-- page specific plugin scripts -->

    <!-- ace scripts -->
    <script src="assets/js/ace/elements.scroller.js"></script>
    <script src="assets/js/ace/elements.colorpicker.js"></script>
    <script src="assets/js/ace/elements.fileinput.js"></script>
    <script src="assets/js/ace/elements.typeahead.js"></script>
    <script src="assets/js/ace/elements.wysiwyg.js"></script>
    <script src="assets/js/ace/elements.spinner.js"></script>
    <script src="assets/js/ace/elements.treeview.js"></script>
    <script src="assets/js/ace/elements.wizard.js"></script>
    <script src="assets/js/ace/elements.aside.js"></script>
    <script src="assets/js/ace/ace.js"></script>
    <script src="assets/js/ace/ace.ajax-content.js"></script>
    <script src="assets/js/ace/ace.touch-drag.js"></script>
    <script src="assets/js/ace/ace.sidebar.js"></script>
    <script src="assets/js/ace/ace.sidebar-scroll-1.js"></script>
    <script src="assets/js/ace/ace.submenu-hover.js"></script>
    <script src="assets/js/ace/ace.widget-box.js"></script>
    <script src="assets/js/ace/ace.settings.js"></script>
    <script src="assets/js/ace/ace.settings-rtl.js"></script>
    <script src="assets/js/ace/ace.settings-skin.js"></script>
    <script src="assets/js/ace/ace.widget-on-reload.js"></script>
    <script src="assets/js/ace/ace.searchbox-autocomplete.js"></script>
    <script src="assets/js/echarts.min.js"></script>
    <script src="assets/js/theme/shine.js"></script>
    <![endif]-->
    <style type="text/css">
        .tab{border: 1px solid #dddddd;padding: 5px 0px;}
        .tab.active{background-color:#6fb3e0}
        .page{display:none}
        .page.active{display:block}

        .chart-page{margin-top:50px}

        .item{border: 1px solid #dddddd;padding: 2px 0px;}
        .item.active{background-color:#9abc32}
        .charts{display:none}
        .charts.active{display:block}
        .myChart{margin:0 auto;margin-top:50px;width: 1200px ;height: 700px;}
    </style>

    <link href="static/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="static/css/bootstrap-responsive.min.css" rel="stylesheet"/>
    <link href="static/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="static/css/datePick.css" rel="stylesheet"/>

    <script src="static/js/jquery-1.7.2.js"></script>
    <script type="text/javascript" src="plugins/zoomimage/js/layout.js"></script>
    <script type="text/javascript"
            src="static/js/bootstrap-datepicker.min.js"></script>
    <script type="text/javascript">
        $(top.hangge());
        //检索
        $(function() {
            $(".tab").click(function () {
                $(".tab").removeClass("active");
                $(this).addClass("active");

                $(".page").removeClass("active");
                $("#" + $(this).data("page")).addClass("active");
            });
            $(".item").click(function () {
                $("#" + $(this).data("page")).find(".item").removeClass("active");
                $(this).addClass("active");

                $("#" + $(this).data("page")).find(".charts").removeClass("active");
                $("#" + $(this).data("page")).find("." + $(this).data("tab")).addClass("active");
            });
            $.post("show.do", function (data) {
                console.log(data);
                chartTool("ETC--Diff",data.etc_diff);
                chartTool("ETC--Hash",data.etc_hash);
                chartTool("ETH--Diff",data.eth_diff);
                chartTool("ETH--Hash",data.eth_hash);
                chartTool("ZEC--Diff",data.zec_diff);
                chartTool("ZEC--Hash",data.zec_hash);
            },"json");
//            chartTool()

            function chartTool(id,data){
                var myChart = echarts.init(document.getElementById(id),'shine');
                var option = {
                    animation:false,

                    tooltip: {
                        trigger: 'axis',
                        formatter: function (params) {
                            console.log(params[0])
                            return 'Date: '+params[0].name + '<br />Val: ' + params[0].data;
                        }
                    },
                    toolbox: {
                        feature: {
                            dataZoom: {
                                yAxisIndex: 'none'
                            },
                            restore: {},
                            saveAsImage: {}
                        },
                        left:'80%'

                    },
                    dataZoom : {
                        show : true,
                        realtime : true,
                        start : 0,
                        end : 100,
                        backgroundColor:'#ffffff',
                        fillerColor:'#FCC0CD',
                        borderColor:'#04022C'
                    },
                    title: {
                        left: 'center',
                        text: id
                    },
                    xAxis: {
                        type: 'category',
                        name: 'time',
                        data: data.x
                    },
                    grid: {
                        top: 70,
                        bottom: 50,
                        containLabel: true
                    },
                    yAxis: {
                        type: 'value',
                        name: 'value'
                    },
                    series:{
                        type:'line',
                        smooth: true,
                        data: data.y
                    }
                };
                console.log(id);
                if(id=='ZEC--Diff' ||id=='ZEC--Hash'){
                    option.yAxis.name = 'value (K)'
                }
                myChart.setOption(option);
            }
        })
    </script>

</head>
<body>
<div class="container-fluid" >


    <div id="page-content" class="clearfix">

        <div class="row-fluid">

            <div class="row-fluid">

                <div id="navbar" class="navbar navbar-default          ace-save-state">
                    <div class="navbar-container ace-save-state" id="navbar-container">
                        <!-- #section:basics/sidebar.mobile.toggle -->
                        <button type="button" class="navbar-toggle menu-toggler pull-left" id="menu-toggler" data-target="#sidebar">
                            <span class="sr-only">Toggle sidebar</span>

                            <span class="icon-bar"></span>

                            <span class="icon-bar"></span>

                            <span class="icon-bar"></span>
                        </button>

                        <!-- /section:basics/sidebar.mobile.toggle -->
                        <div class="navbar-header pull-left">
                            <!-- #section:basics/navbar.layout.brand -->
                            <a href="#" class="navbar-brand">
                                <small>
                                    <i class="fa fa-leaf"></i>
                                    PRIVATE-NODE
                                </small>
                            </a>

                            <!-- /section:basics/navbar.layout.brand -->

                            <!-- #section:basics/navbar.toggle -->

                            <!-- /section:basics/navbar.toggle -->
                        </div>

                        <!-- #section:basics/navbar.dropdown -->
                        <div class="navbar-buttons navbar-header pull-right" role="navigation">
                            <ul class="nav ace-nav">

                                <!-- #section:basics/navbar.user_menu -->
                                <li class="light-blue">
                                    <a data-toggle="dropdown" href="#" class="dropdown-toggle">
                                        <img class="nav-user-photo" src="assets/avatars/user.jpg" alt="Jason's Photo" />
								<span class="user-info">
									<small>Welcome,</small>
									privateNode
								</span>

                                        <i class="ace-icon fa fa-caret-down"></i>
                                    </a>

                                    <ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
                                        <li>
                                            <a href="#">
                                                <i class="ace-icon fa fa-cog"></i>
                                                Settings
                                            </a>
                                        </li>

                                        <li>
                                            <a href="profile.html">
                                                <i class="ace-icon fa fa-user"></i>
                                                Profile
                                            </a>
                                        </li>

                                        <li class="divider"></li>

                                        <li>
                                            <a href="#">
                                                <i class="ace-icon fa fa-power-off"></i>
                                                Logout
                                            </a>
                                        </li>
                                    </ul>
                                </li>

                                <!-- /section:basics/navbar.user_menu -->
                            </ul>
                        </div>

                        <!-- /section:basics/navbar.dropdown -->
                    </div><!-- /.navbar-container -->
                </div>

                <!-- /section:basics/navbar.layout -->
                <div class="main-container ace-save-state" id="main-container">
                    <script type="text/javascript">
                        try{ace.settings.loadState('main-container')}catch(e){}
                    </script>

                    <!-- #section:basics/sidebar -->
                    <div id="sidebar" class="sidebar responsive ace-save-state">
                        <ul class="nav nav-list">
                            <li class="">
                                <a href="index.html">
                                    <i class="menu-icon fa fa-tachometer"></i>
                                    <span class="menu-text"> 控制台 </span>
                                </a>

                                <b class="arrow"></b>
                            </li>
                            <li ><a href="#/modellist/0">
                                <i class="icon-eye-open "></i> <span class="menu-text">展示</span>
                            </a>
                            </li>
                        </ul><!-- /.nav-list -->

                        <!-- #section:basics/sidebar.layout.minimize -->
                        <div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
                            <i id="sidebar-toggle-icon" class="ace-icon fa fa-angle-double-left ace-save-state" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>
                        </div>

                        <!-- /section:basics/sidebar.layout.minimize -->
                    </div>

                    <!-- /section:basics/sidebar -->
                    <div class="main-content">
                        <div class="main-content-inner">
                            <div class="page-content">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <!-- PAGE CONTENT BEGINS -->

                                        <div class="col-sm-12">

                                            <div class="col-md-offset-4 col-sm-4 row">
                                                <div class="col-sm-4 center tab active" data-page="page-A">
                                                    ETC
                                                </div>
                                                <div class="col-sm-4 center tab" data-page="page-B">
                                                    ETH
                                                </div>
                                                <div class="col-sm-4 center tab" data-page="page-C">
                                                    ZEC
                                                </div>
                                            </div>
                                            <div class="chart-page">
                                                <div class="page active" id="page-A">
                                                    <div class="col-md-offset-5 col-sm-2 row">
                                                        <div class="row">
                                                            <div class="col-sm-6 center item active" data-page="page-A" data-tab="charts-hour">
                                                                Diff
                                                            </div>
                                                            <div class="col-sm-6 item center"  data-page="page-A" data-tab="charts-day">
                                                                Hash
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="charts charts-hour active center row">
                                                            <div id="ETC--Diff" class="myChart"></div>
                                                        </div>
                                                        <div class="charts charts-day charts center row">
                                                            <div id="ETC--Hash" class="myChart"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="page" id="page-B">
                                                    <div class="col-md-offset-5 col-sm-2 row">
                                                        <div class="row">
                                                            <div class="col-sm-6 center item active" data-page="page-B" data-tab="charts-hour">
                                                                Diff
                                                            </div>
                                                            <div class="col-sm-6 item center"  data-page="page-B" data-tab="charts-day">
                                                                Hash
                                                            </div>
                                                        </div>


                                                    </div>
                                                    <div class="row">
                                                        <div class="charts charts-hour active center row">
                                                            <div id="ETH--Diff" class="myChart"></div>
                                                        </div>
                                                        <div class="charts charts-day charts center row">
                                                            <div id="ETH--Hash" class="myChart"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="page" id="page-C">
                                                    <div class="col-md-offset-5 col-sm-2 row">
                                                        <div class="row">
                                                            <div class="col-sm-6 center item active" data-page="page-C" data-tab="charts-hour">
                                                                Diff
                                                            </div>
                                                            <div class="col-sm-6 item center"  data-page="page-C" data-tab="charts-day">
                                                                Hash
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="row">
                                                        <div class="charts charts-hour active center row">
                                                            <div id="ZEC--Diff" class="myChart"></div>
                                                        </div>
                                                        <div class="charts charts-day charts center row">
                                                            <div id="ZEC--Hash" class="myChart"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- PAGE CONTENT ENDS -->
                                </div><!-- /.col -->
                            </div><!-- /.row -->
                        </div><!-- /.page-content -->
                    </div>
                </div><!-- /.main-content -->

                <div class="footer">
                    <div class="footer-inner">
                        <!-- #section:basics/footer -->
                        <div class="footer-content">
						<span class="bigger-120">
							Copyright © 2015 - 2017  private node 版权所有
						</span>
                        </div>

                        <!-- /section:basics/footer -->
                    </div>
                </div>

                <a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
                    <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
                </a>
            </div>
            </div>


            <!-- PAGE CONTENT ENDS HERE -->
        </div>
        <!--/row-->

    </div>
    <!--/#page-content-->
</div>
<!--/.fluid-container#main-container-->


<style type="text/css">
    li {
        list-style-type: none;
    }
</style>
<ul class="navigationTabs">
    <li><a></a></li>
    <li></li>
</ul>
</body>
</html>

