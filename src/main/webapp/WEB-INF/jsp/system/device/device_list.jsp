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
        function searchForm() {
            top.jzts();

//			if($("#registration_time").val()=="今天"){
//				var dateStr = show();
//				$("#registration_time").val(dateStr);
//			}
//			if($("#active").val()=="今天"){
//				var dateStr = show();
//				$("#active").val(dateStr);
//			}
            alert()
            $("#Form").submit();
        }
        function show() {
            var mydate = new Date();
            var str = "" + mydate.getFullYear() + "-";
            str += (mydate.getMonth() + 1 < 10 ? "0" + (mydate.getMonth() + 1) : mydate.getMonth() + 1) + "-";
            str += mydate.getDate() < 10 ? "0" + (mydate.getDate()) : mydate.getDate();
            return str;
        }

        //新增
        function add() {
            window.location.href = "device/goAdd.do?tm=" + new Date().getTime();
        }

        //删除
        function del(id) {
            top.jzts();
            if (confirm("确定要删除?")) {
                var url = "<%=basePath%>device/delete.do?id=" + id + "&tm=" + new Date().getTime();
                $.get(url, function (data) {
                    if ("success" == data) {
                        window.location.href = "device/listAll.do?tm=" + new Date().getTime();
                    } else {
                        alert("删除失败");
                    }

                });
            }
        }

        //修改
        function edit(id) {
            window.location.href = "device/goEdit.do?id=" + id + "&tm=" + new Date().getTime();
        }


        //全选 （是/否）
        function selectAll() {
            var checklist = document.getElementsByName("ids");
            if (document.getElementById("zcheckbox").checked) {
                for (var i = 0; i < checklist.length; i++) {
                    checklist[i].checked = 1;
                }
            } else {
                for (var j = 0; j < checklist.length; j++) {
                    checklist[j].checked = 0;
                }
            }
        }
        //下拉日期框
        $(function () {
            $('.date-picker').datepicker('setDate', new Date());

        });


        //批量操作
        function makeAll(msg) {

            if (confirm(msg)) {

                var str = '';
                for (var i = 0; i < document.getElementsByName('ids').length; i++) {
                    if (document.getElementsByName('ids')[i].checked) {
                        if (str == '') str += document.getElementsByName('ids')[i].value;
                        else str += ',' + document.getElementsByName('ids')[i].value;
                    }
                }
                if (str == '') {
                    alert("您没有选择任何内容!");
                    return;
                } else {
                    if (msg == '确定要删除选中的数据吗?') {
                        top.jzts();
                        $.ajax({
                            type: "POST",
                            url: '<%=basePath%>device/deleteAll.do?tm=' + new Date().getTime(),
                            data: {DATA_IDS: str},
                            dataType: 'json',
                            //beforeSend: validateData,
                            cache: false,
                            success: function (data) {
                                if ("success" == data.result) {
                                    window.location.href = "device/listAll.do?tm=" + new Date().getTime();
                                }
                            }
                        });
                    }
                }
            }
        }

        //导出excel
        function toExcel() {
            alert("待开发");
            <!--			window.location.href='
            <%=basePath%>pictures/excel.do';
		-->
        }
    </script>

</head>
<body>
<div class="container-fluid" id="main-container">


    <div id="page-content" class="clearfix">

        <div class="row-fluid">

            <div class="row-fluid">

                <!-- 检索  -->
                <form action="device/list.do" method="post" name="Form" id="Form">
                    <table width="100%" align="center">
                        <tr>
                            <td style="width: 70%"><label> </label></td>
                            <td><span class="input-icon"><input
                                    autocomplete="off" id="nav-search-input" type="text"
                                    name="keyword" value="${pd.keyword}" placeholder="请输入查询内容"/>
								<button class="btn btn-mini btn-light" onclick="searchForm(); "
                                        style="vertical-align:middle;margin-top:-10px;margin-left:10px"
                                        title="检索">
                                    <i id="nav-search-icon" class="icon-search"></i>
                                </button>
								</span>


                            </td>

                            <td>

                            </td>
                            <!-- <td style="vertical-align: middle;">
                                    <a class="btn btn-mini btn-light" onclick="toExcel();"
                                        title="导出到EXCEL"><i id="nav-search-icon"
                                        class="icon-download-alt"></i>
                                    </a>
                                </td> -->
                        </tr>
                    </table>
                    <!-- 检索  -->

                    <table id="table_report"
                           class="table table-striped table-bordered table-hover">
                        <thead>
                        <tr>
                            <th class="center" onclick="selectAll()"><label> <input
                                    type="checkbox" id="zcheckbox" name="zcheckbox"/> <span
                                    class="lbl"></span>
                            </label></th>
                            <th>编号</th>
                            <th>名称</th>
                            <th>矿场</th>
                            <th>设备类型</th>
                            <th>数量</th>
                            <th>显卡类型</th>
                            <th>设备状态</th>
                            <th>寄出订单</th>
                            <th>寄回订单</th>
                            <th>维修时间</th>
                            <th>更新时间</th>
                            <th>操作人</th>
                            <th>描述</th>
                            <th class="center">操作</th>
                        </tr>
                        </thead>

                        <tbody>

                        <!-- 开始循环 -->
                        <c:choose>
                            <c:when test="${not empty varList}">
                                <c:forEach items="${varList}" var="var" varStatus="vs">
                                    <tr>
                                        <td class='center' style="width: 30px;"><label>
                                            <input type='checkbox' name='ids' value="${var.id}"/>
                                            <span class="lbl"></span>
                                        </label></td>

                                        <td>${var.id}</td>
                                        <td>${var.name}</td>
                                        <td>${var.mine}</td>
                                        <td>${var.type}</td>
                                        <td>${var.num}</td>
                                        <td>${var.cardtype}</td>
                                        <td>${var.status}</td>
                                        <td>${var.inexpress}</td>
                                        <td>${var.outexpress}</td>
                                        <td>${var.repairdate}</td>
                                        <td>${var.updatedate}</td>
                                        <td>${var.operator}</td>
                                        <td>${var.description}</td>
                                        <td style="width: 50px;" class="center"><span>
														<div style="float:left;">
                                                            <a style="cursor: pointer;" title="编辑"
                                                               onclick="edit('${var.id}');"
                                                               class="tooltip-success" data-rel="tooltip" title=""
                                                               data-placement="left"><span class="green"><i
                                                                    class="icon-edit"></i> </span> </a>
                                                        </div>
														<div style="float:right;">
                                                            <a style="cursor: pointer;" title="删除"
                                                               onclick="del('${var.id}');" class="tooltip-error"
                                                               data-rel="tooltip" title="" data-placement="left"><span
                                                                    class="red"><i class="icon-trash"></i> </span> </a>
                                                        </div>
												</span></td>
                                    </tr>

                                </c:forEach>

                            </c:when>

                        </c:choose>

                        </tbody>
                    </table>

                    <div class="page-header position-relative">
                        <table style="width: 100%;">
                            <tr>
                                <td style="vertical-align: top;"><a
                                        class="btn btn-small btn-success" onclick="add();">新增</a> <a
                                        class="btn btn-small btn-danger"
                                        onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除">删除</a></td>
                                <td style="vertical-align: top;">
                                    <div class="pagination"
                                         style="float: right; padding-top: 0px; margin-top: 0px;">
                                        ${page.pageStr}</div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </form>
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

