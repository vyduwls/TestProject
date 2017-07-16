<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<section id="global-header">
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <h1>Search Result</h1>
            </div>
        </div>
    </div>
</div>
</section>

<form action="store.do" method="post">
    <div class="col-lg-10" id="select">
        <select style="height: 40px; width: 200px;" id="area" name="area" onchange="doChange(this, 'county')">
        <c:if test="${empty area }">
            <option value="시/도 선택">시/도 선택</option>
        </c:if>
        <c:if test="${!empty area }">
            <option value="${area }" selected>${area }</option>
        </c:if>
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
            <c:if test="${empty county }">
            <option value="시/구/군 선택">시/구/군 선택</option>
            </c:if>
            <c:if test="${!empty county }">
            <option value="${county }" selected>${county }</option>
            </c:if>
        </select> 
            <c:if test="${empty detailAddress }">
            <input type="text" id = "detailAddress" name="detailAddress" style="height: 40px; width: 150px; text-align: right; padding-right: 15px">
            </c:if>
            <c:if test="${!empty detailAddress }">
            <input type="text" id = "detailAddress" name="detailAddress" style="height: 40px; width: 150px; text-align: right; padding-right: 15px" value="${detailAddress }">
            </c:if>
        <button type="submit" style="height: 40px; width: 60px">검색</button>
    </div>
</form>
<div class="col-lg-10">
    <label>가게유형 : </label> <select id="search_store_type">
            <c:if test="${empty storeType }">
                <option value = "select Type">select Type</option>
            </c:if>
            <c:if test="${!empty storeType }">
            <option value="${storeType }" selected>${storeType }</option>
            </c:if>
        <c:forEach varStatus="" var="s" items="${storeTypeList }">
            <c:if test="${!empty s }">
                <option>${ s}</option>
            </c:if>
        </c:forEach>
    </select>
</div>


<!-- Table -->
<div class="table-wrapper" style="width: 80%; margin: auto">
    <h4>Result</h4>
    <table>
        <thead>
            <tr>
                <th></th>
                <th>매장명</th>
                <th>유형</th>
                <th>위치</th>
                <th>평점</th>
            </tr>
        </thead>
        <tbody style="font-family: delivery">
            <c:forEach varStatus="status" var="s" items="${storeList }">
                <tr class="search_content_store">
                    <c:set var="imagesArray" value='${fn:split(s.images, "\\\\")}' />
                    <td class="search_content_images"><img src="${pageContext.request.contextPath}/${imagesArray[fn:length(imagesArray)-2]}/${imagesArray[fn:length(imagesArray)-1]}"
                        style="width: 50px; height: 50px"></td>
                    <td class="search_content_storeName">${s.storeName }</td>
                    <td>${s.storeType }</td>
                    <td class="search_content_storeAddress">${s.address }</td>
                    <td class="search_content_storeAverageLikes"><c:choose>
                            <c:when test="${avgLikesMap[s.storeName]=='1' }">
                                    ★☆☆☆☆
                                </c:when>
                            <c:when test="${avgLikesMap[s.storeName]=='2' }">
                                    ★★☆☆☆
                                </c:when>
                            <c:when test="${avgLikesMap[s.storeName]=='3' }">
                                    ★★★☆☆
                                </c:when>
                            <c:when test="${avgLikesMap[s.storeName]=='4' }">
                                    ★★★★☆
                                </c:when>
                            <c:when test="${avgLikesMap[s.storeName]=='5' }">
                                    ★★★★★
                                </c:when>
                            <c:otherwise>
                                    평점없음
                                </c:otherwise>
                        </c:choose></td>
                    <td class="search_content_storePhoneNumber"><input type="hidden" value="${s.phoneNumber }"></td>
                </tr>

            </c:forEach>
        </tbody>
    </table>
</div>

<!-- modal -->
<div id="search_modal" class="search_modal">
    <span id="search_modal_close">&times;</span>
    <div id="search_modal_box">
        <div id="search_modal_box_map"></div>
        <div id="search_modal_box_left">
            <img id="search_modal_box_left_img">
            <h1 id="search_modal_box_left_storeName">가게명</h1>
            <p id="search_modal_box_left_storeAddress">가게주소</p>
            <p id="search_modal_box_left_storePhoneNumber">전화번호</p>
            <button id="search_modal_box_menubutton">메뉴보기</button>
        </div>
        <div class="search_modal_box_comment"></div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/vendor/jquery-1.10.2.min.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDtkbslGoOEJJi8psc4fwMji6UKNe2BNjc"></script>
<script type="text/javascript">
    var commentList = [];
    var index = 0;

    //googlemap
    function initMap(lat, lng) {
        var div = document.getElementById("search_modal_box_map");
        var myCenter = new google.maps.LatLng(lat, lng);
        var mapOption = {
            center : myCenter,
            zoom : 15
        };
        var map = new google.maps.Map(div, mapOption);

        var markerOption = {
            position : myCenter,
            map : map
        };

        var marker = new google.maps.Marker(markerOption);

        google.maps.event.addListener(marker, 'click', function() {
            var infoWin = new google.maps.InfoWindow({
                content : '<div><a target="_blank" href="http://www.sogang.ac.kr/">서강대학교</a>/div>'
            });
            infoWin.open(map, marker);
        });

    }

    //modal

    $(document).on("click",".search_content_store",function() {

        $("body").css("overflow", "hidden");

        var thisName = $(this).children(".search_content_storeName").text();
        var thisImages = $(this).children(".search_content_images").children().attr("src");
        var thisAddress = $(this).children(".search_content_storeAddress").text();
        var thisPhoneNumber = $(this).children(".search_content_storePhoneNumber").children("input").val();

        $.ajax({
            type : "POST",
            url : "comment.do",
            dataType : "json",
            data : {
                "storeName" : thisName
            },
            success : function(data) {
                console.log("data" + data);
                commentList = data;
                if (data != "") {
                    $(".search_modal_box_comment").empty();
                    var img="";
                    for (var i = 0; i < commentList.length; i++) {
                        if(typeof commentList[i].images != "undefined"){
                            img="${pageContext.request.contextPath}/"+commentList[i].images.split("\\")[commentList[i].images.split("\\").length-2]+"\\"+commentList[i].images.split("\\")[commentList[i].images.split("\\").length-1];
                        }
                        $(".search_modal_box_comment").append("<img src='"+img+"' class='search_modal_box_comment_img'></img>");
                        $(".search_modal_box_comment").append("<div class='search_modal_box_comment_cmid'><span>" + commentList[i].cmid + "</span></div>");
                        $(".search_modal_box_comment").append("<div class='search_modal_box_comment_regDate'><span>" + commentList[i].regDate.split(" ")[0] + "</span></div>");
                        if (commentList[i].likes == "1") {
                            like = "★☆☆☆☆";
                        } else if (commentList[i].likes == "2") {
                            like = "★★☆☆☆";
                        } else if (commentList[i].likes == "3") {
                            like = "★★★☆☆";
                        } else if (commentList[i].likes == "4") {
                            like = "★★★★☆";
                        } else if (commentList[i].likes == "5") {
                            like = "★★★★★";
                        }

                        $(".search_modal_box_comment").append("<div class='search_modal_box_comment_likes'><span>" + like + "</span></div>");
                        $(".search_modal_box_comment").append("<div class='search_modal_box_comment_content'><span>" + commentList[i].content + "</span></div>");
                    }
                } else {
                    $(".search_modal_box_comment").empty();

                }

                $("#search_modal").css({
                    "display" : "block"
                })
                $("#search_modal_box_left_img").attr("src",thisImages);
                $("#search_modal_box_left_storeName").text(thisName);
                $("#search_modal_box_left_storeAddress").text(thisAddress);
                $("#search_modal_box_left_storePhoneNumber").text(thisPhoneNumber);

                googleapisView();
            },
            error : function(request, status, error) {
                console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);

            }
        })

        //google geocoding
        function googleapisView() {

            var address = encodeURI(thisAddress);
            var geocode = "http://maps.googleapis.com/maps/api/geocode/json?address=" + address + "&sensor=false";
            $.ajax({
                url : geocode,
                type : 'POST',
                success : function(myJSONResult) {
                    console.log(myJSONResult);
                    var lat = myJSONResult.results[0].geometry.location.lat;
                    var lng = myJSONResult.results[0].geometry.location.lng;
                    initMap(lat, lng);
                }
            });
        }

    })

    //modal close
    $("#search_modal_close").click(function() {
        $("#search_modal").css({
            "display" : "none",
        })
        $("body").css("overflow", "");
    })
    $("#search_modal").click(function(event) {
        if (event.target.className == "search_modal") {
            $("#search_modal").css({
                "display" : "none",
            })
        }
        $("body").css("overflow", "");
    })

    //modal button
    $(document).on("click", "#search_modal_box_menubutton", function() {
        var storeName = $("#search_modal_box_menubutton").siblings("#search_modal_box_left_storeName").text();
        location.href = "${pageContext.request.contextPath}/order/menuList.do?storeName=" + storeName;
    })

    //select change
    $("#search_store_type").change(function() {
        var storeType = $("#search_store_type").val();
        var area = $("#area option:selected").val();
        var county = $("#county option:selected").val();
        location.href = "store.do?storeType=" + storeType+"&area="+area+"&county="+county;

    })
    
    //infinite Scroll
    var page = 0;
    var storeList;
    var amList=new Array();
    var amListJson=new Array();
    <c:forEach items="${avgLikesMap}" var="am">
    amList.push("${am}");
    </c:forEach>
    for(var i in amList){
        var data = new Object() ;
        data.storeName=amList[i].split('=')[0];
        data.likes=amList[i].split('=')[1];
        amListJson.push(data);
    }
    console.log(amListJson);
$(window).scroll(function() {
    if ($(window).scrollTop() == $(document).height() - $(window).height()) {
        page++;
        var storeType=null;
        var area=null;
        var county=null;
        var detailAddress=null;
        if($("#search_store_type option:selected").val()!="select Type"){
            storeType=$("#search_store_type option:selected").val();
        }
        if($("#area option:selected").val()!="시/도 선택"){
            area=$("#area option:selected").val();
        }
        if($("#county option:selected").val()!="시/구/군 선택"){
            county=$("#county option:selected").val();
        }
        if($("#detailAddress").val()!=""){
            detailAddress=$("#detailAddress").val();
        }
        console.log("storeType : "+$("#search_store_type option:selected").val());
        console.log("area : "+$("#area option:selected").val());
        console.log("county : "+$("#county option:selected").val());
        console.log("detailAddress : "+$("#detailAddress").val());
        
        console.log("storeType : "+storeType);
        console.log("area : "+area);
        console.log("county : "+county);
        console.log("detailAddress : "+detailAddress);
        
        $.ajax({
            url : "storeScroll.do",
            data : {
                "page" : page,
                "storeType" : storeType,
                "area" : area,
                "county" : county,
                "detailAddress" : detailAddress
                
            },
            dataType : "json",
            type : "POST",
            success : function(data){
                
                storeList=data;
                console.log(storeList);
                for(var i=0 ;i<10;i++){
                    console.log(i);
                    var likes;
                    for(var am in amListJson){
                        if(am.storeName==storeList[i].storeName){
                            likes=am.likes;
                            if(likes=="1"){
                                like = "★☆☆☆☆";
                            }else if(likes=="2"){
                                like = "★★☆☆☆";
                            }else if(likes=="3"){
                                like = "★★★☆☆";
                            }else if(likes=="4"){
                                like = "★★★★☆";
                            }else if(likes=="5"){
                                like = "★★★★★";
                            }
                            break;
                        }
                        if(typeof likes=="undefined"){
                            likes="평점없음";
                        }
                    }
                    if(typeof storeList[i].storeType=="undefined"){
                        storeList[i].storeType="";
                    }
                    
                    var img="${pageContext.request.contextPath}/"+storeList[i].images.split("\\")[storeList[i].images.split("\\").length-2]+"\\"+storeList[i].images.split("\\")[storeList[i].images.split("\\").length-1];
                    $(".table-wrapper tbody").append(
                    '<tr class="search_content_store">'+
                    '<td class="search_content_images"><img src="'+img+'" style="width: 50px; height: 50px"></td>'+
                    '<td class="search_content_storeName">'+storeList[i].storeName+'</td>'+
                    '<td>'+storeList[i].storeType+'</td>'+
                    '<td class="search_content_storeAddress">'+storeList[i].address+'</td>'+
                    '<td class="search_content_storeAverageLikes">'+likes+'</td>'+
                    '<td class="search_content_storePhoneNumber"><input type="hidden" value="'+storeList[i].phoneNumber+'"></td>'+
                '</tr>');
                    
                }
            },
            error : function(request, status, error) {
                console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);

            }
            
            
        })
      
    }
});
</script>