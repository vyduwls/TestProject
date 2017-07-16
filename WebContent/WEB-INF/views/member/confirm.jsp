<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="${pageContext.request.contextPath}/js/jquery.validate1.js"></script>
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
                        alert("사업자번호 인증 되셨습니다.");
                    } else {
                        idOk = 0;
                        alert("이미 인증된 사업자번호 입니다.")
                    }
                }
            })
        });
    });
    function validate() {
        if (idOk == 0) {
            alert("사업자번호를  확인하세요!")
            return false;
        }
    }
	function onlyNumber(event){
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
			return;
		else
			return false;
	}
	function removeChar(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
			return;
		else
			event.target.value = event.target.value.replace(/[^0-9]/g, "");
	}
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
                <form action="confirm.do" onsubmit="return validate()" method="post" id="confirm">
                    <div class="form-group">사업자 등록번호 조회하기(숫자만 입력하세요!) 
                       <input style="float: right; margin-top: 25px" type="button" id="btn" class="button" value="조회하기"> 
                       <input style="width: 380px" type="number" onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" maxlength="10" name="confirmNum" id="c_num" class="form-control">
                    </div>
                    <button class="btn btn-default" type="submit" style="width: 70%; margin-left: 20%;">회원가입</button>
                </form>
            <script type="text/javascript">
               $("#confirm").validate1({ // joinForm에 validate를 적용
                  rules : {
                     confirmNum : {
                        required : true,
                        maxlength : 10,
                     },
                  }
               });
            </script>
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
                        <li><a href="http://www.nts.go.kr/"> <img src="../img/tex.jpg"> <i class="fa fa-google"></i></a></li>
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