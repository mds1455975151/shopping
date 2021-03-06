<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html class="no-js">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>提现管理</title>
<meta name="keywords" content="index">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="icon" type="image/png" href="${staticRoot}/admin/i/favicon.png">
<link rel="apple-touch-icon-precomposed" href="${staticRoot}/admin/i/app-icon72x72@2x.png">
<meta name="apple-mobile-web-app-title" content="Amaze UI" />
<link rel="stylesheet" href="${staticRoot}/admin/css/amazeui.min.css"/>
<link rel="stylesheet" href="${staticRoot}/admin/css/admin.css">
<script src="${staticRoot}/admin/js/jquery.min.js"></script>
<script src="${staticRoot}/admin/js/app.js"></script>
</head>
<body>
<!--[if lte IE 9]><p class="browsehappy">升级你的浏览器吧！ <a href="http://se.360.cn/" target="_blank">升级浏览器</a>以获得更好的体验！</p><![endif]-->
</head>
<body>
<!-- top-head begin -->
<jsp:include page="../common/top_head.jsp" flush="false"></jsp:include>
<!-- top-head end -->
<div class="am-cf admin-main"> 
<!-- left-head begin -->
<jsp:include page="../common/left_head.jsp" flush="false"></jsp:include>
<!-- left-head end -->
<div class=" admin-content">
		<div class="daohang">
			<ul>
			</ul>
		</div>
		<div class="admin-biaogelist">
			<div class="listbiaoti am-cf">
		      <ul class="am-icon-flag on"> 提现管理</ul>
		      <dl class="am-icon-home" style="float: right;"> 当前位置： 首页 > <a href="#">提现管理</a></dl>
		    </div>
			<div class="fbneirong">
		      <form class="am-form" id="form_user">
		         <div class="am-form-group am-cf">
		          <div class="zuo">会员头像：</div>
		          <div class="you">
		            <img id="member_img" src="${info.wechatImg }" style="width: 60px">
		          </div>
		        </div>
		        <div class="am-form-group am-cf">
		          <div class="zuo">提现人名称：</div>
		          <div class="you">
		             <input type="text" value="${info.wechatName }"  readonly="readonly" class="am-input-sm">
		            
		              </div>
		        </div>
		        <div class="am-form-group am-cf">
		          <div class="zuo">账户余额：</div>
		          <div class="you">
		          <input type="text" value="${info.balance }"  readonly="readonly" class="am-input-sm">
		           
		               </div>
		        </div>
		        <div class="am-form-group am-cf">
		          <div class="zuo">提现金额：</div>
		          <div class="you">
		          <input type="text" value="${draw.withdrawalAmount }"  readonly="readonly" class="am-input-sm">
		            <input type="hidden" id="deop_id" value="${draw.id }">
		             </div>
		        </div>
		        <div class="am-form-group am-cf">
		          <div class="you" style="margin-left: 11%;">
		              <button type="button" id="audit_deposit" class="am-btn am-btn-success am-radius">确认</button>
		          </div>
		        </div>
		      </form>
		    </div>
		</div>
	</div>
</div>
<!--[if lt IE 9]>
<script src="http://libs.baidu.com/jquery/1.11.1/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="${staticRoot}/admin/js/polyfill/rem.min.js"></script>
<script src="${staticRoot}/admin/js/polyfill/respond.min.js"></script>
<script src="${staticRoot}/admin/js/amazeui.legacy.js"></script>
<![endif]--> 
<!--[if (gte IE 9)|!(IE)]><!--> 
<script src="${staticRoot}/admin/js/amazeui.min.js"></script>
<!--<![endif]-->
<script type="text/javascript">
$(function(){
	$("#member_class").addClass("on");
});

$("#audit_deposit").on("click",function(){
	$.ajax({
		url:"/admin/shop/deposit/audit",
		data:{id:$("#deop_id").val()},
		type:"POST",
		success:function(ret){
			if(ret.code=="000000"){
				alert("操作成功");
				window.location.href="/admin/shop/deposit/page";
			}else{
				alert(ret.error);
			}
		}
	});
});

</script>
</body>
</html>