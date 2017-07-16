<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<header>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <!-- header Nav Start -->
            <nav class="navbar navbar-default">
            <div class="container-fluid">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="${pageContext.request.contextPath}/index.do"><img src="${pageContext.request.contextPath}/img/logo.png" alt="Logo"></a>
                </div>
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="${pageContext.request.contextPath}/store/store.do">매장검색</a></li>
                        <li><a href="${pageContext.request.contextPath}/order/shoppingbasket.do">장바구니</a></li>
                        <li><a href="${pageContext.request.contextPath}/notice/notice.do">자유게시판</a></li>
                        <c:if test="${empty sessionScope.mid}">
                            <li><a href="${pageContext.request.contextPath}/member/login.do" style="padding-left: 100px">로그인</a></li>
                            <li><a href="${pageContext.request.contextPath}/member/agree.do">회원가입</a></li>
                        </c:if>
                        <c:if test="${!empty sessionScope.mid}">
                            <%--                                         <li><a href="${pageContext.request.contextPath}/member/infoEdit.do?mid=${sessionScope.mid}">회원정보수정</a></li> --%>
                            <li><a href="${pageContext.request.contextPath}/mypage/mypage.do" style="padding-left: 100px">${sessionScope.mid}님 MyPage. </a></li>
                            <li><a href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a></li>
                        </c:if>
                    </ul>
                </div>


                <!-- /.navbar-collapse -->
            </div>
            <!-- /.container-fluid --> </nav>
        </div>
    </div>
</div>
</header>

<section id="global-header">
<div class="container" style="font-family: 'Roboto', sans-serif;">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <h1>My Page</h1>
            </div>
        </div>
    </div>
</div>
</section>

<style type="text/css">
#u1 {
    list-style: none;
    margin: 0;
    padding: 0;
    overflow: auto;
    margin-left: 120px;
}

.headerbtn {
    background-color: white;
}

#l1 {
    display: inline-block;
    margin: 1px;
    list-style: none;
    padding: 0 0 0 0;
    border: 0;
    float: left;
    background-color: gray;
    margin-right: 5px;
}

#mypage_left {
    margin-top: 440px;
}

/* #a1{ */
/* 	display: block; */
/* 	width: 150px; */
/* 	height: 40px; */
/* 	background: #c00; */
/* 	color: #fff; */
/* 	border: 1px solid blue; */

/* } */
</style>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!--     <div id="mypage_left" style="width: 1200px; margin-left: 200px; position:inherit; margin-top: 55px; margin: auto;"> -->

<!-- 		<ul id="u1">	 -->
<%-- 		<c:if test="${sessionScope.aa==0}"> --%>
<%--     	   <li id="l1"><a id="a1" href="${pageContext.request.contextPath}/member/infoEdit.do">회원정보수정</a></li> --%>
<%--          	<li id="l1"><a id="a1" href="${pageContext.request.contextPath}/mypage/orderList.do">주문내역</a></li> --%>
<%--          	<li id="l1"><a id="a1" href="${pageContext.request.contextPath}/mypage/noticeList.do">내가쓴글</a> --%>
<%--         </c:if> --%>
<%--         <c:if test="${sessionScope.aa==1 or mid==1}"> --%>
<%--         	<li id="l1"><a id="a1" href="${pageContext.request.contextPath}/member/infoEdit.do">회원정보수정</a></li> --%>
<%--          	<li id="l1"><a id="a1" href="${pageContext.request.contextPath}/mypage/orderList.do">주문내역</a></li> --%>
<%--         	<li id="l1"><a id="a1" href="${pageContext.request.contextPath}/mypage/regStore.do">가게정보등록</a></li> --%>
<%--         	<li id="l1"><a id="a1" href="${pageContext.request.contextPath}/mypage/updateStore.do">가게정보수정</a></li> --%>
<%--        		<li id="l1"><a id="a1" href="${pageContext.request.contextPath}/mypage/regMenu.do">가게메뉴등록</a></li> --%>
<%--        		<li id="l1"><a id="a1" href="${pageContext.request.contextPath}/mypage/updateMenu.do">가게메뉴수정</a></li> --%>
<%--        		<li id="l1"><a id="a1" href="${pageContext.request.contextPath}/mypage/storeSales.do">가게매출</a></li> --%>
<!--         	<li id="l1"><a>내가쓴글</a> -->
<%--         </c:if>		 --%>
<!--     	</ul>       -->
<!--     </div> -->
<div class="btn-group btn-group-justified" style="margin-top: 20px; display: table; margin-left: 15%; width: 70%;">
    <c:if test="${sessionScope.aa=='0'}">
        <a href="${pageContext.request.contextPath}/member/infoEdit.do" class="btn btn-default headerbtn">회원정보수정</a>
        <a href="${pageContext.request.contextPath}/mypage/orderList.do" class="btn btn-default headerbtn">나의주문내역</a>
        <a href="${pageContext.request.contextPath}/mypage/noticeList.do" class="btn btn-default headerbtn">내가쓴글</a>
    </c:if>
    <c:if test="${sessionScope.aa=='1' or mid=='1'}">
        <a href="${pageContext.request.contextPath}/member/infoEdit.do" class="btn btn-default headerbtn">회원정보수정</a>
        <a href="${pageContext.request.contextPath}/mypage/orderList.do" class="btn btn-default headerbtn">나의주문내역</a>
        <a href="${pageContext.request.contextPath}/mypage/noticeList.do" class="btn btn-default headerbtn">내가쓴글</a>
        <a href="${pageContext.request.contextPath}/mypage/getOrderList_store.do" class="btn btn-default headerbtn">가게주문확인</a>

        <a href="${pageContext.request.contextPath}/mypage/updateStore.do" class="btn btn-default headerbtn">가게정보 등록/변경</a>

        <a href="${pageContext.request.contextPath}/mypage/updateMenu.do" class="btn btn-default headerbtn">가게메뉴 등록/변경</a>
        <a href="${pageContext.request.contextPath}/mypage/storeSales.do" class="btn btn-default headerbtn">가게매출</a>

    </c:if>
</div>
