<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<section id="global-header">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="block">
                    <h1>Free Notice Board</h1>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- 게시글 -->
<div class="container" style="margin: auto; width: 60%; margin-top: 20px; font-family: hyundai;">
<script src="${pageContext.request.contextPath}/js/vendor/jquery-1.10.2.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.validate.js"></script>
    <form action="noticeReg.do" method="post" enctype="multipart/form-data" id="noticeRegForm">
        <table class="table table-bordered">
            <tbody>
                <tr>
                    <th>제목</th>
                    <td><input name="title" class="form-control"/></td>
                </tr>
                <tr>
                    <th>가게</th>
                    <td><select name="store" class="form-control">
                            <option value="" selected>가게 선택</option>
                            <option value="mac">맥도날드</option>
                            <option value="star">스타벅스</option>
                    </select></td>
                </tr>
                <tr>
                    <th>평점</th>
                    <td><select name="stars" class="form-control">
                            <option value="" selected>평점 선택</option>
                            <option value="1">★☆☆☆☆</option>
                            <option value="2">★★☆☆☆</option>
                            <option value="3">★★★☆☆</option>
                            <option value="4">★★★★☆</option>
                            <option value="5">★★★★★</option>
                    </select></td>
                </tr>
                <tr>
                    <th>위치</th>
                    <td>
                        <div class="form-group" id="select" style="width: 100%; margin-bottom: 50px">
                            <select style="height: 40px; width: 200px; float: left; margin-right: 2%" name="area" onchange="doChange(this, 'county')" class="form-control">
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
                            </select> <select name="county" id="county" style="height: 40px; width: 200px; float: left" class="form-control">
                                <option value="">시/구/군 선택</option>
                            </select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td>
                       <input type="file" name="imgFile" id="images" style="border-radius: 2px;"/>
                       <div id="holder"></div>
                    </td>
                </tr>
                <tr style="height: 200px">
                    <th>내용</th>
                    <td><textarea class="form-control" rows="10" id="txtContent" class="txtContent" name="content"></textarea></td>
                </tr>
                <tr>
                    <td colspan="2">
                       <input type="submit" value="저장" class="btn btn-default submit" /> 
                       <a href="notice.do" class="btn btn-default" style="width: 42px; height: 24px; padding-top: 1px">취소</a>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>
<script type="text/javascript">
	$("#noticeRegForm").validate({ // joinForm에 validate를 적용
	    rules:{
	        title:{required:true}, 
	        store:{required:true},
	        area:{required:true}, 
	        county:{required:true}, // 검증값이 하나일 경우 이와 같이도 가능
	        content:{required:true, minlength:10},
	        // minlength : 최소 입력 개수, digits: 정수만 입력 가능
	        stars:{required:true}
	    }
	});
	
</script>
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
    
}

</script>
