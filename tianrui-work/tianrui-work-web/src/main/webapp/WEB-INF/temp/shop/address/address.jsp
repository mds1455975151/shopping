<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=yes">
<title>收货地址</title>
<link rel="stylesheet" type="text/css" href="/resources/shop/css/style.css">
<link rel="stylesheet" type="text/css" href="/resources/shop/css/shoujisc.css">
<script type="text/javascript" src="/resources/shop/js/jQuery.js"></script>
</head>

<body>
	
    <div class="sjsc-title1">
    	<h3 class="sjsc-t1l f-l"><a href="JavaScript:;"><span><</span>收货地址</a></h3>
        <div style="clear:both;"></div>
    </div>
    
    <span id="innerHml">
    
    </span>
    <button class="drdd-btn" onclick="window.location.href='/wechat/shop/address/savePage'">新增收货地址</button>
<input type="hidden" id="scrollPage">
<input type="hidden" id="scrollTotal">  
</body>
<script src="/resources/js/scroll/scroll.js"></script>
<script type="text/javascript">
$(function(){
	init(0,0);
});
function init(pageNo,type){
	$("#scrollPage").val(pageNo);
	$("#status").fadeOut();
	$.ajax({
		url:"/wechat/shop/address/select",
		data:{"pageNo":pageNo,
			"pageSize":10},
		type:"POST",
		success:function(ret){
			if(ret.code=="000000"){
				$("#scrollTotal").val(ret.data.total);
				innerHTML(ret.data.list,type);
				$("#preloader").fadeOut("slow");
			}
		}
	});
}
function innerHTML(data,type){
	if(type==0){
		$("#innerHml").empty();
	}
	for (var a = 0; a < data.length; a++) {
		var ma = "";
		if(data[a].isDefault=="1"){
			ma = "<a class='a1'>[默认]</a>";
		}
		var hml = "<dl class='drdd-info7' onclick=\"uptMax('"+data[a].id+"')\"><dt><p><span class='f-l'>"+data[a].recipients+"</span><span class='f-r'>"+data[a].phone+"</span>"+
		"<div style='clear:both;'></div></p><p>"+ma+data[a].city+","+data[a].detailAddress+"<span class='sp1'>"+data[a].zipCode+"</span>"+
		"</p></dt><dd><a href='#'>></a></dd><div style='clear:both;'></div></dl>";
		$("#innerHml").append(hml);
	}
}

function uptMax(id){
	if(confirm("确认设置默认地址吗？")){
		$.ajax({
			url:"/wechat/shop/address/only",
			data:{"id":id},
			type:"POST",
			success:function(ret){
				init(0,0);
			}
		});
	}
}

</script>
</html>