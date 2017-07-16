<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
    var idOk = 0;
    $(document).ready(function() {
        $('#btn').click(function() {
            $.ajax({
                url : "confirmcheck.do",
                type : "POST",
                data : {
                    "confirmNum" : $('#c_num').val()
                },
                dataType : 'text',
                error : function(jqXHR, textStatus, errorThrown) {
                    alert("c_num 에러발생 \n" + textStatus + " : " + errorThrown)
                },
                success : function(data) {
                    if ($.trim(data) == "1") {
                        idOk = 1;
                        alert("사용 가능한 사업자번호 입니다.");
                    } else {
                        idOk = 0;
                        alert("이미 존재하는 사업자번호 입니다.")
                    }
                }
            })
        });
    });
    function validate() {
    	
    	var area = $("#area option:selected").val();
    	
    	var area1 = $("#county option:selected").val();
    	
    	var address = $("#area option:selected").val()+ " " + $("#county option:selected").val() + " " + $("#detailAddress").val();
    	
    	$("#add").val(address);
    	
/*     	alert(area).val();
    	alert(area1).val();
    	alert($("#address").val()); */
    	
    }
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
    };
</script>


<section id="global-header">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="block">
                    <h1>회원가입</h1>
                    <p></p>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- contact form start -->
<section id="contact-form">
    <div class="container">
        <div class="row">
            <div class="block" style="margin: auto; width: 50%">
                <form action="storejoin.do" method="post" enctype="multipart/form-data" onsubmit="return validate()">
                    <div class="form-group">ID
                         <input style="width: 380px" type="text" name="writer"
                            id="c_num" class="form-control" value="${m.mid}">
                    </div>
                    <div class="form-group">사업자등록번호
                         <input style="width: 380px" type="text" name="storeNumber"
                            id="c_num" class="form-control" value="${cnum}">
                    </div>
                    <div class="form-group">사업장명
                         <input style="width: 380px" type="text" name="storeName"
                            id="c_num" class="form-control">
                    </div>
                    <div class="form-group">가게유형
                         <input style="width: 380px" type="text" name="storeType"
                            id="c_num" class="form-control" placeholder="ex)카페,햄버거,피자 등">
                    </div>
					<div class="form-group">
						주소
						<select class="mypage_content_address" id="area" name="area" onchange="doChange(this, 'county')">
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
				         </select>
				         <select class="mypage_content_address" name="county" id="county">
				             <option value="">시/구/군 선택</option>
				         </select>
						 <input type="text" id="detailAddress" name="detailAddress" style="height: 20px; width: 150px; text-align: right; padding-right: 15px">
						 <input type="hidden" name="address" id="add">
					</div> 
					<div class="form-group">전화번호
                         <input style="width: 380px" placeholder="(-)뺀 숫자만 입력하세요" maxlength="11" pattern="[0-9]{10}[0-9]?" type="text" name="phoneNumber"
                            id="c_num" class="form-control">
                    </div>
                    <div class="form-group">가게사진
                         <input style="width: 380px" type="file" name="imgFile"
                            id="images" class="form-control">
                            <div id="holder"></div>
                    </div>
                    <button class="btn btn-default" type="submit" style="width: 70%; margin-left: 20%;">회원가입</button>
                </form>
            </div>
            <div class="col-md-6 col-sm-12">
                <div class="block"></div>
            </div>
        </div>
        <div id="contact-box" class="row">
            <div class="col-md-6 col-sm-12">
                <div class="block" style="margin: auto; width: 100%;">
                    <ul class="address-block">
                    </ul>

                    <ul class="social-icons">
                        <li><a href="http://www.nts.go.kr/"> <img src="img/tex.jpg"> <i class="fa fa-google"></i></a></li>
                        <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
                        <li><a href="#"><i class="fa fa-pinterest"></i></a></li>
                        <li><a href="#"><i class="fa fa-dribbble"></i></a></li>
                        <li><a href="#"><i class="fa fa-behance"></i></a></li>
                        <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                        <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                    </ul>
                </div>
            </div>
            <div class="col-md-6 col-sm-12">
                <div class="block"></div>
            </div>
        </div>
    </div>
    </div>
</section>
<!-- Call to action Start -->
<section id="call-to-action">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="block">
                    <h2>We design delightful digital experiences.</h2>
                    <p>Read more about what we do and our philosophy of design. Judge for yourself The work and results we’ve achieved for other clients, and meet our highly experienced Team who
                        just love to design.</p>
                    <a class="btn btn-default btn-call-to-action" href="#">Tell Us Your Story</a>
                </div>
            </div>
        </div>
    </div>
</section>
