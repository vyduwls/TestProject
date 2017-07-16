<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <br><br>
    <div id="mypage_content">
        <h2 id="mypage_content_h2">가게메뉴등록</h2>
        <form id="regMenu_content" action="regMenuProc.do" method = "post" enctype="multipart/form-data">
        
            <span>가게명:</span>
            <select name="storename" id="regMenu_content_store">
                    <option>selectStore</option>
            <c:forEach var = "sl" items="${sseqList }">
                    <option>${sl.storeName}</option>
            </c:forEach>
            </select><br>
            <span>카테고리:</span><input name = "category" placeholder="category"><br>
            <span>메뉴명:</span><input name = "menuname" placeholder="menuname"><br>
            <span>eng메뉴명:</span><input name = "engmenuname" placeholder="engmenuname"><br>
            <span>menuinfo:</span><textarea id="regMenuTextarea" name = "menuinfo" placeholder="menuinfo" rows="5" cols="100"></textarea><br>
            <span>가격:</span><input name = "price" placeholder="price"><br>
            <span>사진:</span><input type="file" id="img" name = "imgFile">
            <div id="holder"></div>
            <button type="submit" class="search_modal_box_menubutton">등록</button>
        </form>
    </div>
    
<script src="${pageContext.request.contextPath}/js/jquery.validate.js"></script>
<script type="text/javascript">
    var upload= document.getElementById("img");
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
    
    $("#regMenu_content").validate({
        rules : {
            category : {
                required : true,
            },
            menuname : {
                required : true
            },
            engmenuname : {
                required : true
            },
            menuinfo : {
                required : true
            },
            price : {
                required : true
            },
            imgFile : {
                required : true
            }
            

        },
        highlight: function(element, errorClass) {
            $(element).css({
                "border" : "1px solid red",
            })
         }
    });
    
    $("#regMenu_content_store").change(function(){
        $("input").each(function(index){
            $(this).css({
                "display" : "inline-block"
            })
        })
        $("span").each(function(index){
            $(this).css({
                "display" : "inline-block"
            })
        })
        $("textarea").css({
              "display" : "inline-block"
        })
        $("button").css({
              "display" : "inline-block"
        })
        $("#regMenu_content_store option:first").remove();
    });
</script>
