<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<base href="<%=basePath%>">
	<meta charset="utf-8" />
	<title></title>
	<link href="static/css/bootstrap.min.css" rel="stylesheet" />
	<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
	<link href="static/css/font-awesome.min.css" rel="stylesheet" />
	<link href="static/css/datePick.css" rel="stylesheet" />

	<script src="static/js/jquery-1.7.2.js"></script>
	<script src="static/js/jquery.tips.js" ></script>

	<style type="text/css">
		#preview{width:100px;height:100px;border:1px solid #000;overflow:hidden;}
		#imghead {filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);}
		table{
			border-collapse: collapse;/* 边框合并属性  */
		}
		input{
			margin-top:5px;
		}

	</style>
	<script type="text/javascript">
		//删除
		function del(id){
			top.jzts();
			if(confirm("确定要删除?")){
				var url = "<%=basePath%>owner/deleteRecharge.do?id="+id+"&tm="+new Date().getTime();
				$.get(url,function(data){
					nextPage(${page.currentPage});
				});
			}
		}

	</script>
</head>
<body style="background-color:#fff;">
<table align=left >
	<tr>
		<td width="120px" style="padding-left:50px;">
			<img id="imghead" width=100 height=100 border=0 src='../images/head01_big.jpg'>
		</td>
		<td>
			<table height="100%">
				<tr height="33">
					<td>姓名：${name}     手机：${mobile}</td>
				</tr>
				<tr height="33">
					<td>注册：${name}</td>
				</tr>
				<tr height="33">
					<td>等级：${level} </td>
				</tr >
			</table>
		</td>
	</tr>
</table>
<hr/>

<!-- 检索  -->
<form action="owner/list.do" method="post" name="Form" id="Form">
	<table width="100%" align="center">
		<tr>
			<td>
						<span class="input-icon"> <input autocomplete="off"
														 id="nav-search-input" type="text" name="keyword"
														 value="${pd.keyword}" placeholder="这里输入关键词" /> </span>
			</td>
			<td style="font-size: 18px;">
				等级
				<select id="level" name="level"
						onchange="selectSort(this.value)" style="width: 70px;">
					<option value="0" selected="selected">
						普通
					</option>
					<option value="1">
						VIP
					</option>
				</select>
			</td>

			<td style="vertical-align: middle;">
				<button class="btn btn-mini btn-light" onclick="searchForm();"
						title="检索">
					<i id="nav-search-icon" class="icon-search"></i>
				</button>
			</td>
			<td style="vertical-align: middle;">
				<a class="btn btn-mini btn-light" onclick="toExcel();"
				   title="导出到EXCEL"><i id="nav-search-icon"
									   class="icon-download-alt"></i>
				</a>
			</td>
		</tr>
	</table>
	<!-- 检索  -->

	<table id="table_report"
		   class="table table-striped table-bordered table-hover">
		<thead>
		<tr>
			<th class="center" onclick="selectAll()">
				<label>
					<input type="checkbox" id="zcheckbox" name="zcheckbox"/>
					<span class="lbl"></span>
				</label>
			</th>
			<th>
				编号
			</th>
			<th>
				类型
			</th>
			<th>
				时间
			</th>
			<th>
				内容
			</th>
			<th>
				金额
			</th>
			<th>
				渠道
			</th>
			<th>
				状态
			</th>
			<th>
				等级
			</th>
			<th class="center">
				操作
			</th>
		</tr>
		</thead>

		<tbody>

		<!-- 开始循环 -->
		<c:choose>
			<c:when test="${not empty varList}">
				<c:forEach items="${varList}" var="var" varStatus="vs">
					<tr>
						<td class='center' style="width: 30px;">
							<label>
								<input type='checkbox' name='ids'
									   value="${var.id}" />
								<span class="lbl"></span>
							</label>
						</td>

						<td>
								${var.id}
						</td>
						<td>
								${var.type}
						</td>
						<td>
								${var.creat_time}
						</td>
						<td>
								${var.type}
						</td>
						<td>
								${var.amount}
						</td>
						<td>
								${var.channel}
						</td>
						<td>
								${var.num}
						</td>

						<td style="width: 50px;" class="center">
							<div style="float:center;">
								<a style="cursor: pointer;" title="删除"
								   onclick="del('${var.id}');" class="tooltip-error"
								   data-rel="tooltip" title="" data-placement="left"><span
										class="red"><i class="icon-trash"></i>
													</span> </a>
							</div>
						</td>
					</tr>

				</c:forEach>

			</c:when>

		</c:choose>

		</tbody>
	</table>

	<div class="page-header position-relative">
		<table style="width: 100%;">
			<tr>
				<td style="vertical-align: top;">
				</td>
				<td style="vertical-align: top;">
					<div class="pagination"
						 style="float: right; padding-top: 0px; margin-top: 0px;">
						${page.pageStr}
					</div>
				</td>
			</tr>
		</table>
	</div>
</form>
</body>
</html>