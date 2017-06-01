<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <meta charset="utf-8"/>
    <title></title>
    <link rel="stylesheet" href="static/css/ace.min.css"/>
    <link rel="stylesheet" href="static/css/bootstrap.min.css"/>

    <script src="static/js/jquery-1.7.2.js"></script>
    <script src="static/js/jquery.tips.js"></script>

    <style type="text/css">
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

        function saveCheck() {
            if (check()) {
                $("#deviceForm").submit();
            }
        }
        function check() {
            if ($("#name").val() == "") {
                $("#name").tips({
                    side : 2,
                    msg : '名称不得为空',
                    bg : '#AE81FF',
                    time : 3
                });
                $("#name").focus();
                return false;
            }
            if ($("#mine").val() == "") {
                $("#mine").tips({
                    side : 2,
                    msg : '矿场不得为空',
                    bg : '#AE81FF',
                    time : 3
                });
                $("#mine").focus();
                return false;
            }
            if ($("#num").val() == "") {
                $("#num").tips({
                    side : 2,
                    msg : '数量不得为空',
                    bg : '#AE81FF',
                    time : 3
                });
                $("#num").focus();
                return false;
            }
            if ($("#operator").val() == "") {
                $("#operator").tips({
                    side : 2,
                    msg : '操作人不得为空',
                    bg : '#AE81FF',
                    time : 3
                });
                $("#operator").focus();
                return false;
            }
            return true;
        }
    </script>
</head>
<body style="background-color:#fff;">
<div id="zhongxin" style="width:100%;text-align:center; margin-top:10px;">
    <form action="device/edit.do" name="deviceForm" id="deviceForm" method="post" style="position:relative;" >
        <input type="hidden" name="id" id="id" value="${pd.id}"/>
        <table align="center" border="1">
            <tr>
				<td rowspan="2">
                    <table align="center">
                        <tr>
                            <th colspan="2"><h4>新增设备</h4></th>
                        </tr>
                        <tr>
                            <td width="150px">名称</td>
                            <td width="300px"><input type="text" name="name"
                                                     id="name" placeholder="名称" value="${pd.name}" title="名称"/></td>
                        </tr>
                        <tr>
                            <td width="150px">矿场</td>
                            <td width="300px"><input type="text"
                                                     name="mine" id="mine" placeholder="矿场"
                                                     value="${pd.mine}" title="矿场"/></td>
                        </tr>
                        <tr>
                            <td width="150px">设备类型</td>
                            <td><select name="type">
                                <c:if test="${pd.type eq '整机' }">
                                    <option value="整机" selected="selected">整机</option>
                                    <option value="显卡">显卡</option>
                                    <option value="主板">主板</option>
                                    <option value="电源">电源</option>
                                    <option value="硬盘">硬盘</option>
                                    <option value="内存">内存</option>
                                </c:if>
                                <c:if test="${pd.type eq '显卡' }">
                                    <option value="整机">整机</option>
                                    <option value="显卡" selected="selected">显卡</option>
                                    <option value="主板">主板</option>
                                    <option value="电源">电源</option>
                                    <option value="硬盘">硬盘</option>
                                    <option value="内存">内存</option>
                                </c:if>
                                <c:if test="${pd.type eq '主板' }">
                                    <option value="整机">整机</option>
                                    <option value="显卡">显卡</option>
                                    <option value="主板" selected="selected">主板</option>
                                    <option value="电源">电源</option>
                                    <option value="硬盘">硬盘</option>
                                    <option value="内存">内存</option>
                                </c:if>
                                <c:if test="${pd.type eq '电源' }">
                                    <option value="整机">整机</option>
                                    <option value="显卡">显卡</option>
                                    <option value="主板">主板</option>
                                    <option value="电源" selected="selected">电源</option>
                                    <option value="硬盘">硬盘</option>
                                    <option value="内存">内存</option>
                                </c:if>
                                <c:if test="${pd.type eq '硬盘' }">
                                    <option value="整机" selected="selected">整机</option>
                                    <option value="显卡">显卡</option>
                                    <option value="主板">主板</option>
                                    <option value="电源">电源</option>
                                    <option value="硬盘" selected="selected">硬盘</option>
                                    <option value="内存">内存</option>
                                </c:if>
                                <c:if test="${pd.type eq '内存' }">
                                    <option value="整机">整机</option>
                                    <option value="显卡">显卡</option>
                                    <option value="主板">主板</option>
                                    <option value="电源">电源</option>
                                    <option value="硬盘">硬盘</option>
                                    <option value="内存" selected="selected">内存</option>
                                </c:if>
                            </select>
                            </td>
                        </tr>
                        <tr>
                            <td>数量</td>
                            <td><input type="text" name="num" id="num"
                                       placeholder="数量" value="${pd.num}" title="数量"/></td>
                        </tr>
                        <tr>
                            <td>显卡类型</td>
                            <td><select name="cardtype">
                                <c:if test="${pd.cardtype eq 'A' }">
                                    <option value="A" selected="selected">A卡</option>
                                    <option value="N">N卡</option>
                                </c:if>
                                <c:if test="${pd.cardtype eq 'N' }">
                                    <option value="A">A卡</option>
                                    <option value="N" selected="selected">N卡</option>
                                </c:if>
                            </select>
                            </td>
                        </tr>
                        <tr>
                            <td>设备状态</td>
                            <td><select name="status">
                                <c:if test="${pd.status eq '损坏' }">
                                    <option value="损坏" selected="selected">损坏</option>
                                    <option value="检修">检修</option>
                                    <option value="正常">正常</option>
                                </c:if>
                                <c:if test="${pd.status eq '检修' }">
                                    <option value="损坏">损坏</option>
                                    <option value="检修" selected="selected">检修</option>
                                    <option value="正常">正常</option>
                                </c:if>
                                <c:if test="${pd.status eq '正常' }">
                                    <option value="损坏">损坏</option>
                                    <option value="检修">检修</option>
                                    <option value="正常" selected="selected">正常</option>
                                </c:if>
                            </select>
                            </td>
                        </tr>
                        <tr>
                            <td>寄回单号</td>
                            <td><input type="text" name="inexpress" id="inexpress"
                                       placeholder="寄回单号" value="${pd.inexpress}" title="寄回单号"/></td>
                        </tr>
                        <tr>
                            <td>寄出单号</td>
                            <td><input type="text" name="outexpress" id="outexpress"
                                       placeholder="寄出单号" value="${pd.outexpress}" title="寄出单号"/></td>
                        </tr>
                        <tr>
                            <td>维修时间</td>
                            <td><input type="text" name="repairdate" id="repairdate"
                                       placeholder="维修时间" value="" title="维修时间"/></td>
                        </tr>
                        <tr>
                            <td>操作人</td>
                            <td><input type="text" name="operator" id="operator"
                                       placeholder="操作人" value="${pd.operator}" title="操作人"/></td>
                        </tr>
                        <tr>
                            <td>描述信息</td>
                            <td><textarea rows="3" cols="20" name="description" id="description">${pd.description}</textarea></td>
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