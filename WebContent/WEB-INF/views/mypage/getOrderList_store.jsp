<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<script src="${pageContext.request.contextPath}/js/vendor/jquery-1.10.2.min.js"></script>
<script type="text/javascript">
	 $(document).ready(function(){
		 $(".statement").click(function(){
			 if(confirm("주문을 확인하셨습니까?")){
				 $.ajax({
					 context:this,
					url:"updateOrderstatement.do",
					type:"POST",
					data:{"seq":$(this).siblings("input[name=statement]").val(),"index":$(this).siblings("input[name=index]").val()},
					dataType:"text",
					success:function(data){
						$(this).hide();
						$(this).parents("td").text("확인완료");
					}
				 });
			 }
			 
		 });
		 
	 });
 </script>
 <style type="text/css">
 .work_modal,.work_modal1 {
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
#work_modal-content,#work_modal1-content{
/*  	margin-top: 15%; */
 	margin-left:40%;
	width:380px;
/*  	height: 800px;  */
	background-color: rgba(254, 254, 254, 1);
/* 	margin: auto; */
	text-align: center;
	height:400px;
	overflow:auto;
}
 </style>
 
<br><br>
    
    <div id="mypage_content">
        <h2 id="mypage_content_h2">"${storeName}" 주문 내역 확인</h2>
        <form action="getOrderList_store.do" method="post">
가게선택 : <select  name="seq">
			<c:forEach items="${storeList}" var="n">
				<c:if test="${n.seq==seq}">
				<option value="${n.seq}" selected="selected">${n.storeName}</option>
				</c:if>
				<c:if test="${n.seq!=seq}">
				<option value="${n.seq}">${n.storeName}</option>
				</c:if>
			</c:forEach>	
		</select>
		<button type="submit" class="btn btn-default changeStore">변경</button>
        </form>
       <div class="table-wrapper" style="width: 100%; margin-left: 5%">
		<br><br>

		<table>
			<thead style="text-align: center;">
				<tr>
					<th class="order_th" style="text-align: center;">번호</th>
					<th class="order_th" style="text-align: center;">주문날짜</th>
					<th class="order_th" style="text-align: center;">주문자 이름</th>
					<th class="order_th" style="text-align: center;">주문메뉴</th>
					<th class="order_th" style="text-align: center;">주문수량</th>
					<th class="order_th" style="text-align: center;">결제금액</th>
					<th class="order_th" style="text-align: center;">도착시간</th>
					<th class="order_th" style="text-align: center;">요구사항</th>
					<th class="order_th" style="text-align: center;">주문상황</th>
				</tr>
			</thead>
			<tbody style="font-family: hyundai">
				<c:forEach varStatus="m"  var="n" items="${orderList}">
					<tr>
						<td class="order_td">${m.index+1}</td>
						<td class="order_td">${n.orderdate}</td>
						<td class="order_td">${n.orderer}</td>
						<td class="order_td">${n.menuname}</td>
						<td class="order_td">${n.amount}</td>
						<td class="order_td">${n.price}</td>
						<td class="order_td">${n.pickupTime}</td>
						<td class="order_td">${n.requirements}</td>
						<c:if test="${n.statement=='주문완료'}">
						<td class="order_td"><button class="btn btn-default statement">주문확인</button>
						<input type="hidden" name="statement" value="${n.orderseq}"></td>
						</c:if>
						<c:if test="${n.statement=='확인완료'}">
						<td class="order_td">${n.statement}</td>
						</c:if>
												
					</tr>
				</c:forEach>			
			</tbody>
		</table>


</div>
</div>

    <script src="${pageContext.request.contextPath}/js/vendor/jquery-1.10.2.min.js"></script>
    <br><br>
   

</body>
</html>
