<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>주문하기</title>
<script type="text/javascript">

</script>
 <style type="text/css">
 .order_sc {
   width: 100%;
   border: 0;
   text-align: center;
   color: #7d7d7d;
   position: relative;
   border: 1px solid #e3e4e5;
}
table{
	width: 100%;
}
 
/*  table tbody tr {
	border: solid 1px #f9f7f7;
	text-align: center;
} */
 
.store_info{
	text-align: center;
	font-size: 15px;
	font-weight: bold;
}
.store_detailinfo,#basket_td{
	text-align: center;
	font-size: 15px;
	color: #777;
}
.store_detailinfo {
	height: 50px;
}
 
.addr_list {
   margin-top: 15px;
   padding-top: 7px;
   border-top: 1px solid #e8e8e8;
   padding: 14px 0 20px;
   line-height: 17px;
   color: #000;
}

.store {
   float: left;
   padding: 31px 50px 0 49px;
   width: 800px;
   border-left: 1px solid #fff;
   border-right: 1px solid #fff;
}

.user {
   float: right;
   padding: 31px 50px 0;
   border-right: 1px solid #fff;
   border-left: 1px solid #e3e4e5;
   height: 350px;
   width: 280px;
   color: #7d7d7d;
}

.textarea {
   width: 548px;
   height: 28px;
   padding: 0 34px 0 10px;
   border: 1px solid #e5e5e5;
   line-height: 26px;
}

.main {
   font-family: '나눔고딕', NanumGothic, '맑은고딕', MalgunGothic, '돋움', Dotum,
      Helvetica, sans-serif;
   font-size: 12px;
   width: 1100px;
   margin: 0 auto;
   border: 1px solid #e3e4e5;
}

.pay {
   width: 1100px;
   height: 350px;
}

.phone {
   color: red;
   font-size: 13px;
   line-height: 19px;
}

.cash {
   border-top: 1px solid #e3e4e5;
   border-right: 1px solid #e3e4e5;
   padding: 31px 50px 0 52px;
   width: 821px;
   height: 233px;
}

button {
   width: 68px;
   height: 26px;
   border: 1px solid #d0d0d0;
   color: #4c4c4c;
   background-color: #fff;
}

.price {
   float: right;
   padding: 10px 50px 0;
   border: 1px solid #e9e9e9;
   border-right-color: #fff;
   border-bottom: 0;
/*    border-left: 0; */
   width: 277px;
}

.cashmain {
   width: 1100px;
   height: 400px;
}

.cashmain, .cash, .price {
   display: inline-block;
}

.select_ul {
   display: table;
   width: 100%;
   border-collapse: collapse;
   table-layout: fixed;
   zoom: 1;
}

.select_ul a {
   display: block;
   line-height: 32px;
   font-weight: bold;
   color: #7A7E81;
}

.select_menu {
   display: table-cell;
   height: 32px;
   border-left: 1px solid #dfe1e5;
   background-color: #afcce6;
   text-align: center;
}

.payment_info {
   position: relative;
   float: left;
   padding: 32px 10px 0 51px;
   border: 1px solid #e9e9e9;
   border-top-color: #e9e9e9;
   border-bottom-color: #f0f0f0;
   border-right-color: #e9e9e9;
   border-left-color: #e9e9e9;
   border-bottom: 0;
   width: 821px;
   height: 100%;
}

.select_payment {
   margin-top: -1px;
   padding: 20px;
   padding-top: 0px;
   padding-bottom: 30px;
   border: 1px solid #e8e8e8;
   background: #fff;
   width: 100%;
/*     margin-left: 40px; */
}

.payment_item {
   margin-left: 45px;
   float: left;
   color: #000;
   list-style: none;
   font-size: 15px;
}

.payment_card {
   float: left;
   max-width: 544px;
   color: #000;
   margin-top: 20px;
   display: inline;
   font-size: 15px;
   width: 700px;
}

.payment_card1 {
   float: left;
   max-width: 544px;
   color: #000;
   margin-top: 0px;
   display: inline;
   font-size: 15px;
   width: 700px;
}

.card {
   list-style: none;
   float: left;
   padding-left: 40px;
   font-size: 12px;
}

.payment_card, .select_card {
   display: inline-block;
}

.list_card {
   width: 120px;
   padding-top: 40px;
   margin-top: 40px;
   font-size: 15px;
}

.card_list {
   float: right;
}

.select {
   padding-left: 40px;
}

.last, .price1, .payment_info {
   display: inline-block;
}

.price1 {
}

.btn_payment {
   width: 198px;
   height: 56px;
}
.btn{
       width: 145px;


}
.btn123 {
   background-color: #555555;
    border: none;
    color: white;
    padding: 24px 45px 24px 45px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin-top: 64px;
    margin-left: -17px;
}
.btndiv {
   border-bottom-color: #f0f0f0;
} 
</style>
</head>
<body>
   <section id="global-header"
      style="padding-bottom: 50px;padding-top: 50px;">
   <div class="container">
      <div class="row">
         <div class="col-md-12">
            <div class="block">
               <h1 style="padding-top: 15px">Order</h1>
               <p>주문하기</p>
            </div>
         </div>
      </div>
   </div>
   </section>
   <br>
   <br>

   <!--     Table          -->
   <div class="table-wrapper" style="width: 85%; margin: auto;">

      <span> </span>
      <br>
      <br>
	  <h2>주문 상품 확인</h2>
      <table>
         <thead style="text-align: center;">
            <tr>
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
         	<c:forEach items="${basketList}" var="n" varStatus="m">
               <tr>
                  <td id="basket_td">${m.index+1}</td>
                  <td id="basket_td">${n.storename}</td>

			      <c:set var="imagesArray" value='${fn:split(n.img, "\\\\")}' />
			      <td id="basket_td" style="text-align: left;padding-left:250px;">
			      <img id="menuimg" style="height: 80px; margin-left: 43px;"
                     src="${pageContext.request.contextPath}/${imagesArray[fn:length(imagesArray)-2]}/${imagesArray[fn:length(imagesArray)-1]}">${n.menuname}</td>
                  <td id="basket_td"><input type="text" name="amount" value="${n.amount}"
                    style="width: 80px; text-align: center;"></td>
                  <td id="basket_td">${n.totalprice}</td>
                  <td id="basket_td">${n.time}</td>
                  <td id="basket_td">${n.requirements}</td>
               </tr>
            </c:forEach>
           
         </tbody> 
      </table>
   </div>
   <div class="main">
         <div class="order_sc">
            <div class="area"></div>
         </div>
         <div class="pay">
            <div class="store">
               <strong class="req" title="필수입력" style="font-size: 20px">매장 정보 </strong><br><br>
            	<table class="store_infotable">
            		<tr>
            			<th class="store_info">번호</th>
            			<th class="store_info">매장 명</th>
            			<th class="store_info">매장 위치</th>
            			<th class="store_info">전화번호</th>
            		</tr>
         	   <c:forEach items="${storeList}" var="n" varStatus="m">
            		<tr>
            			<td class="store_detailinfo">${m.index+1}</td>
            			<td class="store_detailinfo">${n.storeName}</td>
            			<td class="store_detailinfo">${n.address}</td>
            			<td class="store_detailinfo">${n.phoneNumber}</td>
            		</tr>
            	</c:forEach>
            	</table>

            </div>
            <div class="user">
               <strong class="req" title="필수입력" style="font-size: 20px">주문자 정보</strong>
	               <ul class="user_info">
	         	      <li> <h4> 아이디 : ${sessionScope.mid}  </h4></li>
	          	      <li> <h4> 전화번호 : ${basketList[0].phoneNumber} </h4></li>
	               </ul>
               <ul class="info_dsc">
                  <li class="info_confirm"><span class="phone"><strong>휴대폰
                           번호가 등록되지 않으면 정확한 주문/결제 알림을 받지 못할 수 있습니다.</strong><br> <br></span> <span
                     class="" style="display: block"> 주문자 정보로 결제관련 정보가 제공됩니다.<br>정확한
                        정보로 등록되어있는지 확인해주세요.
                  </span></li>
               </ul>
            </div>
         </div>
         <div class="cahsmain">
            <div class="cash">

               <h4>
                 <strong class="req" title="필수입력" style="font-size: 20px">할인 및 적립</strong><br><br>
               </h4>
               <table cellspacing="0" class="tb_discount">
                  <colgroup>
                     <col width="138">
                     <col>
                  </colgroup>
                  <tbody class="discountPriceInfo">
                     <tr>
                        <th>할인 금액</th>
                        <td>
                           <div class="input_area">
                              <input name="" id="" value="0" class=""
                                 disabled="disabled"> <span class="measure">원</span>
                              <ul class="">
                              </ul>
                           </div>
                        </td>
                     </tr>
                     <tr>
                        <th>할인쿠폰</th>
                        <td>
                           <div class="input_area" style="display: inline;">
                              <input name="" id="coupon" value="0" class="" title="할인쿠폰"
                                 disabled="disabled"> <span class="measure">원</span>
                           </div>
                           <div style="float: right; display: inline;">
                              <button class="" disabled="disabled">쿠폰사용</button>

                           </div>
                           <ul class="use_list">
                              <li>(사용가능 쿠폰 : <em>0 </em>장)
                              </li>
                           </ul>

                        </td>
                     </tr>
                     <tr>
                        <th>포인트</th>
                        <td>
                           <div class="input_area" style="display: inline;">
                              <input name="" id="coupon" value="0" class="" title="할인쿠폰"
                                 disabled="disabled"> <span class="measure">원</span>
                           </div>
                           <div style="float: right; display: inline;">
                              <button class="" disabled="disabled">전액사용</button>

                           </div>
                           <ul class="use_list">
                              <li>(사용가능 포인트 : <em>0 </em>포인트)
                              </li>
                           </ul>

                        </td>
                     </tr>
                  </tbody>
               </table>

            </div>
            <div class="price">
               <strong class="req" title="필수입력" style="font-size: 20px">결제금액</strong><br><br>
               <div class="sum _lastTotalAccountPrice">
               </div>
               <ul class="calc_list">
                  <li><strong style="font-size: 16px;">총 상품금액</strong><br>
                     <p>
                        <strong style="color:red;font-size: 16px;">${totalprice}</strong> &nbsp 원
                     </p></li>

                  <li><strong>할인금액</strong>
                     <p>
                        (-) 0 원
                     </p></li>
                  <li><strong>포인트 사용금액</strong>
                     <p>
                        (-) 0 원
                     </p></li>
               </ul>
            </div>
         </div>
         <div class="last">
            <div class="payment_info">
               <h4>
                  <strong class="req" title="필수입력" style="font-size: 20px">결제 정보</strong>
               </h4>
               <div class="payment">
<!--                   <div class="select" style="display: block;"> -->
                     <ul class="select_ul">
                        <li class="select_menu"><a href="#" class="">카드 간편결제</a></li>
                        <li class="select_menu"><a href="#" class="">계좌 간편결제</a></li>
                        <li class="select_menu"><a href="#" class="">일반 간편결제</a></li>
                     </ul>
<!--                   </div> -->
               </div>
               <div class="select_payment" >
                  <ul class="payment_list">
                     <li class="payment_item"  style="padding-left: 60px"><span class=""><input
                           type="radio" id="pay0" name="payMeansClass" value="CREDIT_CARD"
                           class="" checked="checked"></span> <label for="pay0">신용카드</label></li>
                     <li class="payment_item"><span class=""><span></span><input
                           type="radio" id="pay1" name="payMeansClass" value="BANK"
                           class=""></span> <label for="pay1">실시간계좌이체</label></li>
                     <li class="payment_item"><span class=""><span></span><input
                           type="radio" id="pay2" name="payMeansClass" value=""></span> <label
                        for="pay2">무통장입금</label></li>
                     <li class="payment_item"><span class=""><span></span><input
                           type="radio" id="pay3" name="payMeansClass" value="MOBILE"
                           class=""></span> <label for="pay3">휴대폰</label></li>

                  </ul>
               </div>
               <div class="payment_card">
                  <strong>카드 구분</strong>
                  <div class="select_card">
                     <ul>
                        <li class="card"><label><input type="radio"
                              name="card12" checked="checked">개인 카드</label></li>
                        <li class="card"><label><input type="radio"
                              name="card12">법인카드</label></li>
                     </ul>
                  </div>
               </div>



               <div class="list_card">
                  <strong class="sel">카드 선택</strong>
                  <div class="card_list">
                     <select id="select">
                        <option>국민</option>
                        <option>신한</option>
                        <option>삼성</option>
                        <option>농협</option>
                        <option>하나</option>

                     </select>
                  </div>
                  <div class="form-group" style="padding-top: 35px;">
                     카드번호 <input type="text" name="phone" class="form-control"
                        placeholder="(-)빼고 입력하세요">
                  </div>
               </div>

            </div>
            <div class="price1">
               <form action="orderProc.do">
               	  <input type="hidden" value="${basketseqs}" name="basketseqs">
                  <div class="btndiv" style="padding: 60px 55px 55px 80px; width: 275px; height: 339px;">
                     <input type="submit" class="btn123" value="결제하기">
                  </div>
               </form>
            </div>
         </div>

      </div> 
</body>
</html>