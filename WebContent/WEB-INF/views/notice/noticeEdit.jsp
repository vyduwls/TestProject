<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
	<form action="noticeEdit.do?seq=${seq}&pg=${pg}&f=${f}&q=${q}&h=0&s=${q}&m=${m}" method="post" id="noticeEditForm">
	    <table class="table table-bordered">
	    	<tbody>
	    		<tr>
	    			<th>Store</th>
	    			<td style="width:55%"><img src="../img/search/${n.store }.png" style="width:30px; height:30px"></td>
	    			<th>Regdate</th>
	                <td><p>${n.regdate.substring(0,16) }</p></td>
	    		</tr>
	    		<tr>
                    <th>Recommend</th>
                    <td colspan="3">
                    	<select name="stars" class="form-control" id="stars" style="width:50%; float: left">
                    	<c:if test="${n.stars=='1'}">
		                    <option value="" selected="selected">★☆☆☆☆</option>
		                </c:if>
		                <c:if test="${n.stars=='2'}">
		                    <option value="" selected="selected">★★☆☆☆</option>
		                </c:if>
		                <c:if test="${n.stars=='3'}">
		                    <option value="" selected="selected">★★★☆☆</option>
		                </c:if>
		                <c:if test="${n.stars=='4'}">
		                    <option value="" selected="selected">★★★★☆</option>
		                </c:if>
		                <c:if test="${n.stars=='5'}">
		                    <option value="" selected="selected">★★★★★</option>
		                </c:if>
		                
		                	<option value="1">★☆☆☆☆</option>
		                    <option value="2">★★☆☆☆</option>
		                    <option value="3">★★★☆☆</option>
		                    <option value="4">★★★★☆</option>
		                    <option value="5">★★★★★</option>
                    	</select>
                    	<p style="float: left; margin-left:20px; color: red">평점을 변경하시려면 다시 선택해 주세요.</p>
                    </td>
                </tr>
	    		<tr>
	                <th>Position</th>
	    			<td colspan="4">
	    				<div class="form-group" id="select" style="width: 100%; margin-bottom: 50px">
                            <select class="form-control" style="height: 40px; width: 200px; float: left; margin-right: 2%" name="area" onchange="doChange(this, 'county')">
                                <option value="" selected>${n.position.substring(0,2) }</option>
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
                            <select class="form-control" name="county" id="county" style="height: 40px; width: 200px; float: left">
                                <option value="">${n.position.substring(3) }</option>
                            </select>
                        </div>
	    			</td>
	            </tr>
	            <tr>
	                <th style="width:70px">Title</th>
	                <td colspan="4"><input type="text" value="${n.title}" name="title" class="form-control" /></td>
	            </tr>
	            <tr style="height: 200px;">
	                <th>Content</th>
	                <td colspan="3">
	                	<c:if test="${!empty n.fileSrc }">
	                        <c:set var="imagesArray" value='${fn:split(n.fileSrc, "\\\\")}' />
	                        <img alt="${n.fileSrc }" src="${pageContext.request.contextPath}/${imagesArray[fn:length(imagesArray)-2]}/${imagesArray[fn:length(imagesArray)-1]}" style="width: 300px; height: 300px">
	                    </c:if>
	                    <textarea rows="10" name="content" class="form-control">${n.content}</textarea>
	                </td>
	            </tr>
	            <tr>
	                <td colspan="4">
						<button class="btn btn-default" style="font-family: hyundai">수정</button>
						<c:if test="${nL!=1 }">
                    		<a href="noticeDetail.do?seq=${seq}&pg=${pg}&f=${f}&q=${q}&h=0&s=${q}&m=${m}" class="btn btn-default" style="width: 42px; height: 24px; padding-top:1px; font-family: hyundai">취소</a>
                    	</c:if>
						<c:if test="${nL==1 }">
                    		<a href="noticeDetail.do?seq=${seq}&pg=${pg}&f=${f}&q=${q}&h=0&s=${q}&m=${m}&nL=1" class="btn btn-default" style="width: 42px; height: 24px; padding-top:1px; font-family: hyundai">취소</a>
                    	</c:if>
					</td>
	            </tr>
	        </tbody>
	    </table>
	    <input type="hidden" name="area1" value="${n.position.substring(0,2) }">
	    <input type="hidden" name="county1" value="${n.position.substring(3) }">
	    <c:if test="${nL.equals('0') }">
	    	<input type="hidden" name="nL" value=0>
        </c:if>
        <c:if test="${nL.equals('1') }">
	    	<input type="hidden" name="nL" value=1>
        </c:if>
    </form>
<script type="text/javascript">
	$("#noticeEditForm").validate({ // joinForm에 validate를 적용
	    rules:{
	        title:{required:true}, 
	        content:{required:true},
	        stars:{required:true}
	        // minlength : 최소 입력 개수, digits: 정수만 입력 가능
	    }
	});
	
</script>
</div>

