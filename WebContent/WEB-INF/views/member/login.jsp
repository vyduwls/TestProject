<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
    $(document).ready(function() {
        var ck = "${check}";
        //     	alert(ck);
        if ("${check}" == "1") {
            alert("���̵�,��й�ȣȮ���ϼ���")
        } else if ("${check}" == "0") {
            alert("���̵�,��й�ȣȮ���ϼ���")
        } else {

        }

    })
</script>
<section id="global-header">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="block">
                    <h1>Login</h1>
                    <p>���õ� ����� �ڿ�, �α����� �϶�!</p>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- contact form start -->
<section id="contact-form">
    <div class="container">
        <div class="row">
            <div class="col-md-6 col-sm-12">
                <div class="block">
                    <form>
                        <div class="form-group">
                            <img src="../img/mac.jpg">
                        </div>
                        <!--                     <div class="form-group"> -->
                        <!--                       <input type="text" class="form-control" placeholder="Email Address"> -->
                        <!--                     </div> -->
                        <!--                     <div class="form-group"> -->
                        <!--                       <input type="text" class="form-control" placeholder="Subject"> -->
                        <!--                     </div> -->
                    </form>
                </div>
            </div>
            <div class="col-md-6 col-sm-12">
                <div class="block">
                    <form action="login.do" method="post" onsubmit="retrun check()">
                        <div class="form-group">
                            ID  <input type="text" name="mid"  id="mid" class="form-control" placeholder="Your ID">
                            
                            <!--  <input type="text" name="mid" required pattern="[a-zA-Z][a-zA-Z0-9]{3,11}" id="mid" class="form-control" placeholder="Your ID"> -->
                        </div>
                        <div class="form-group">
                            ��й�ȣ <input type="password" name="pwd" id="pwd" maxlength="20" class="form-control" placeholder="Password">
                        </div>
                        <button class="btn btn-default" id="btn" type="submit">LOGIN</button>
                        <br> <br>
                        <p class="btn_lnk">
                            <a href="${pageContext.request.contextPath}/member/findUserid.do" class="btn_id"> ���̵� / </a> <a href="" class="btn_id"> ��й�ȣã�� </a>
                        </p>

                    </form>
                </div>
            </div>
        </div>
        <div id="contact-box" class="row">
            <div class="col-md-6 col-sm-12">
                <div class="block">
                    <h2>������</h2>
                    <ul class="address-block">
                        <li><i class="fa fa-map-marker"></i>����Ư���� ������ ���굿 107-111 ��ȭ���� 2, 3��</li>
                        <li><i class="fa fa-envelope-o"></i>Email: gkdldudtls@google.com</li>
                        <li><i class="fa fa-phone"></i>Phone:+82 10-6377-5330</li>
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
                <div class="block">
                    <h2>We Also Count In Google Map</h2>
                    <div class="google-map">
                        <div id="map"></div>
                    </div>
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
                    <p>Read more about what we do and our philosophy of design. Judge for yourself The work and results we��ve achieved for other clients, and meet our highly experienced Team who
                        just love to design.</p>
                    <a class="btn btn-default btn-call-to-action" href="#">Tell Us Your Story</a>
                </div>
            </div>
        </div>
    </div>
</section>
