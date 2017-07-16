<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
    <br><br>
    <div id="mypage_content">
        <h2 id="mypage_content_h2">내 메뉴 수정</h2>
        <a href="${pageContext.request.contextPath}/mypage/regMenu.do" class="btn2 btn btn-default headerbtn">가게메뉴등록</a>
            <select id="updateMenu_content_store">
                    <option>selectStore</option>
            <c:forEach var = "sl" items="${sseqList }">
                    <option>${sl.storeName}</option>
            </c:forEach>
            </select>
            <select id="updateMenu_content_menu">
                    <option>selectStoreFirst</option>
            </select>
    </div>
    
    <div id="mypage_content" class="updateMenu_content">
        <h2 id="mypage_content_h2">가게메뉴수정</h2>
        
        <form id="updateMenuForm" action="updateMenuProc.do" method = "post" enctype="multipart/form-data">
        
            <span>가게명:</span><input disabled="disabled" name = "storename" placeholder="storename" ><br>
            <span>카테고리:</span><input name = "category" placeholder="category"><br>
            <span>메뉴명:</span><input name = "menuname" placeholder="menuname"><br>
            <span>eng메뉴명:</span><input name = "engmenuname" placeholder="engmenuname"><br>
            <span>menuinfo:</span><textarea name = "menuinfo" placeholder="menuinfo" rows="5" cols="100"></textarea><br>
            <span>가격:</span><input name = "price" placeholder="price"><br>
            <span>사진:</span><input type="file" id="img" name = "imgFile">
            <span>가격:</span><input name = "mseq" type="hidden"><br>
            <div id="holder"></div>
            <button type="submit" class="search_modal_box_menubutton">등록</button>
        </form>
    </div>
    
    <script src="${pageContext.request.contextPath}/js/vendor/jquery-1.10.2.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.validate.js"></script>
    <script type="text/javascript">
        
        var menusList="";
        //change
        $("#updateMenu_content_store").change(function(){
            
            $("input[name=storename]").val("");
            $("input[name=category]").val("");
            $("input[name=menuname]").val("");
            $("input[name=engmenuname]").val("");
            $("textarea[name=menuinfo]").val("");
            $("input[name=price]").val("");
            $("input[name=mseq]").val("");
            
            $(".updateMenu_content").css({
                display : "none"
            });            
            
            
            var thisName=$("#updateMenu_content_store").val();
            
            $.ajax({
                tpye : "POST",
                url : "getMenus.do",
                dataType : "json",
                data : {
                    "storeName" : thisName
                },
                success : function(data){
                    menusList=data;
                    console.log(menusList);
                    
                    $("#updateMenu_content_menu").empty()
                    $("#updateMenu_content_menu").append("<option>chooseMenu</option>");
                    
                    for(i=0;i<menusList.length;i++){
                        
                    $("#updateMenu_content_menu").append("<option>"+menusList[i].menuname+"</option>");
                    }
                    
                },
                error : function(request, status, error) {
                    console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);

                }
            })
            
        });
        
        
        
        $("#updateMenu_content_menu").change(function(){
            
            $(".updateMenu_content").css({
                display : "block"
            });
            var index=$("#updateMenu_content_menu option").index($("#updateMenu_content_menu option:selected"))-1;
            console.log(index);
            $("input[name=storename]").val($("#updateMenu_content_store").val());
            $("input[name=category]").val(menusList[index].category);
            $("input[name=menuname]").val(menusList[index].menuname);
            $("input[name=engmenuname]").val(menusList[index].engmenuname);
            $("textarea[name=menuinfo]").val(menusList[index].menuinfo);
            $("input[name=price]").val(menusList[index].price);
            var thisImages=menusList[index].img.split("\\")[menusList[index].img.split("\\").length-2]+"\\"+menusList[index].img.split("\\")[menusList[index].img.split("\\").length-1];
            $("#holder").html("<img src='${pageContext.request.contextPath}/"+thisImages+"'>");
            $("input[name=mseq]").val(menusList[index].mseq);
            
            
            
            
        });
        
        $("#updateMenuForm").validate({
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
                }

            },
            highlight: function(element, errorClass) {
                $(element).css({
                    "border" : "1px solid red",
                })
             }
        });
        
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
            
        }
            
        
    </script>

</body>
</html>
