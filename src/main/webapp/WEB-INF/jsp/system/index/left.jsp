<%@page import="com.privatenode.util.PageData"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String pathl = request.getContextPath();
	String basePathl = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ pathl + "/";
	List<PageData> powerList = (List<PageData>) request
			.getAttribute("powerList");
%>
<!-- 本页面涉及的js函数，都在head.jsp页面中     -->
<div id="sidebar">
	<div id="sidebar-shortcuts">

		<div>
			<button class="btn btn-small btn-success">
				<i class="icon-pencil"></i>
			</button>

			<button class="btn btn-small btn-info">
				<i class="icon-eye-open"></i>
			</button>

			<button class="btn btn-small btn-warning">
				<i class="icon-book"></i>
			</button>

			<button class="btn btn-small btn-danger">
				<i class="icon-folder-open"></i>
			</button>

		</div>

		<div id="sidebar-shortcuts-mini">
			<span class="btn btn-success"></span> <span class="btn btn-info"></span>

			<span class="btn btn-warning"></span> <span class="btn btn-danger"></span>
		</div>

	</div>
	<!-- #sidebar-shortcuts -->

	<%--<ul class="nav nav-list">
		<%
			if (powerList.size() > 0) {
				for (PageData pageData : powerList) {
					out.print(pageData.get("path"));
				}
			}
		%>  --%>
	<li class="active" id="fhindex">
			<a onclick="javascript:void(0);"
				target="mainFrame" onmouseover="this.style.backgroundColor='#7EBAE0'"
				onmouseout="this.style.backgroundColor='#DBEAF9'"
				style="background: #DBEAF9">
				<i class="icon-dashboard"></i>
				<span
					onmouseover="this.style.backgroundColor='#7EBAE0'"
					onmouseout="this.style.backgroundColor='#DBEAF9'"> 系统管理
					</span>
					<b class="arrow icon-angle-down"></b>
			</a>
			<ul class="submenu" style="display: none;">
				<li id="z7">
					<a style="cursor:pointer;" target="mainFrame"
							onclick="siMenu('z7','lm6','权限管理','power/listPowers')">
							<i class="icon-double-angle-right"></i>
							权限管理
					</a>
					</li>
			</ul>
		</li>
	</ul>
	<!--/.nav-list-->

	<div id="sidebar-collapse">
		<i class="icon-double-angle-left"></i>
	</div>

</div>
<!--/#sidebar-->

