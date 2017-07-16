<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
    function validate() {

        if ($("#pwd").val() == "" || $("#pwd2").val() == "" || $("#pwd").val() != $("#pwd2").val()) {
            alert("비밀번호를 다시 확인해주세요.");
            return false;
        }

        var birthday = $("#year").val() + "-" + $("#month").val() + "-" + $("#day").val();
        $("#birth-day").val(birthday);

    }
    $(document).ready(function() {
        var birthday = "${m.birth}";
        var birthdayArray = birthday.split("-");

        $("#year").val(birthdayArray[0]);
        $("#month").val(birthdayArray[1]);
        $("#day").val(birthdayArray[2]);

        if ($.trim(Edit) == "1") {
            Edit = 1;
            alert("정보수정완료")
        } else {
            Edit = 0;
            alert("정보수정실패")
            return false;
        }
    });
</script>


<!-- contact form start -->
<section id="contact-form" >
    <div class="container" style="font-family: hyundai">
        <div class="row">
            <div class="block" style="margin: auto; width: 50%; ">
                <form action="infoEdit.do" method="post" onsubmit="return validate()">
                    <div class="form-group">
                        ID <input type="text" name="mid" required pattern="[a-zA-Z][a-zA-Z0-9]{3,11}" class="form-control" value="${mid}">
                    </div>
                    <div class="form-group">
                        패스워드 <input type="password" name="pwd" id="pwd" maxlength="20" class="form-control" value="${m.pwd}">
                    </div>
                    <div class="form-group">
                        패스워드확인 <input type="password" name="pwd2" id="pwd2" maxlength="20" class="form-control" value="${m.pwd}">
                    </div>
                    <div class="form-group">
                        이름 <input type="text" name="name" class="form-control" value="${m.name}">
                    </div>
                    <div class="form-group">
                        email <input type="text" name="email" class="form-control" required="required" value="${m.email}">
                    </div>
                    <div class="form-group">
                        생년월일 <input type="text" name="year" id="year" pattern="[0-2][9][0-9][0-9]" class="form-control" value="${m.birth}">
                    </div>
                    <div class="form-group">
                        <input type="text" name="month" id="month" pattern="[0-1][0-9]" class="form-control" placeholder="month">
                    </div>
                    <div class="form-group">
                        <input type="text" name="day" id="day" pattern="[0-3][0-9]" class="form-control" placeholder="day"> <input type="hidden" name="birth" id="birth-day" />
                    </div>
                    <div class="form-group">
                        전화번호 <input type="text" name="phone" pattern="[0-9]{10}[0-9]?" class="form-control" value="${m.phone}">
                    </div>
                    <button class="btn btn-default" type="submit" style="width: 70%; margin-left: 20%;">회원정보수정</button>
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
