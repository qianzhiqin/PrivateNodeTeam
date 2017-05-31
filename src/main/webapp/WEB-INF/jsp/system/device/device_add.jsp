<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<base href="<%=basePath%>">
	<meta charset="utf-8" />
	<title></title>
	<link rel="stylesheet" href="static/css/ace.min.css" />
	<link rel="stylesheet" href="static/css/bootstrap.min.css" />

	<script src="static/js/jquery-1.7.2.js"></script>
	<script src="static/js/jquery.tips.js"></script>

	<style>
		table {
			border-collapse: collapse; /* 边框合并属性  */
		}

		th {
			border: 1px solid #666666;
		}

		td {
			border: 1px solid #666666;
		}

		input {
			margin-top: 5px;
		}
	</style>
	<script type="text/javascript">
		function previewImage(file) {
			var MAXWIDTH = 100;
			var MAXHEIGHT = 100;
			var div = document.getElementById('preview');
			if (file.files && file.files[0]) {
				div.innerHTML = '<img id=imghead>';
				var img = document.getElementById('imghead');
				img.onload = function() {
					var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT,
							img.offsetWidth, img.offsetHeight);

					img.width = 100;
					img.height = 100;
				}
				var reader = new FileReader();
				reader.onload = function(evt) {
					img.src = evt.target.result;
				}
				reader.readAsDataURL(file.files[0]);
			} else {
				var sFilter = 'filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src="';
				file.select();
				var src = document.selection.createRange().text;
				div.innerHTML = '<img id=imghead>';
				var img = document.getElementById('imghead');
				img.filters.item('DXImageTransform.Microsoft.AlphaImageLoader').src = src;
				var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth,
						img.offsetHeight);
				status = ('rect:' + rect.top + ',' + rect.left + ',' + rect.width
				+ ',' + rect.height);
				div.innerHTML = "<div id=divhead style='width:"+rect.width+"px;height:"+rect.height+"px;margin-top:0px;margin-left:0px;"+sFilter+src+"\"'></div>";
			}
		}
		function saveCheck() {
			if (check()) {
				$("#ownerForm").submit();
			}
		}
		function check() {
			if ($("#name").val() == "") {
				$("#name").tips({
					side : 2,
					msg : '用户名不得为空',
					bg : '#AE81FF',
					time : 3
				});
				$("#name").focus();
				return false;
			}
			if ($("#password").val() == "") {
				$("#password").tips({
					side : 2,
					msg : '密码不得为空',
					bg : '#AE81FF',
					time : 3
				});
				$("#password").focus();
				return false;
			}
			if ($("#password2").val() == "") {
				$("#password2").tips({
					side : 2,
					msg : '密码不得为空',
					bg : '#AE81FF',
					time : 3
				});
				$("#password2").focus();
				return false;
			}
			if ($("#nickname").val() == "") {
				$("#nickname").tips({
					side : 2,
					msg : '昵称不得为空',
					bg : '#AE81FF',
					time : 3
				});
				$("#nickname").focus();
				return false;
			}
			if ($("#mobile").val() == "") {
				$("#mobile").tips({
					side : 2,
					msg : '手机不得为空',
					bg : '#AE81FF',
					time : 3
				});
				$("#mobile").focus();
				return false;
			}
			if ($("#email").val() == "") {
				$("#email").tips({
					side : 2,
					msg : '邮箱不得为空',
					bg : '#AE81FF',
					time : 3
				});
				$("#email").focus();
				return false;
			}
			if ($("#birthday").val() == "") {
				$("#birthday").tips({
					side : 2,
					msg : '生日不得为空',
					bg : '#AE81FF',
					time : 3
				});
				$("#birthday").focus();
				return false;
			}
			if ($("#password").val() != $("#password2").val()) {
				$("#password").tips({
					side : 2,
					msg : '两次密码不一致',
					bg : '#AE81FF',
					time : 3
				});
				$("#password").focus();
				return false;
			}
			return true;
		}
	</script>
</head>
<body style="background-color:#fff;">
<div id="zhongxin"
	 style="width:100%;text-align:center; margin-top:10px;">
	<form action="owner/add.do" name="ownerForm" id="ownerForm"
		  method="post" style="position:poScreenCenter;"  enctype="multipart/form-data">
		<table align="center" border="0">
			<tr>
				<td style="height: 30%"><span
						style="width:200px;height: 100px;">
							<table style="width:100%">
								<tr>
									<td><div id="preview" width=100 height=100
											 style="float: left;">
										<img id="imghead" width=100 height=100 border=0
											 src='../images/head01_big.jpg'>
									</div></td>
								</tr>
								<tr>
									<td style="vertical-align: middle;"><div
											style="float: right;vertical-align: middle;">
										<input name="upload" id="upload" type="file"
											   onchange="previewImage(this)" />
									</div></td>
								</tr>
							</table>
					</span> <input type="hidden" name="imageUrl" value="" /></td>
				<td rowspan="2">
					<table align="center">
						<tr>
							<th colspan="2"><h4>新增车主</h4></th>
						</tr>
						<tr>
							<td width="150px">用户名</td>
							<td width="200px"><input type="text" name="driverName"
													 id="driverName" placeholder="用户名" value="" title="用户名" /></td>
						</tr>
						<tr>
							<td width="150px">手机号</td>
							<td width="200px"><input type="text"
													 name="accountTelephone" id="accountTelephone" placeholder="手机号"
													 value="" title="手机号" /></td>
						</tr>
						<tr>
							<td width="150px">身份证号</td>
							<td width="200px"><input type="text" name="idCard"
													 id="idCard" placeholder="身份证号" value="" title="身份证号" /></td>
						</tr>
						<tr>
							<td>住址</td>
							<td><input type="text" name="address" id=""
									   address"" placeholder="住址" value="" title="住址" /></td>
						</tr>
						<tr>
							<td>开户行</td>
							<td><input type="text" name="openAccountBank"
									   id="openAccountBank" placeholder="开户行" value="" title="开户行" /></td>
						</tr>
						<tr>
							<td>银行卡号</td>
							<td><input type="text" name="accountNumber"
									   id="accountNumber" placeholder="银行卡号" value="" title="银行卡号" /></td>
						</tr>
						<tr>
							<td>用户类型</td>
							<td><select name="type">
								<option value="0">注册用户</option>
								<option value="1">第三方用户</option>
							</select>
						</tr>
						<tr>
							<td>是否有车</td>
							<td><select name="isHaveCar">
								<option value="0">有</option>
								<option value="1">无</option>
							</select>
						</tr>
						<tr>
							<td>是否为vip</td>
							<td><select name="isVip">
								<option value="0">是</option>
								<option value="1">否</option>
							</select>
						</tr>
						<tr>
							<td>车型</td>
							<td><input type="text" name="carModel" id="carModel"
									   placeholder="车型" value="" title="车型" /></td>
						</tr>
						<tr>
							<td>车牌</td>
							<td><input type="text" name="carNumPlate" id="carNumPlate"
									   placeholder="车牌" value="" title="车牌" /></td>
						</tr>
						<tr>
							<td style="text-align: center; padding-top: 5px;"><a
									class="btn btn-mini btn-primary" onclick="saveCheck();">保存</a>
							</td>
							<td style="text-align: center; padding-top: 5px;"><a
									class="btn btn-mini btn-danger"
									onclick="javascript:window.history.go(-1)">取消</a></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td></td>
				<td></td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>