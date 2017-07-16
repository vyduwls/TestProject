<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
	#email2,#email{
		display:inline
	
	}
</style>
<script type="text/javascript">


    var idOk = 0;
function validate() {
	alert("점포 등록 페이지로 넘어갑니다");
	
	
     if (idOk == 0) {
        alert("아이디를 확인하세요!")
        return false;
    } 

    if ($("#pwd").val() == "" || $("#pwd2").val() == "" || $("#pwd").val() != $("#pwd2").val()) {
        alert("비밀번호를 다시 확인해주세요.");
        return false;
    }

    var birthday = $("#year").val() + "-" + $("#month").val() + "-" + $("#day").val();
    $("#birth-day").val(birthday);
    
	
    var target = $("#sel option:selected").val();
    var sel = $("select[name=sel]").val();


    var email = $("#email").val() + target;
    
    email.replace("," , "");
    
    $("#e-mail").val(email);
    
    

    
    
}
    $(document).ready(function() {
        $('#btnCheckUid').click(function() {
            $.ajax({
                url : "idcheck.do",
                type : "POST",
                data : {
                    "mid" : $('#mid').val()
                },
                dataType : 'text',
                error : function(jqXHR, textStatus, errorThrown) {
                    alert("에러발생~~~~ \n" + textStatus + " : " + errorThrown)
                },
                success : function(data) {
                    if ($.trim(data) == "1") {
                        idOk = 1;
                        alert("사용 가능한 아이디 입니다.");
                    } else {
                        idOk = 0;
                        alert("이미 존재하는 아이디입니다.")
                    }
                }
            })
        });
        
        
        
        $(".btn-default").click(function() {
        	
		})
        
    });
    
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
                <form id="join" action="join2.do?cnum=${cnum}" method="post" onsubmit="return validate()">
                    <div class="form-group">
                        ID <input type="text" name="mid" id="mid" required pattern="[a-zA-Z][a-zA-Z0-9]{3,11}" class="form-control" placeholder="4~12자리 영문자(단 영어로 시작)"> <input id="btnCheckUid" class="button" type="button" value="중복확인" />
                    </div>
                    <div class="form-group">
                        패스워드 <input type="password" name="pwd" id="pwd" class="form-control" maxlength="20" placeholder="pwd" required="required">
                    </div>
                    <div class="form-group">
                        패스워드확인 <input type="password" name="pwd2" id="pwd2" class="form-control" maxlength="20" placeholder="pwd" required="required">
                    </div>
                    <div class="form-group">
                        이름 <input type="text" name="name" class="form-control" placeholder="name" required="required"><br>이메일
                    </div>
					<div class="form-group" id="email2" style="width: 200px;">
							 <input type="text" id="email" name="email1"class="form-control" placeholder="email" style="width: 250px;">@
							 <select id="sel" name = "sel" style="height: 40px; width: 200px;">
							 <option selected>이메일선택</option>
			                    <option value="@naver.com">네이버</option>
			                    <option value="@google.com">구글</option>
			                    <option value="@nate.com">네이트</option>
			                 </select>   
			                 
			                  <input type="hidden" name="email" id="e-mail"/>
<!-- 								  <input type="text" style="width: 200px;" id="email" name="email"class="form-control" placeholder="xxxxx.com"> -->
					</div>
					<div class="form-group" >
                        생년월일 <input type="text" name="year" id="year" class="form-control" pattern="[0-2][9][0-9][0-9]" placeholder="출생년도 ex( 1999 )" required="required">
                    </div>
                    <div class="form-group">
                        <input type="text" name="month" id="month" class="form-control" pattern="[0-1][0-9]" placeholder="월  ( 01 )" required="required">
                    </div>
                    <div class="form-group">
                        <input type="text" name="day" id="day" class="form-control" placeholder="일 ( 01 )" pattern="[0-3][0-9]" required="required"> <input type="hidden" name="birth" id="birth-day" />
                    </div>
                    <div class="form-group">
                        전화번호 <input type="text" name="phone" maxlength="11" pattern="[0-9]{9}[0-9]?" class="form-control" required="required" placeholder="'-'를 뺀 휴대전화 번호 10~11자리를 입력해주세요.">
                   <input type="hidden" name="owners" class="form-control" value="사업자">
                    
                    </div>
                    <button class="btn btn-default" type="submit"  style="width: 70%; margin-left: 20%;">회원가입</button>
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
                        <li><a href="#"><i class="fa fa-google"></i></a></li>
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
