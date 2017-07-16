<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script type="text/javascript">
    $(document).ready(function() {
        var category;
        var sseq;
        $(".overly").click(function() {
            var seq = $("input", this).val();
            $.ajax({
                url : "menuModal.do",
                type : "GET",
                data : {
                    "mseq" : seq
                },
                dataType : "json",
                success : function(data) {
                    $.each(data, function(key, value) {
                        
                        if(key=="sseq"){
                            sseq=value;
                        }
                        if (key == "menuname") {
                            $("#menuname").text(value);
                        } else if (key == "mseq") {
                            $("#mseq").val(value);
                        } else if (key == "engmenuname") {
                            $("#engmenuname").text(value);
                        } else if (key == "price") {
                            $("#menuprice").text(value);
                        } else if (key == "category") {
                            category = value;
                        } else if (key == "img") {
                            $("#work_img").attr({
                                "src" : "${pageContext.request.contextPath}/"+ value.split('\\')[value.split('\\').length-2]+"/"+value.split('\\')[value.split('\\').length-1],
                                "title" : menuname
                            });
                        }
                    });
                    $(".work_modal").css("display", "block");
                }
            });
        });
    });

    function mysubmit(sub) {
        
        if( $("#requirements").val()==""){
            $("#requirements").val("-");
        }
        
        if (sub == 1) {
            if("${mid}"==null || "${mid}"==""){
                alert("로그인 후 주문 가능합니다.");
                location.href ="../member/login.do?storeName=${storeName}";
            }else{
                
                $.ajax({
                    url : "checkshoppingbasket.do",
                    type : "POST",
                    data : {
                        "mseq" : $("#mseq").val(),
                        "hour" : $("#hour").val(),
                        "minute" : $("#minute").val()
                    },
                    dataType : "text",
                    success : function(data) {
                        if ($.trim(data)!="0") {
                            if(confirm("동일한 상품이 이미 장바구니에 들어있습니다. 추가 하시겠습니까?")){
                                ajaxFunc($.trim(data));
                            }
                        }else{
                                ajaxFunc("1");
                        }
                    }
                });
                
              
          }
        } else if (sub == 3) {
            $("#amount").val("1");
            $("#hour").val("${time}");
            $("#minute").val("0");
            $("#requirements").val("")
            $(".work_modal").css("display", "none");
        }
    }
    function checkmid(){
        
        if( $("#requirements").val()==""){
            $("#requirements").val("-");
        }
        
        if("${mid}"==null || "${mid}"==""){
            alert("로그인 후 주문 가능합니다.");
            document.myform.action="../member/login.do?storeName=${storeName}";
        }else{
            document.myform.action = "directorder.do";
        }
    }
    function ajaxFunc(data){
          $.ajax({
                url : "shoppingbasketProc.do",
                type : "POST",
                data : {
                    "mseq" : $("#mseq").val(),
                    "amount" : $("#amount").val(),
                    "hour" : $("#hour").val(),
                    "minute" : $("#minute").val(),
                    "phoneNumber" : $("#phoneNumber").val(),
                    "requirements" : $("#requirements").val(),
                    "num" : data
                },
                dataType : "text",
                success : function(data) {
                    if ($.trim(data) == "1") {
                        alert("장바구니에 담겼습니다.");
                    } else {
                        alert("장바구니 담기에 실패하였습니다.");
                    }
                }
            });
    }
</script>

<div id="work_modal" class="work_modal">
    <div id="work_modal-content">
        <form name="myform" action="" method="get" onsubmit="return checkmid()">
            <div id="work_modalcontent_up">
                <img id="work_img" src="" alt="">
                <table id="work_table">

                    <tr id="up_tr">
                        <th id="up_th">메뉴명</th>
                        <td id="up_td"><span id="menuname"></span><br> <input type="hidden" name="mseq" id="mseq" value=""> <span id="engmenuname"></span></td>
                    </tr>
                    <tr id="up_tr">
                        <th id="up_th">가격</th>
                        <td id="up_td"><span id="menuprice"></span></td>
                    </tr>
                    <tr id="up_tr">
                        <th id="up_th">수량</th>
                        <td id="up_td"><select id="amount" name="amount" style="width: 40%; text-align-last: center;">
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                        </select></td>
                    </tr>
                    <tr id="up_tr">
                        <th id="up_th">도착예정시간</th>
                        <td id="up_td">
                            <select name="hour" id="hour" style="text-align-last: center;">
                                <c:forEach begin="${time}" end="23" var="n">
                                    <option value="${n}">${n}</option>
                                </c:forEach>
                            </select> 
                                <span>시</span> 
                            <select name="minute" id="minute" style="text-align-last: center;">
                                <option value="0" selected="selected">0</option>
                                <c:forEach begin="1" end="11" var="n" >
                                    <option value="${n*5}">${n*5}</option>
                                </c:forEach>
                             </select> 
                             <span>분</span>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="modal_middle">
                <table id="middle_table">
                    <tr>
                        <th id="middle_th">수령인 이름</th>
                        <th id="middle_th">전화번호</th>
                        <th id="middle_th">기타 요청사항</th>
                    </tr>
                    <tr>
                        <td id="middle_td"><input type="text" id="mid" value="${mid}" name="recipient" style="width: 80%; text-align: center;" readonly="readonly"></td>
                        <td id="middle_td"><input type="text" id="phoneNumber" value="${m.phone}" name="phoneNumber" style="width: 90%; text-align: center;"></td>
                        <td id="middle_td"><textarea cols="50" id="requirements" rows="4" name="requirements"></textarea></td>
                    </tr>
                </table>
            </div>
            <div id="modal_down">
                <input type="button" onclick="mysubmit(1)" id="okay_btn" value="장바구니에 넣기"> 
                <input type="submit" id="okay_btn" value="바로 결제하기"> 
                <input type="button" onclick="mysubmit(3)" id="okay_btn" value="이전으로">

            </div>
        </form>
    </div>
</div>

<!-- Slider Start -->
<section id="global-header">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="block">
                    <h1>${storeName} Menus</h1>
                    <p style="font-size: 20px;">What do you want to eat?</p>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Portfolio Start -->
<section id="portfolio-work">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="block">
                    <div class="portfolio-menu">
                        <ul>
                            <li class="filter" data-filter="all">Everything</li>
                            <c:forEach var="m" items="${categorys}">
                                <li class="filter" data-filter=".${m}" value="${m}" id="filterclick">${m}</li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="portfolio-contant">
                        <ul id="portfolio-contant-active">
                            <c:forEach var="n" items="${menus}">
                            <c:set var="imagesArray" value='${fn:split(n.img, "\\\\")}' />
                                <li class="mix ${n.category}"><img src="${pageContext.request.contextPath}/${imagesArray[fn:length(imagesArray)-2]}/${imagesArray[fn:length(imagesArray)-1]}" alt="" id="form_modalaction">
                                    <div class="overly" style="cursor: pointer;">
                                        <div class="position-center">
                                            <%--  <h2 style="color:white;font-weight: bold;">${n.menuname}</h2> --%>
                                            <h4 style="color: white; font-weight: bold; padding-right: 30px;">${n.engmenuname}</h4>
                                            <p style="color: white; font-weight: bold; padding-right: 30px; text-align: left;">${n.menuinfo}</p>
                                            <input type="hidden" value="${n.mseq}" id="inputhidden" />
                                        </div>
                                    </div>
                                    <h4 style="color: black; font-weight: bold; text-align: center;">${n.menuname}</h4></li>
                            </c:forEach>
                            <!--  -->

                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
