<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
    <br><br>
    <div id="mypage_content">
        <h2 id="mypage_content_h2">가게정보수정</h2>
        <a href="${pageContext.request.contextPath}/mypage/regStore.do" class="btn2 btn btn-default headerbtn">가게정보등록</a>
        <table style="margin-left: 5%;">
            <thead>
                <tr>
                    <th></th>
                    <th>매장명</th>
                    <th>유형</th>
                    <th>위치</th>
                </tr>
            </thead>

            <tbody style="font-family: delivery">
                <c:forEach varStatus="status" var="s" items="${storeList }">
                <c:set var="imagesArray" value='${fn:split(s.images, "\\\\")}' />
                    <tr class="search_content_store">
                        <td class="search_content_images"><img src="${pageContext.request.contextPath}/${imagesArray[fn:length(imagesArray)-2]}/${imagesArray[fn:length(imagesArray)-1]}" style="width: 50px; height: 50px"></td>
                        <td class="search_content_storeName">${s.storeName }</td>
                        <td class = "search_content_storeType">${s.storeType }</td>
                        <td class = "search_content_storeAddress">${s.address }</td>
                        <td class = "search_content_seq"><input type="hidden" value="${s.seq }"></td>
                        <td class = "search_content_storeNumber"><input type="hidden" value="${s.storeNumber }"></td>
                        <td class = "search_content_storePhoneNumber"><input type="hidden" value="${s.phoneNumber }"></td>
                    </tr>
                    
                    
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <div class="update_content">
        <h2 id="update_content_h2">가게정보수정</h2>
        
        <form id = "updateStoreForm" action="editStore.do" method = "post" enctype="multipart/form-data">
        
            <span>사업자등록번호:</span><input class="update_content_storeNumber mypage_content_input" name = "storeNumber" placeholder="storeNumber"><br>
            <span>가게명:</span><input class="update_content_storeName mypage_content_input" name = "storeName" placeholder="storeName"><br>
            <span>가게유형:</span><input class="update_content_storeType mypage_content_input" name = "storeType" placeholder="storeType"><br>
            <span>주소:</span><select class="update_content_address" name="area" onchange="doChange(this, 'county')">
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
        </select> <select class="update_content_address" name="county" id="county">
            <option id="option" value="">시/구/군 선택</option>
        </select> <input class="update_content_address" name="detailAddress" placeholder="detailAddress"><br>
            <span>전화번호:</span><input class="update_content_storePhoneNumber mypage_content_input" name = "phoneNumber" placeholder="phoneNumber"><br>
            <span>가게사진:</span><input class="mypage_content_input" type="file" id="images" name = "imgFile"><br>
            <input type="hidden" class="update_content_seq" name = "seq" placeholder="seq"><br>
            <div id="holder"></div>
            <button type="submit" class="search_modal_box_menubutton">수정</button>
        </form>
    </div>
    
    <script src="${pageContext.request.contextPath}/js/jquery.validate.js"></script>
    <script type="text/javascript">
        
        //click
        $(".search_content_store").click(function() {
            
            var thisName = $(this).children(".search_content_storeName").text();
            var thisImages= $(this).children(".search_content_images").children("img").attr("src");
            var thisAddress = $(this).children(".search_content_storeAddress").text();
            var thisType = $(this).children(".search_content_storeType").text();
            var thisPhoneNumber = $(this).children(".search_content_storePhoneNumber").children("input").val();
            var thisStoreNumber = $(this).children(".search_content_storeNumber").children("input").val();
            var thisSeq = $(this).children(".search_content_seq").children("input").val();
            var list=thisAddress.split(" ");
            var area=list[0];
            var county=list[1];
            var detailAddress=list[2];
            
            console.log(thisImages);
            
            $("#mypage_content").css({
                "display" : "none"
            })
            
            $(".update_content").css({
                "display" : "block"
            })
            
            
            $("#holder").html("<img src='"+thisImages+"'>");
            $(".update_content_storeName").val(thisName);
            $(".update_content_storeNumber").val(thisStoreNumber);
            $("select[name=area]").val(area);
            $("#county option:selected").text(county);
            $("#county option:selected").val(county);
            $("input[name=detailAddress]").val(detailAddress);
            $(".update_content_storeType").val(thisType);
            $(".update_content_storePhoneNumber").val(thisPhoneNumber);
            $(".update_content_seq").val(thisSeq);
            
        })
        
        var upload= document.getElementById("images");
        var holder = document.getElementById("holder");
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
            
        }
        
        $("#updateStoreForm").validate({
            rules : {
                storeNumber : {
                    required : true,
                    digits : true,
                    maxlength : 10,
                    minlength : 10
                },
                storeName : {
                    required : true
                },
                storeType : {
                    required : true
                },
                area : {
                    required : true
                },
                county : {
                    required : true
                },
                detailAddress : {
                    required : true
                },
                phoneNumber : {
                    required : true,
                    digits : true
                },

            },
            highlight: function(element, errorClass) {
                $(element).css({
                    "border" : "1px solid red",
                })
             }
        });
        
    </script>

</body>
</html>
