<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<script src="${pageContext.request.contextPath}/js/vendor/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">

$(document).ready(function(){
 	$(".getDaysSales").click(function(){
 		$("body").css("overflow","hidden");
 		$(".sales_table_body").empty();
	  	$.ajax({
			url:"getDaysSales.do",
			type:"POST",
			data:{"day":$(this).children("input").val(),"storeSeq":"${seq}","mon":"${mon}"},
			dataType:"json",
			success : function(data) {
	 			$.each(data,function(index,key){
	 				$(".storeNameinput").text(key.orderdate+" ["+key.storename+"] 매출 ");
	 				$(".sales_table_body").append("<tr style='text-align:center;'><td class='daySales_td' style='text-align:center;height:20px;'>"+(index+1)+"</td><td class='daySales_td' style='text-align:center;height:20px;'>"+key.pickupTime+"</td><td class='daySales_td' style='text-align:center;height:20px;'>"+key.menuname+"</td><td class='daySales_td' style='text-align:center;height:20px;'>"+key.amount+"</td><td class='daySales_td' style='text-align:center;color:red;height:20px;font-size:18px;'>"+key.price+"</td><td class='daySales_td' style='text-align:center;height:20px;'>"+key.statement+"</td></tr>")
	 			
				});
		 		$(".work_modal").css("display", "block");
			},
		     error:function(request,status,error){
		         alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		        }
		}); 
	});
 	
    $("#work_modal_close").click(function() {
        $(".work_modal").css({
            "display" : "none",
        })
         $("body").css("overflow", "");
    })
    $(".work_modal").click(function(event) {
        if (event.target.className == "work_modal") {
            $(".work_modal").css({
                "display" : "none",
            })
        }
        $("body").css("overflow", "");
    })
});
</script>
<style type="text/css">
 .work_modal {
	width:100%;
	height: 100%;
	background-color: rgb(0,0,0);
	background-color: rgba(0,0,0,0.4);  
	left:0;
	top:0;
	z-index: 1;
	position: fixed;
 	padding-top: 100px;
 	display: none; 
 	text-align: center;

} 
#work_modal-content{
/*  	margin-top: 15%; */
  	margin-left:15%; 
	width:70%;
	height:70%;
	overflow:auto;
/*  	height: 800px;  */
/* 	background-color: rgba(254, 254, 254, 1); */
	background-color: white;
/* 	margin: auto; */
	text-align: center;
}
 </style>
		<body>
			<div class="work_modal" class="work_modal">
				<div id="work_modal-content">
					<div style="height: 10%;"><span id="work_modal_close">&times;</span></div>
					<p class="storeNameinput" style="font-weight: bold;font-size: 30px"></p>
					<table style="width:90%;margin-left: 5%;margin-top: 30px;">
						<thead style="text-align: center;">
							<tr>
								<th class="daySales_th" style="text-align: center;">번호</th>
								<th class="daySales_th" style="text-align: center;">주문시간</th>
								<th class="daySales_th" style="text-align: center;">주문메뉴</th>
								<th class="daySales_th" style="text-align: center;">주문수량</th>
								<th class="daySales_th" style="text-align: center;">결제금액</th>
								<th class="daySales_th" style="text-align: center;">주문상황</th>
							</tr>
						</thead>
						<tbody style="font-family: hyundai" class="sales_table_body">
<!-- 							<tr>
								<td class="daySales_td"><span class="number"></span></td>
								<td class="daySales_td"><span class="menuname"></span></td>
								<td class="daySales_td"><span class="amount"></span></td>
								<td class="daySales_td"><span class="price"></span></td>
								<td class="daySales_td"><span class="statement"></span></td>
							</tr>	 -->		
					</tbody>
				</table>
<!-- 			    <div id="modal_down">
			         <input type="button" onclick="mysubmit(1)" id="okay_btn" value="장바구니에 넣기"> <input type="submit" onclick="mysubmit(2)" id="okay_btn" value="바로 결제하기"> 
			         <input type="button" onclick="mysubmit(3)" id="okay_btn" value="이전으로">
			
			     </div> -->
			    </div>
			</div>
		    <br><br>
		 <div id="duwlspage_content">
		        <h2 id="mypage_content_h2">[${salesList[0].storeName}] ${mon}월 가게 매출 내역</h2>
				<br>
		<form action="storeSales.do" method="post">
가게선택 : <select  name="seq">
			<c:forEach items="${storeList}" var="n">
				<c:if test="${n.seq==seq}">
				<option value="${n.seq}" selected="selected">${n.storeName}</option>
				</c:if>
				<c:if test="${n.seq!=seq}">
				<option value="${n.seq}">${n.storeName}</option>
				</c:if>
			</c:forEach>	
		</select> <span>&nbsp&nbsp</span>
		월 선택 : <select name="month">
			<c:forEach begin="1" end="${Nowmonth}" var="n">
			<c:if test="${n==mon}">
				<option  value="${n}" selected="selected">${n}월</option>
			</c:if>
			<c:if test="${n!=mon}">
				<option  value="${n}">${n}월</option>
			</c:if>
			</c:forEach>
		</select>
		<button type="submit" class="btn btn-default changeStore">변경</button>
		</form>
		 <div id="curve_chart" style="width: 93%; height: 300px;margin-left: 70px"></div>
		 <br>
		 
		 <table style="width: 100%;margin: auto;height:100px; ">
		 	<tr>
		 		<th>${mon}월</th>
		 		<c:forEach begin="1" end="15" var="n">
		 		<th style="width:6%">${n}</th>
		 		</c:forEach>
		 	</tr>
		 	<tr>
		 		<th>Sales</th>
		 		<c:forEach begin="0" end="14" var="m" varStatus="n">
 		 		<c:if test="${salesList[m].sales!='0'}">
		 		<th  class="getDaysSales" style="cursor: pointer"><span>${salesList[m].sales}</span><input type="hidden" name="day" value="${m+1}"></th>
 		 		</c:if>
		 		<c:if test="${salesList[m].sales=='0'}">
		 		<th><span>${salesList[m].sales}</span><input type="hidden" name="day" value="${m+1}"></th>
		 		</c:if>	
		 		</c:forEach>
		 	</tr> 
		 </table>
		 <br>
 		<table style="width: 100%;margin: auto;height:100px; ">
		 	<tr>
		 	<c:forEach begin="16" end="${day}" var="n">
		 		<th style="width:6%">${n}</th>
		 		</c:forEach>
		 		<th style="font-weight: bold; color:black;font-size: 13px;">총 매출</th>
		 	</tr>
		 	<tr>
		 		<c:forEach begin="15" end="${day-1}" var="m" varStatus="n">
 		 		<c:if test="${salesList[m].sales!='0'}">
		 		<th  class="getDaysSales" style="cursor: pointer"><span>${salesList[m].sales}</span><input type="hidden" name="day" value="${m+1}"></th>
 		 		</c:if>
		 		<c:if test="${salesList[m].sales=='0'}">
		 		<th><span>${salesList[m].sales}</span><input type="hidden" name="day" value="${m+1}"></th>
		 		</c:if>				
		 		</c:forEach>
		 		<th style="font-weight: bold; color:red;font-size: 13px;">${totalSales}원</th>
		 	</tr> 
		 </table>
		 <br><br>
		 
		 <p></p>
		 
		 
		</div>
		 
		  <br><br>
 
 
	 
	 
	<script type="text/javascript">
	      google.charts.load('current', {'packages':['corechart']});
	      google.charts.setOnLoadCallback(drawChart);
	
	      function drawChart() {
	        var data = google.visualization.arrayToDataTable(${data});

	        var options = {
	          title: '${salesList[0].storeName}',
	          curveType: 'function',
	          legend: { position: 'bottom' },
	          yaxis:{min:0}
			
	        };
	
	        var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));
	
	        chart.draw(data, options);
	      }
	    </script>

</body>
</html>