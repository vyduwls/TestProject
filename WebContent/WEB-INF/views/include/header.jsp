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
                                        <li><a href="${pageContext.request.contextPath}/member/logout.do" >로그아웃</a></li>
                                    </c:if>
                                </ul>
                            </div>


                            <!-- /.navbar-collapse -->
                        </div>
                        <!-- /.container-fluid -->
                    </nav>
                </div>
            </div>
        </div>
    </header>