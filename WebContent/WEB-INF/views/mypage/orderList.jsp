<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<script src="${pageContext.request.contextPath}/js/vendor/jquery-1.10.2.min.js"></script>
<script type="text/javascript">
	 $(document).ready(function(){
		 	$(".seecomment").click(function(){
		 		var like="";
		 		$("body").css("overflow","hidden");
				$.ajax({
					url:"selectComment.do",
					type:"POST",
					data:{"cseq":$(this).siblings("input").val()},
					dataType:"json",
					success : function(data) {
					$.each(data,function(key,value){
						if(key=="likes"){
							if(value=="1"){
								like="★☆☆☆☆";
							}else if(value=="2"){
								like="★★☆☆☆";
							}else if(value=="3"){
								like="★★★☆☆";
							}else if(value=="4"){
								like="★★★★☆";
							}else if(value=="5"){
								like="★★★★★";
							}
							$(".likes").text(like);
						}else if(key=="content"){
							$(".content").text(value);
						}else if(key=="cseq"){
							$("input[name=cseq]").val(value);
						}else if(key=="regDate"){
							$(".regdate").text(value.substring(0,11));
						}else if(key=="images"){
							$(".images").attr("src",value);
						}
					});
		 		$(".work_modal1").css("display", "block");
					}
				});
			
		 	});
		 	$(".regcomment").click(function(){
		 		$("body").css("overflow","hidden");
 		 		$("input[name=coseq]").val($(this).siblings("input").val());
		 		$(".work_modal").css("display", "block");
		 	   
		 	}); 

		 	$(".cancelbtn").click(function(){
				$(".content").text(" ");
		 		$(".work_modal").css("display", "none");
		 		$(".work_modal1").css("display", "none");
		        $("body").css("overflow", "");
		 	}); 
		 	
		 		var upload= document.getElementById(".images");
		 	    var holder = document.getElementById(".holder");
		 	    upload.onchange=function(e){
		 	        e.preventDefault();
		 	        
		 	        var file = upload.files[0];
		 	        var reader = new FileReader();
		 	        reader.onload=function(event){
		 	            var img = new Image();
		 	            img.src=event.target.result;
		 	            if(img.width>500){
		 	                img.width=500;
		 	            }
		 	            holder.innerHTML="";
		 	            holder.appendChild(img);
		 	            console.log(img);
		 	        };
		 	        reader.readAsDataURL(file);
		 	        console.log(file);
		 	        
		 	        return false;
		 	    };
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


    <div class="work_modal" id="open">
    
        <div id="work_modal-content">
            <form action="insertComment.do" method="post"  enctype="multipart/form-data">
            <br>
            <p style="font-weight: bold;font-size: 15px;">댓글 달기 !</p>
            <p>솔직한 한줄 댓글을 남겨주세요~♡</p>
           	 평점 :<select name="likes">
					<option value="5" selected>★★★★★</option>
					<option value="4">★★★★☆</option>
					<option value="3">★★★☆☆</option>
					<option value="2">★★☆☆☆</option>
					<option value="1">★☆☆☆☆</option>
         	   </select>
         	<br><br>
         	<span style="font-weight: bold;text-decoration: underline;">첨부파일</span>  
         	<br>
         	<input type="file" class="images" name = "imgFile" style="text-align: center;margin-left: 60px;"><br><br>
            <textarea rows="7" cols="45" name="content"></textarea>
            <input type="hidden" name="coseq" value="">
            <button type="submit" class="btn btn-default savebtn" >저장</button>
            <button type="button" class="btn btn-default cancelbtn">취소</button>
            </form>
            <br>
        </div>
    </div>
    
    <div class="work_modal1" id="open">
    
        <div id="work_modal1-content">
     	   <br>
            <p style="font-weight: bold;font-size: 15px;">내가 쓴 한줄 댓글^-^</p>
            <form action="delComment.do" method="post">
           	작성일 : <span class="regdate"></span>&nbsp&nbsp&nbsp 평점 : <span class="likes"> </span><br><br>
            <span style="font-weight: bold;text-decoration: underline;">첨부파일</span><br>
<!--           	<input type="file" class="images" name = "imgFile" style="text-align: center;margin-left: 60px;"><br><br> -->
            <div class="holder">
            <img alt="" src="" class="images" style="width: 200px;">
       		<textarea rows="7" cols="40" name="content" class="content" readonly="readonly"></textarea>
       		</div>
            <input type="hidden" name="cseq" value="">
            <button type="submit" class="btn btn-default delbtn" >삭제</button>
            <button type="button" class="btn btn-default cancelbtn">닫기</button>
            </form>
            <br>
        </div>
    </div>
    
    
    <div id="mypage_content">
        <h2 id="mypage_content_h2">주문 내역</h2>
       <div class="table-wrapper" style="width: 100%; margin-left: 5%">
		<br><br>

		<table>
			<thead style="text-align: center;">
				<tr>
					<th class="order_th" style="text-align: center;">번호</th>
					<th class="order_th" style="text-align: center;">주문날짜</th>
					<th class="order_th" style="text-align: center;">주문매장</th>
					<th class="order_th" style="text-align: center;">주문메뉴</th>
					<th class="order_th" style="text-align: center;">주문수량</th>
					<th class="order_th" style="text-align: center;">결제금액</th>
					<th class="order_th" style="text-align: center;">도착시간</th>
					<th class="order_th" style="text-align: center;">주문상황</th>
					<th class="order_th" style="text-align: center;">한줄 후기</th>
				</tr>
			</thead>
			<tbody style="font-family: hyundai">
				<c:forEach varStatus="m"  var="n" items="${orderList}">
					<tr>
						<td class="order_td">${m.index+1}</td>
						<td class="order_td">${n.orderdate}</td>
						<td class="order_td">${n.storename}</td>
						<td class="order_td">${n.menuname}</td>
						<td class="order_td">${n.amount}</td>
						<td class="order_td">${n.price}</td>
						<td class="order_td">${n.pickupTime}</td>
						<c:if test="${n.statement=='주문완료'}">
						<td class="order_td" style="color:red;">${n.statement}</td>
						</c:if>
						<c:if test="${n.statement=='확인완료'}">
						<td class="order_td"  style="color:black;">${n.statement}</td>
						</c:if>
						<c:if test="${n.commentsstate!='0'}">
								<td id="order_td" style="text-align: center;"><input type="hidden" name="cseq1" value="${n.commentsstate}"><button class="btn btn-default seecomment" style="color:blue;">댓글보기</button></td> 
						</c:if>
						<c:if test="${n.commentsstate=='0'}">
								<td id="order_td" style="text-align: center;"><input type="hidden" name="orderseq1" value="${n.orderseq}"><button class="btn btn-default regcomment" style="color:red;">댓글달기</button></td>
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
