<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type="text/javascript">
		$(document).ready(function(){
			// 선택한 상품 합계 구하기
		    $("input[name=basketseq]").click(function(){		  
				selectpricecal();
			  });
			
		 	// 상품 수량 빼기
		 	$(".amount_minus").click(function(){
		 		plusorminus(this,1);
		
		 	});
		 	// 상품 수량 더하기
			$(".amount_plus").click(function(){
		 		plusorminus(this,2);
		
		 	});
			// 모든 체크박스 체크하기
			$("#allcheck").click(function(){
					//클릭되었으면
					if($("#allcheck").prop("checked")){ 
						//input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
						$("input[name=basketseq]").prop("checked",true); 
						//클릭이 안되있으면 
						}else{ 
							//input태그의 name이 chk인 태그들을 찾아서 checked옵션을 false로 정의
							$("input[name=basketseq]").prop("checked",false);
						}
					
					selectpricecal();
			});
			
		
			// 선택 상품 삭제하기
			 $("#selectdel").click(function(){
				 var checkRow=selectcheckBox();
				  if(checkRow == ''){
					    alert("삭제할 대상을 선택하세요.");
					    return false;
					  }
			 
					  if(confirm("선택한 상품을 삭제하시겠습니까?")){
				    		$.ajax({
				        		url: "delbasket.do",
				    			type:"POST",
				    			data:{"basketseqs":checkRow,"all":"0"},
				        		dataType:"json",
				        		success:function(data){
									if($.trim(data)==0){
										alert("삭제 실패");
									}else{
										alert("삭제 성공");
										location.reload();
									}
				        		}
				   	 		}); 
				   		}
			}); 
			// 전체상품 삭제하기
				$("#totaldel").click(function(){
				  if(confirm("장바구니를 비우시겠습니까?")){
			    		$.ajax({
			        		url: "delbasket.do",
			    			type:"POST",
			    			data:{"all":"1"},
			        		dataType:"json",
			        		success:function(data){
								if($.trim(data)==0){
									alert("전체삭제 실패");
								}else{
									alert("전체삭제 성공");
									location.reload();
								}
			        		}
			   	 		}); 
			   		}
			});
			//상품 수량 저장하기
		$(".updatebas").click(function(){
			 	$.ajax({
		    		url: "updatebasket.do",
					type:"POST",
					data:{"amount1":$(this).siblings(".amount").val(),"menuprice1":$(this).parent().siblings(".price").children(".menuprice").val(),"basketseq":$(this).siblings(".basketseq").val()},
		    		dataType:"text",
		    		success:function(data){
						if($.trim(data)==0){
							alert("장바구니 변경 실패");
						}else{
							alert("장바구니 변경  성공");
							location.reload();
						}
		    		}
			 		}); 
			});
			
				//선택상품 주문하기 
				$("#selectorder").click(function(){
					var checkRow=selectcheckBox();
				  if(checkRow == ''){
					    alert("주문 할  상품을 선택하세요.");
					    return false;
					  }
				  $("#basketseqs").val(checkRow);
				});
				//전체상품 주문하기
				$("#allselectorder").click(function(){
					$("#basketseqs").val("0");
				});
		});
		
		function selectcheckBox(){
			  var checkRow = "";
			  $( "input[name=basketseq]:checked" ).each (function (){
			    checkRow = checkRow+ $(this).val()+"," ;
			  });
		
			  checkRow = checkRow.substring(0,checkRow.lastIndexOf( ",")); //맨끝 콤마 지우기
		
			  return checkRow;
		}
		function selectpricecal(){
			  var selectprice =0;
			  $("input[name=basketseq]:checked").each (function (){
				  selectprice = selectprice + Number($(this).parent().siblings(".price").children("span").text()) ;
			  });
			  $("#selectprice").text(selectprice);
		}
		
		function plusorminus(data,add){
			var amount = $(data).siblings(".amount").val();
				var price = $(data).parent().siblings(".price").children("span").text()/amount;
				var totalprice=Number($("#totalprice").text());
				totalprice=totalprice- $(data).parent().siblings(".price").children("span").text();
				
				if(add==1){
					amount--;
				}else{
					amount++;
				}
				
				if(amount>=1){
				$(data).siblings(".amount").val(amount);
				$(data).parent().siblings(".price").children("span").text(price*amount);
			totalprice=totalprice+price*amount;
			$("#totalprice").text(totalprice);
			selectpricecal();
				}
		}
</script>
<section id="global-header" style="padding-bottom: 50px;padding-top: 50px;" >
        <div class="container" >
            <div class="row">
                <div class="col-md-12">
                    <div class="block">
                        <h1 style="padding-top: 15px">Shopping Baskets</h1>
                        <p>장바구니</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
	<br>
	<br>
    
<!--     Table 			-->
	<div class="table-wrapper" style="width: 80%; margin:auto;">

    	<span> </span><button type="button" id="selectdel" class="btn btn-default">선택삭제</button><span> </span><button type="button" id="totaldel" class="btn btn-default" >장바구니 비우기</button>
		<br><br>

		<table>
			<thead style="text-align: center;">
				<tr>
					<th id="basket_th"><input type="checkbox" id="allcheck" onclick="allcheck()"></th>
					<th id="basket_th">주문번호</th>
					<th id="basket_th">주문매장</th>
					<th id="basket_th">주문메뉴</th>
					<th id="basket_th">주문수량</th>
					<th id="basket_th">결제금액</th>
					<th id="basket_th">도착시간</th>
					<th id="basket_th">기타 요구사항</th>
				</tr>
			</thead>
			<tbody style="font-family: delivery">
				<c:forEach varStatus="m"  var="n" items="${basketList}">
					<tr>
						<td id="basket_td"><input type="checkbox" name="basketseq" value="${n.basketseq}" class="selectbox" /></td>
						<td id="basket_td">${m.index+1}</td>
						<td id="basket_td">${n.storename}</td>
						<c:set var="imagesArray" value='${fn:split(n.img, "\\\\")}' />
						<td id="basket_td1"><img id="menuimg" style="height: 80px" src="${pageContext.request.contextPath}/${imagesArray[fn:length(imagesArray)-2]}/${imagesArray[fn:length(imagesArray)-1]}">${n.menuname}</td>
						<td id="basket_td">
								<button class="amount_minus">-</button>
										<input type="text" name="amount" value="${n.amount}" style="width:80px;text-align: center;" class="amount" readonly="readonly">
								<button class="amount_plus">+</button> 
 									<input type="hidden" name="basketseq" value="${n.basketseq}" class="basketseq"> 
								<button type="button" class="updatebas">저장</button>
						</td>
						<td id="basket_td" class="price"><span class="price1" >${n.totalprice} </span><input type="hidden" value="${n.menuprice}" class="menuprice"></td>
						<td id="basket_td">${n.time}</td>
						<td id="basket_td">${n.requirements}</td>
					</tr>
				</c:forEach>			
			</tbody>
		</table>
		<form action="order.do" method="post">
		<table>
			<thead>
				<tr>
					<th style="font-size: 28px;">상품 총 금액 :<span id="totalprice" style="color:red">${totalprice}</span><br> 선택상품 총 금액 :<span id="selectprice" style="color:red">0</span></th>
				</tr>
			</thead>
				<tr>
				<th>
					<input type="hidden" name="basketseqs" value="" id="basketseqs">
					<button type="submit" id="selectorder" class="btn btn-default">선택상품 주문하기</button><span>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span><button type="submit" id="allselectorder" class="btn btn-default">전체상품 주문하기</button>
				</th>
			</tr>
		</table>
		</form>	

</div>
<div></div>

