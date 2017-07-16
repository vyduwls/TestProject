<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
    
    
    <div id="mypage_left">
		
		<ul>	
		<c:if test="${sessionScope.aa==0}">
    	   <li><a href="${pageContext.request.contextPath}/member/infoEdit.do">회원정보수정</a></li>
         	<li><a href="${pageContext.request.contextPath}/mypage/orderList.do">주문내역</a></li>
         	<li><a href="${pageContext.request.contextPath}/mypage/noticeList.do">내가쓴글</a>
        </c:if>
        <c:if test="${sessionScope.aa==1 or mid==1}">
        	<li><a href="${pageContext.request.contextPath}/member/infoEdit.do">회원정보수정</a></li>
         	<li><a href="${pageContext.request.contextPath}/mypage/orderList.do">주문내역</a></li>
        	<li><a href="${pageContext.request.contextPath}/mypage/regStore.do">가게정보등록</a></li>
        	<li><a href="${pageContext.request.contextPath}/mypage/updateStore.do">가게정보수정</a></li>
       		<li><a href="${pageContext.request.contextPath}/mypage/regMenu.do">가게메뉴등록</a></li>
       		<li><a href="${pageContext.request.contextPath}/mypage/updateMenu.do">가게메뉴수정</a></li>
       		<li><a href="${pageContext.request.contextPath}/mypage/storeSales.do">가게매출</a></li>
        	<li><p>내가쓴글</p>
        </c:if>		
    	</ul>      
    </div>
    

