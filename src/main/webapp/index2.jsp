<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>     
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />     
<title>privatenode</title>
<style type="text/css">
#preview{width:150px;height:150px;border:1px solid #000;overflow:hidden;}
#imghead {filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);}
</style>
<script type="text/javascript">
function previewImage(file)
{
  var MAXWIDTH  = 150;
  var MAXHEIGHT = 150;
  var div = document.getElementById('preview');
  if (file.files && file.files[0])
  {
  	div.innerHTML = '<img id=imghead>';
  	var img = document.getElementById('imghead');
  	img.onload = function(){
  	  var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
  	  alert(rect.width);
  	  alert(rect.height);
  	  alert(rect.left);
  	  alert(rect.top);
  	  img.width = rect.width;
  	  img.height = rect.height;
  	}
  	var reader = new FileReader();
  	reader.onload = function(evt){img.src = evt.target.result;}
  	reader.readAsDataURL(file.files[0]);
  }
  else
  {
    var sFilter='filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src="';
    file.select();
    var src = document.selection.createRange().text;
    div.innerHTML = '<img id=imghead>';
    var img = document.getElementById('imghead');
    img.filters.item('DXImageTransform.Microsoft.AlphaImageLoader').src = src;
    var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
    status =('rect:'+rect.top+','+rect.left+','+rect.width+','+rect.height);
    div.innerHTML = "<div id=divhead style='width:"+rect.width+"px;height:"+rect.height+"px;margin-top:0px;margin-left:0px;"+sFilter+src+"\"'></div>";
  }
}
function clacImgZoomParam( maxWidth, maxHeight, width, height ){
	var param = {top:0, left:0, width:width, height:height};
	if( width>maxWidth || height>maxHeight )
	{
		rateWidth = width / maxWidth;
		rateHeight = height / maxHeight;
		
		if( rateWidth > rateHeight )
		{
			param.width =  maxWidth;
			param.height = maxHeight
		}else
		{
			param.width = maxHeight
			param.height = maxHeight;
		}
	}
	
	param.left = Math.round((maxWidth - param.width) / 2);
	param.top = Math.round((maxHeight - param.height) / 2);
	return param;
}

</script>     
</head>     
<body>
<div id="preview">
	<img id="imghead" width=150 height=150 border=0 src='../images/head01_big.jpg'>
</div>
    <br/>     
    <input type="file" onchange="previewImage(this)" />     
</body>     
</html>     
