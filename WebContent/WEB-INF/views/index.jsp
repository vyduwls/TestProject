<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- Slider Start -->

<!-- <section id="slider" style="padding-top: 150px"> -->
<!--     <div class="container"> -->
<!--     <form action="search.do" method="post"> -->
<!--     <div class="col-lg-10" id="select"> -->
<!--         <select style="display: inline; width: 200px;" class="form-control" id="sel1" name="area" onchange="doChange(this, 'county')"> -->
<!--             <option value="" selected>시/도 선택</option> -->
<!--             <option value="서울">서울</option> -->
<!--             <option value="경기">경기</option> -->
<!--             <option value="인천">인천</option> -->
<!--             <option value="강원">강원</option> -->
<!--             <option value="부산">부산</option> -->
<!--             <option value="경남">경남</option> -->
<!--             <option value="대구">대구</option> -->
<!--             <option value="경북">경북</option> -->
<!--             <option value="울산">울산</option> -->
<!--             <option value="대전">대전</option> -->
<!--             <option value="충남">충남</option> -->
<!--             <option value="충북">충북</option> -->
<!--             <option value="광주">광주</option> -->
<!--             <option value="전남">전남</option> -->
<!--             <option value="전북">전북</option> -->
<!--             <option value="제주">제주</option> -->
<!--         </select>  -->
<!--         <select style="display: inline; width: 200px;" name="county" id="county" class="form-control"> -->
<!--             <option value="">시/구/군 선택</option> -->
<!--         </select> <input type="text" name="detailAddress" class="form-control" style=" display: inline; height: 40px; width: 150px; text-align: right; padding-right: 15px"> -->
<!--         <button  type="submit" class="btn btn-default" style="height: 40px; width: 60px; "><i class="glyphicon glyphicon-search"></i></button> -->
<!--     </div> -->
<!-- </form> -->
<!--         <div class="row"> -->
<!--             <div class="col-md-10 col-md-offset-2"> -->
<!--                 <div class="block"> -->
<!--                     <select name="storeName"> -->
<!--                         <option>choose store</option> -->
<%--                         <c:forEach var="sl" items="${storeList }"> --%>
<%--                             <option>${sl.storeName}</option> --%>
<%--                         </c:forEach> --%>
<!--                     </select> -->
<!--                     <h1 class="animated fadeInUp">chatting</h1> -->
<!--                     <div id="chat_div" class="animated fadeInUp"></div> -->
<!--                     <div> -->
<!--                         <input id="chat_input" class="animated fadeInUp" placeholder="login first"> -->
<!--                         <button id="chat_dutton" class="animated fadeInUp">전송</button> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->
<!--         </div> -->
<!--     </div> -->
<!-- </section> -->
<div class="container">
  <div id="myCarousel" class="carousel slide" data-ride="carousel" style="margin-top: 20px;">
    <!-- Indicators -->
    <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
      <li data-target="#myCarousel" data-slide-to="2"></li>
      <li data-target="#myCarousel" data-slide-to="3"></li>
      <li data-target="#myCarousel" data-slide-to="4"></li>
    </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner">
      <div class="item active">
        <img src="img/mac1.jpg" alt="Los Angeles" style="width:100%;height: 550px;">
      </div>
      <div class="item">
        <img src="img/mac2.jpg" alt="Chicago" style="width:100%;     height: 550px;">
      </div>
      <div class="item">
        <img src="img/mac3.jpg" alt="New york" style="width:100%;     height: 550px;">
      </div>
      <div class="item">
        <img src="img/star.jpg" alt="New york" style="width:100%;     height: 550px;">
      </div>
      <div class="item">
        <img src="img/mac3.jpg" alt="New york" style="width:100%;     height: 550px;">
      </div>
    </div>

    <!-- Left and right controls -->
    <a class="left carousel-control" href="#myCarousel" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
</div>
<form action="store/store.do" method="post">
    <select style="height: 40px; width: 200px;" name="area" onchange="doChange(this, 'county')">
        <option value="" selected>시/도 선택</option>
        <option value="서울">서울</option>
        <option value="경기">경기</option>
        <option value="인천">인천</option>
        <option value="강원">강원</option>
        <option value="부산">부산</option>
        <option value="경남">경남</option>
        <option value="대구">대구</option>
        <option value="경북">경북</option>
        <option value="울산">울산</option>
        <option value="대전">대전</option>
        <option value="충남">충남</option>
        <option value="충북">충북</option>
        <option value="광주">광주</option>
        <option value="전남">전남</option>
        <option value="전북">전북</option>
        <option value="제주">제주</option>
    </select> <select name="county" id="county" style="height: 40px; width: 200px;">
        <option value="">시/구/군 선택</option>
    </select> <input type="text" name="detailAddress" style="height: 40px; width: 150px; text-align: right; padding-right: 15px">
    <button type="submit" style="height: 40px; width: 60px">검색</button>
</form>
<div class="index_content">
	<div class="leftSide">
        <span>채팅</span>
    </div>
    <div class="chat">
        <select name="storeName">
            <option>choose store</option>
            <c:forEach var="sl" items="${storeList }">
                <option>${sl.storeName}</option>
            </c:forEach>
        </select>
        <h1 class="animated fadeInUp">Call Service</h1>
        <div id="chat_div" class="animated fadeInUp"></div>
        <div>
            <input id="chat_input" class="animated fadeInUp" placeholder="login first">
            <button id="chat_dutton" class="animated fadeInUp">전송</button>
        </div>
    </div>
    <div class="top3">
        <c:forEach var="sl" items="${storeList }">
            <c:set var="imagesArray" value='${fn:split(sl.images, "\\\\")}' />
            <c:if test="${sl.storeName==top3List[2] }">
                <div class="top_store">
                    <div class="top_store_img" style="height:200px">
                        <p style="color:#6a00f1; font-weight: bold;font-size: 20px;text-align: center;">TOP 3</p>
                        <img src="${pageContext.request.contextPath}/${imagesArray[fn:length(imagesArray)-2]}/${imagesArray[fn:length(imagesArray)-1]}" style="height:50%;width:100%">
                    </div>
                    <span class="top_store_storeName">${sl.storeName }</span>
                    <div class="top_sotre_title">
                        <c:choose>
                            <c:when test="${avgLikesMap[sl.storeName]=='1' }">
                                    ★☆☆☆☆
                                </c:when>
                            <c:when test="${avgLikesMap[sl.storeName]=='2' }">
                                    ★★☆☆☆
                                </c:when>
                            <c:when test="${avgLikesMap[sl.storeName]=='3' }">
                                    ★★★☆☆
                                </c:when>
                            <c:when test="${avgLikesMap[sl.storeName]=='4' }">
                                    ★★★★☆
                                </c:when>
                            <c:when test="${avgLikesMap[sl.storeName]=='5' }">
                                    ★★★★★
                                </c:when>
                            <c:otherwise>
                                    평점없음
                                </c:otherwise>
                        </c:choose>
                    </div>
                    <span class="top_store_address">${sl.address }</span>
                    <div>
                    <button onclick="location.href='${pageContext.request.contextPath}/order/menuList.do?storeName=${sl.storeName}'" class="btn btn-default indexMenuBtn" style="width:80%;height:50px; margin-top:20px">메뉴보기</button>
                    </div>
                </div>
            </c:if>
        </c:forEach>
        <c:forEach var="sl" items="${storeList }">
            <c:set var="imagesArray" value='${fn:split(sl.images, "\\\\")}' />
            <c:if test="${sl.storeName==top3List[1] }">
                <div class="top_store">
                    <div class="top_store_img" style="height:200px">
                        <p style="color:#6a00f1; font-weight: bold;font-size: 20px;text-align: center;">TOP 2</p>                    
                        <img src="${pageContext.request.contextPath}/${imagesArray[fn:length(imagesArray)-2]}/${imagesArray[fn:length(imagesArray)-1]}" style="height:50%;width:100%">
                    </div>
                    <span class="top_store_storeName">${sl.storeName }</span>
                    <div class="top_sotre_title">
                        <c:choose>
                            <c:when test="${avgLikesMap[sl.storeName]=='1' }">
                                    ★☆☆☆☆
                                </c:when>
                            <c:when test="${avgLikesMap[sl.storeName]=='2' }">
                                    ★★☆☆☆
                                </c:when>
                            <c:when test="${avgLikesMap[sl.storeName]=='3' }">
                                    ★★★☆☆
                                </c:when>
                            <c:when test="${avgLikesMap[sl.storeName]=='4' }">
                                    ★★★★☆
                                </c:when>
                            <c:when test="${avgLikesMap[sl.storeName]=='5' }">
                                    ★★★★★
                                </c:when>
                            <c:otherwise>
                                    평점없음
                                </c:otherwise>
                        </c:choose>
                    </div>
                    <span class="top_store_address">${sl.address }</span>
                    <div>
                    <button onclick="location.href='${pageContext.request.contextPath}/order/menuList.do?storeName=${sl.storeName }'" class="btn btn-default indexMenuBtn" style="width:80%;height:50px; margin-top:20px">메뉴보기</button>
                    </div>
                </div>
            </c:if>
        </c:forEach>
        <c:forEach var="sl" items="${storeList }">
            <c:set var="imagesArray" value='${fn:split(sl.images, "\\\\")}' />
            <c:if test="${sl.storeName==top3List[0] }">
                <div class="top_store">
                    <div class="top_store_img" style="height:200px">
                        <p style="color:red; font-weight: bold;font-size: 20px;text-align: center;">TOP 1</p>                    
                        <img src="${pageContext.request.contextPath}/${imagesArray[fn:length(imagesArray)-2]}/${imagesArray[fn:length(imagesArray)-1]}" style="height:50%;width:100%">
                    </div>
                    <span class="top_store_storeName">${sl.storeName }</span>
                    <div class="top_sotre_title">
                        <c:choose>
                            <c:when test="${avgLikesMap[sl.storeName]=='1' }">
                                    ★☆☆☆☆
                                </c:when>
                            <c:when test="${avgLikesMap[sl.storeName]=='2' }">
                                    ★★☆☆☆
                                </c:when>
                            <c:when test="${avgLikesMap[sl.storeName]=='3' }">
                                    ★★★☆☆
                                </c:when>
                            <c:when test="${avgLikesMap[sl.storeName]=='4' }">
                                    ★★★★☆
                                </c:when>
                            <c:when test="${avgLikesMap[sl.storeName]=='5' }">
                                    ★★★★★
                                </c:when>
                            <c:otherwise>
                                    평점없음
                                </c:otherwise>
                        </c:choose>
                    </div>
                    <span class="top_store_address">${sl.address }</span>
                    <div>
                    <button onclick="location.href='${pageContext.request.contextPath}/order/menuList.do?storeName=${sl.storeName }'" class="btn btn-default indexMenuBtn" style="width:80%;height:50px; margin-top:20px">메뉴보기</button>
                    </div>
                </div>
            </c:if>
        </c:forEach>

    </div>
</div>
<script type="text/javascript">
    var chatList = [];
    $("select[name=storeName]").change(function() {
        $(function() {

            setInterval("ajaxChat()", 5000);

        })

        ajaxChat();
    })
    $("#chat_dutton").click(function() {

        var thisChat = $("#chat_input").val();
        var thisName = $("select[name=storeName]").val();

        $.ajax({
            tpye : "POST",
            url : "chat.do",
            data : {
                "content" : thisChat,
                "storeName" : thisName
            },
            success : function() {

                var thisName = $("select[name=storeName]").val();
                ajaxChat(thisName);

            },
            error : function(request, status, error) {
                console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);

            }
        })

    })

    function ajaxChat() {
        var thisName = $("select[name=storeName]").val();
        console.log("ajaxchat실행");
        $.ajax({
            tpye : "POST",
            url : "getChat.do",
            dataType : "json",
            data : {
                "storeName" : thisName
            },
            success : function(data) {

                chatList = data;
                $("#chat_div").empty();
                for ( var cl in chatList) {
                    $("#chat_div").append("<span>" + chatList[cl].mid + " : " + chatList[cl].content + "</span><br>");

                }

            },
            error : function(request, status, error) {
                console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);

            }
        })
    }
    
    $(".leftSide").click(function(){
        $(".chat").css({
            "width" : "400px"
        })
    $(".chat").toggle("slow",function(){
        
    })
})
</script>