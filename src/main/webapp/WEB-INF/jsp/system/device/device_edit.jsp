<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String imagePath = request.getScheme() + "://"
			+ request.getServerName();
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

	<style type="text/css">
		#preview {
			width: 100px;
			height: 100px;
			border: 1px solid #000;
			overflow: hidden;
		}

		#imghead {
			filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);
		}

		table {
			border-collapse: collapse; /* 边框合并属性  */
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
		function clacImgZoomParam(maxWidth, maxHeight, width, height) {
			var param = {
				top : 0,
				left : 0,
				width : width,
				height : height
			};
			if (width > maxWidth || height > maxHeight) {
				rateWidth = width / maxWidth;
				rateHeight = height / maxHeight;

				if (rateWidth > rateHeight) {
					param.width = maxWidth;
					param.height = maxHeight

				} else {
					param.width = maxHeight
					param.height = maxHeight;
				}
			}
			param.height = 100;
			param.width = 100;
			param.left = Math.round((maxWidth - param.width) / 2);
			param.top = Math.round((maxHeight - param.height) / 2);
			return param;
		}

		function saveCheck() {
			$("#ownerForm").submit();
		}
		//充值记录
		function recharge(id) {

			window.location.href = "owner/recharge.do?id=" + id + "&tm="
					+ new Date().getTime();

		}
	</script>
</head>
<body style="background-color:#fff;">
<!--		enctype="multipart/form-data"-->
<form action="owner/edit.do" name="ownerForm" id="ownerForm"
	  method="post" style="position:poScreenCenter;"
	  enctype="multipart/form-data">
	<div id="zhongxin"
		 style="width:100%;text-align:center; margin-top:10px;">
		<input type="hidden" name="id" id="id"
			   value="${pd.id}" />
		<table>
			<tr>
				<td><span style="width:200px;height: 100px;">
							<table style="width:100%">
								<tr>
									<th>车主头像</th>
								</tr>
								<tr>
									<td><div id="preview" width=100 height=100
											 style="float: left;">
										<img id="imghead" width=100 height=100 border=0
											 src="<%=imagePath%>${pd.user_headImage}">
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
					</span> <input type="hidden" name="imageUrl" value="${pd.user_headImage}" /></td>
				<td>
					<table align="center">
						<tr>
							<th colspan="2"><h4>修改车主</h4></th>
						</tr>
						<tr>
							<td width="150px">用户名</td>
							<td width="200px"><input type="text" name="driverName"
													 id="driverName" placeholder="用户名" value="${pd.driverName}"
													 title="用户名" /></td>
						</tr>
						<tr>
							<td width="150px">手机号</td>
							<td width="200px"><input type="text"
													 name="accountTelephone" id="accountTelephone" placeholder="手机号"
													 value="${pd.account_telephone}" title="手机号" /></td>
						</tr>
						<tr>
							<td width="150px">身份证号</td>
							<td width="200px"><input type="text" name="idCard"
													 id="idCard" placeholder="身份证号" value="${pd.id_card}"
													 title="身份证号" /></td>
						</tr>
						<tr>
							<td width="150px">用户类型</td>
							<td width="200px"><select name="type">
								<c:if test="${pd.type eq 0 }">
									<option value="0" selected="selected">注册用户</option>
									<option value="1">第三方用户</option>
								</c:if>
								<c:if test="${pd.type eq 1 }">
									<option value="0">注册用户</option>
									<option value="1" selected="selected">第三方用户</option>
								</c:if>
								<c:if test="${pd.type eq null }">
									<option value="0 " selected="selected">注册用户</option>
									<option value="1">第三方用户</option>
								</c:if>
							</select></td>
						</tr>
						<tr>
							<td>住址</td>
							<td><input type="text" name="address" id=""
									   address"" placeholder="住址" value="${pd.address}" title="住址" />
							</td>
						</tr>
						<tr>
							<td>开户行</td>
							<td><input type="text" name="openAccountBank"
									   id="openAccountBank" placeholder="开户行"
									   value="${pd.open_account_bank}" title="开户行" /></td>
						</tr>
						<tr>
							<td>银行卡号</td>
							<td><input type="text" name="accountNumber"
									   id="accountNumber" placeholder="银行卡号"
									   value="${pd.account_number}" title="银行卡号" /></td>
						</tr>
						<tr>
							<td>用户余额</td>
							<td><input type="text" name="balance" id="balance"
									   placeholder="银行卡号" value="${pd.balance}" title="银行卡号" /></td>
						</tr>

						<tr>
							<td>是否有车</td>
							<td><select name="isHaveCar">
								<c:if test="${pd.is_have_car eq 0 }">
									<option value="0" selected="selected">有</option>
									<option value="1">无</option>
								</c:if>
								<c:if test="${pd.is_have_car eq null }">
									<option value="0" selected="selected">有</option>
									<option value="1">无</option>
								</c:if>
								<c:if test="${pd.is_have_car eq 1 }">
									<option value="0">有</option>
									<option value="1" selected="selected">无</option>
								</c:if>
							</select></td>
						</tr>
						<tr>
							<td>是否为vip</td>
							<td><select name="isVip">
								<c:if test="${pd.is_vip eq 0 }">
									<option value="0" selected="selected">是</option>
									<option value="1">否</option>
								</c:if>
								<c:if test="${pd.is_vip eq null }">
									<option value="0" selected="selected">是</option>
									<option value="1">否</option>
								</c:if>
								<c:if test="${pd.is_vip eq 1 }">
									<option value="0">有</option>
									<option value="1" selected="selected">无</option>
								</c:if>
							</select>
						</tr>
						<tr>
							<td>车型</td>
							<td><input type="text" name="carModel" id="carModel"
									   placeholder="车型" value="${pd.car_model}" title="车型" /></td>
						</tr>
						<tr>
							<td>车牌</td>
							<td><input type="text" name="carNumPlate" id="carNumPlate"
									   placeholder="车牌" value="${pd.car_num_plate}" title="车牌" /></td>
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

		</table>
	</div>
</form>
</body>
</html>