<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>



<br>
<br>
<div id="mypage_content">
    <h2 id="mypage_content_h2">가게정보등록</h2>
    <form action="regStoreProc.do" id="regStoreForm" method="post" enctype="multipart/form-data">

        <span>사업자등록번호:</span><input class="mypage_content_input" name="storeNumber" placeholder="storeNumber"><br> <span>가게명:</span><input class="mypage_content_input"
            name="storeName" placeholder="storeName"><br> <span>가게유형:</span><input class="mypage_content_input" name="storeType" placeholder="storeType"><br> <span>주소:</span>
        <select class="mypage_content_address" name="area" onchange="doChange(this, 'county')">
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
        </select> <select class="mypage_content_address" name="county" id="county">
            <option value="">시/구/군 선택</option>
        </select> <input class="mypage_content_address" name="detailAddress" placeholder="detailAddress"><br> <span>전화번호:</span><input class="mypage_content_input" name="phoneNumber"
            placeholder="phoneNumber"><br> <span>가게사진:</span><input class="mypage_content_input" type="file" id="images" name="imgFile"><br>
        <div id="holder"></div>
        <button type="submit" class="search_modal_box_menubutton">등록</button>
    </form>
</div>

<script src="${pageContext.request.contextPath}/js/jquery.validate.js"></script>
<script type="text/javascript">
    var upload = document.getElementById("images");
    var holder = document.getElementById("holder");
    upload.onchange = function(e) {
        e.preventDefault();

        var file = upload.files[0];
        var reader = new FileReader();
        reader.onload = function(event) {
            var img = new Image();
            img.src = event.target.result;
            if (img.width > 500) {
                img.width = 500;
            }
            holder.innerHTML = "";
            holder.appendChild(img);
            console.log(img);
        };
        reader.readAsDataURL(file);
        console.log(file);

        return false;
    };
    $("#regStoreForm").validate({
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
            imgFile : {
                required : true
            }

        },
        highlight: function(element, errorClass) {
            
            $(element).css({
                "border" : "1px solid red"
            })
         }
    });
</script>
