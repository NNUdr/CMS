<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${pageContext.request.contextPath}/highcharts4/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/highcharts4/js/highcharts.js" type="text/javascript"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/highcharts4/js/modules/exporting.js"></script>  
<script type="text/javascript">

Highcharts.setOptions({
	lang:{
			contextButtonTitle:"图表导出菜单",
			decimalPoint:".",
			downloadJPEG:"下载JPEG图片",
			downloadPDF:"下载PDF文件",
			downloadPNG:"下载PNG文件",
			downloadSVG:"下载SVG文件",
			printChart:"打印图表"
				}
});
$(function () {
	
	 var colors = ['#F59656', '#90BF18', '#EDCA4E'];  
     Highcharts.getOptions().colors = Highcharts.map(colors, function (color) {  
                 return {  
                     radialGradient: { cx:0, cy: -0.8,r:2.3 },  
                     stops: [[0, color], [2, Highcharts.Color(color).brighten(14).get('rgb')] // darken   
                     ]  
                 };  
             });  
     
     
	var chart=new Highcharts.Chart({
		chart: {
			renderTo:'container',
            type: 'column',
            events:{
            	load:function(event){
            		// ajax请求后台加载数据
            		$.post("${pageContext.request.contextPath}/customer/findCustomerGc.do",{},function(result){
            			var xArr=new Array();
            			var yArr=new Array();
            			for(var i=0;i<result.length;i++){
            				xArr.push(result[i].customerLevel);
            				yArr.push(result[i].customerNum);
            				chart.xAxis[0].categories=xArr;
            				chart.series[0].setData(yArr);
            			}
            		},"json");
            	}
            }
        },
        title: {            //主标题
            text: '客户构成报表'
        },
        xAxis: {
        	title:'客户',
            categories: [
                'A',
                'B',
                'C'
            ]
        },credits:{  
            enabled:false // 禁用版权信息  
        },  
        yAxis: {
            title: {
                text: '客户数量'
            }
        },
        series: [{
            name: '客户等级',
            data: [1,2,3]
        }]
	});
});
 
</script>
<title>客户构成报表</title>
</head>
<body style="margin: 1px">
 <div id="container" style="min-width: 800px;height: 400px"></div>
</body>
</html>