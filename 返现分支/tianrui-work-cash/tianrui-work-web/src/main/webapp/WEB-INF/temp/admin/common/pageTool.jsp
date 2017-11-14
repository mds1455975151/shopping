<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<ul class="am-pagination am-fr" id="pageHtml">
     <li class="am-disabled"><a href="#">«</a></li>
     <li class="am-active"><a href="#">1</a></li>
     <li><a href="#">2</a></li>
     <li><a href="#">3</a></li>
     <li><a href="#">4</a></li>
     <li><a href="#">5</a></li>
     <li><a href="#">»</a></li>
</ul>
<script type="text/javascript">
//分页通用方法 total-数据总条数  pageSize-每页展示条数
function pageTool(total,pageNo,pageSize){
	$("#pageHtml").empty();
	var pageA = Math.ceil(total/pageSize);
	var hml = "";
	if(pageNo == 0){
		hml +="<li class='am-disabled'><a href='#'>«</a></li>";
	}else {
		hml +="<li><a href='#' onclick=\"init('"+(Number(pageNo)-1)+"')\">«</a></li>";
	}
	for (var a = 0; a < pageA; a++) {
		if(pageNo>1 && a==0){
			if(pageNo == 2){
				hml +="<li><a href='#' onclick=\"init('"+a+"')\">"+(a+1)+"</a></li>";
			}else{
				hml +="<li><a href='#' onclick=\"init('"+a+"')\">"+(a+1)+"</a></li>";
				hml +="<li><a href='#' >...</a></li>";
			}
		}else if(pageNo == a){
			hml +="<li class='am-active'><a href='#' onclick=\"init('"+a+"')\">"+(a+1)+"</a></li>";
		}else if(a+1==Number(pageNo)||a-1==Number(pageNo)){
			hml +="<li><a href='#' onclick=\"init('"+a+"')\">"+(a+1)+"</a></li>";
		}else if((a+1)>=pageA){
			if((Number(pageNo)+3)==pageA){
				hml +="<li><a href='#' onclick=\"init('"+a+"')\">"+(a+1)+"</a></li>";
			}else{
				hml +="<li><a href='#' >...</a></li>";
				hml +="<li><a href='#' onclick=\"init('"+a+"')\">"+(a+1)+"</a></li>";
			}
		}
		
	}
	if((Number(pageNo)+1) >= pageA){
		hml +="<li class='am-disabled'><a href='#'>»</a></li>";
	}else {
		hml +="<li ><a href='#' onclick=\"init('"+(Number(pageNo)+1)+"')\">»</a></li>";
	}
	$("#pageHtml").append(hml);
}
</script>
