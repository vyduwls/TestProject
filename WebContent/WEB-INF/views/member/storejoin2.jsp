<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <section id="global-header">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="block">
                        <h1>My Page</h1>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <div id="mypage_content">
        <h2 id="mypage_content_h2">가게정보등록</h2>
        <form action="regStoreProc.do" method = "post" enctype="multipart/form-data">
        
            <label>사업자등록번호:</label><input name = "storeNumber" placeholder="storeNumber"><br>
            <label>가게명:</label><input name = "storeName" placeholder="storeName"><br>
            <label>주소:</label><input name = "address" placeholder="address"><br>
            <label>전화번호:</label><input name = "phoneNumber" placeholder="phoneNumber"><br>
            <label>가게사진:</label><input type="file" id="images" name = "imgFile"><br>
            <input type ="hidden" name="writer" value="1">
            <div id="holder"></div>
            <button type="submit">등록</button>
        </form>
    </div>
    

<script type="text/javascript">
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
