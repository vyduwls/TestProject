<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
   <script type="text/javascript">
   $(document).ready(function() {
      $("#findname").change(function() {
         if($("#findname").is(":checked")){
            $("#fin1").css("display","block")
         }else{
            $("#fin1").css("display","none")
         }
      });
      $("#findemail").change(function() {
         if($("#findemail").is(":checked")){
            $("#fin2").css("display","block")
         }else{
            $("#fin2").css("display","none")
         }
      });
      
//       $("#findname").click(function() {
//          $("#fin1").css("display","block")
//       });
//       $("#findemail").click(function() {
//          $("#fin2").css("display","block")
//       });
      
         if("${error}"=="0"){
            alert("정보가 일치하지않습니다.");
         }else if("${error}"=="1"){
            alert("정보가 일치합니다.")
         }else{
            
         }
   });
   </script>
   

        <!-- Slider Start -->
        <section id="global-header">
          <div class="container">
            <div class="row">
              <div class="col-md-12">
                <div class="block">
                  <h1>Drop Us A Note</h1>
                  <p>Don’t just take our word for it. Check out some of our latest work.</p>
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
                <div id="">
                <input type="checkbox" id="findname" name=""/>
                   <label for="" class="">
                      <span class=""></span>
                       이름 / 전화번호 로 찾기
                   </label>
                  <form action="findUserid.do" method="post" id="fin1" style="display: none;">
                    <div class="form-group" id ="find">
                      <input type="text" class="form-control" id="name" name="name" placeholder="Your Name">
                    </div>
                    <div class="form-group" id ="find1">
                      <input type="text" class="form-control" id="phone" pattern="[0-9]{10}[0-9]?" name="phone" placeholder="'-'를 뺀 휴대전화 번호 10~11자리를 입력해주세요.">
                    </div>
                       <button class="btn btn-default" id="find2" type="submit">ID/PWD 찾기</button>
                       <input type="hidden" value="아아아아" name="aa"/>
                  </form>
                </div>
                   <input type="checkbox" id="findemail" name=""/>
                   <label for="" class="">
                      <span class=""></span>
                       이메일로 찾기
                   </label>
                   <form action="findEmail.do" method="post" id="fin2" style="display: none;">
                    <div class="form-group" id="find3">
                      <input type="text" class="form-control" id="email" name="email" placeholder="Your Email">
                    <button class="btn btn-default"  id ="find4" type="submit">ID/PWD 찾기</button>
                    </div>
                  </form>
                </div>
              </div>
              <div class="col-md-6 col-sm-12">
                <div class="block">
                <form>
                    <div class="form-group-2">
                      <textarea class="form-control" rows="3" placeholder="123">찾으시는 아이디 : ${m.mid}
찾으시는 비밀번호 : ${m.pwd}
                      </textarea>
                    </div> 
                  </form>
                </div>
              </div>
            </div>
            
            <div id="contact-box" class="row">
              <div class="col-md-6 col-sm-12">
                <div class="block">
                  <h2>고객센터</h2>
                    <ul class="address-block">
                        <li><i class="fa fa-map-marker"></i>서울특별시 마포구 노고산동 107-111 미화빌딩 2, 3층</li>
                        <li><i class="fa fa-envelope-o"></i>Email: gkdldudtls@google.com</li>
                        <li><i class="fa fa-phone"></i>Phone:+82 10-6377-5330</li>
                    </ul>

                  <ul class="social-icons">
                    <li>
                      <a href="#"><i class="fa fa-google"></i></a>
                    </li>
                    <li>
                      <a href="#"><i class="fa fa-linkedin"></i></a>
                    </li>
                    <li>
                      <a href="#"><i class="fa fa-pinterest"></i></a>
                    </li>
                    <li>
                      <a href="#"><i class="fa fa-dribbble"></i></a>
                    </li>
                    <li>
                      <a href="#"><i class="fa fa-behance"></i></a>
                    </li>
                    <li>
                      <a href="#"><i class="fa fa-twitter"></i></a>
                    </li>
                    <li>
                      <a href="#"><i class="fa fa-facebook"></i></a>
                    </li>
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
                  <p>Read more about what we do and our philosophy of design. Judge for yourself The work and results we’ve achieved for other clients, and meet our highly experienced Team who just love to design.</p>
                  <a class="btn btn-default btn-call-to-action" href="#" >Tell Us Your Story</a>
                </div>
              </div>
            </div>
          </div>
        </section>
        <!-- footer Start -->
        
        