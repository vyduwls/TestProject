<%@page import="com.disappear.order.util.ChangeURL"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- <script  src="https://code.jquery.com/jquery-3.2.1.js" integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE=" crossorigin="anonymous"></script> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.validate.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$(".like").click(function(){
			$.ajax({
				context: this,
				url:"nCommentLikeUp.do",
				type:"POST",
				data:{"nseq":$(this).siblings("input").val(), "seq":"${seq}"},
				success : function(data){
					if(data==1){
						var num=$(this).siblings("span").text();
						num++;
						$(this).siblings("span").text(num);
						alert("추천 완료!");
					} else {
						alert("이미 이 댓글에는 추천 또는 비추를 했습니다!.");
					}
				},
			}); 
		});
		
		$(".unlike").click(function(){
			$.ajax({
				context:this,	
				url:"nCommentUnlikeUp.do",
				type:"POST",
				data:{"nseq":$(this).siblings("input").val(), "seq":"${seq}"},
				dataType:"text",
				success : function(data){
					if(data==1){
						var num=$(this).siblings("span").text();
						num++;
						$(this).siblings("span").text(num);
						alert("비추 완료!");
					} else{
						alert("이미 이 댓글에는 추천 또는 비추를 했습니다!.");
					}
				}
			}); 
		});
		
 		$(".edit").on("click",function(){
			var comments = $(this).parents().parents().siblings().children(".nComment").text();
			var nseq = $(this).parents().parents().siblings().children(".nComment").children("input").val();
			$(".edit").hide();
			$(".del").hide();
			$(this).parents().parents().siblings().children(".nComment").html("<textarea rows='5' class='form-control textEdit'>"+comments+"</textarea><a class='btn btn-default editComplete'>수정완료</a><a class='btn btn-default editCancel' style='margin-left:2px'>수정취소</a>");
			
			$(".editComplete").on("click",function(){
				var comments1 = $(".textEdit").val();
				$.ajax({
					url:"nCommentEdit.do",
					type:"POST",
					data:{"comments":comments1, "nseq":nseq},
					dataType:"text",
					success:function(data){
						$(".edit").show();
						$(".del").show();
						$($(".editComplete")).parents(".nComment").html(comments1+"<input class='nseq' type='hidden' value='"+nseq+"'>");
					}
				}); 
			});
			
			$(".editCancel").on("click",function(){
				$(".edit").show();
				$(".del").show();
				$(this).parents(".nComment").html(comments+"<input class='nseq' type='hidden' value='"+nseq+"'>");
			});
		});
	 
	});
	
</script>

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
	<form action="nCommentReg.do" method="post" id="nCommentRegForm">
	    <table class="table table-bordered">
	    	<tbody>
	    		<tr>
	    			<th>Store</th>
	    			<td style="width:25%"><img src="../img/search/${n.store }.png" style="width:30px; height:30px"></td>
	    			<th>Recommend</th>
	    			<td style="color: red">
						<c:if test="${n.stars=='1'}">
	            	        <p class="stars">★☆☆☆☆</p>
	                    </c:if>
	                    <c:if test="${n.stars=='2'}">
	          	          <p class="stars">★★☆☆☆</p>
	                    </c:if>
	                    <c:if test="${n.stars=='3'}">
	         	           <p class="stars">★★★☆☆</p>
	                    </c:if>
	                    <c:if test="${n.stars=='4'}">
	         	           <p class="stars">★★★★☆</p>
	                    </c:if>
	                    <c:if test="${n.stars=='5'}">
	          	          <p class="stars">★★★★★</p>
	                    </c:if>
					</td>
	    			<th>Regdate</th>
	                <td><p>${n.regdate.substring(0,16) }</p></td>
	    		</tr>
	    		<tr>
	                <th>Writer</th>
	                <td colspan="3"><p>${n.writer}</p></td>
	                <th>Position</th>
	    			<td>${n.position }</td>
	            </tr>
	            <tr>
	                <th style="width:70px">Title</th>
	                <td colspan="3"><p style="font-weight: bold; ">${n.title}</p></td>
	                <th>Hit</th>
	                <td><p>${n.hit}</p></td>
	            </tr>
	            <tr style="height: 200px;">
	                <th>Content</th>
	                <td colspan="5">
	                	<c:if test="${!empty n.fileSrc }">
	                        <c:set var="imagesArray" value='${fn:split(n.fileSrc, "\\\\")}' />
	                        <img alt="${n.fileSrc }" src="${pageContext.request.contextPath}/${imagesArray[fn:length(imagesArray)-2]}/${imagesArray[fn:length(imagesArray)-1]}" style="width: 300px; height: 300px">
	                    </c:if>
	                    <p>${n.content}</p></td>
	            </tr>
	            <tr >
	                <th>Comment</th>
	                <td colspan="5">
	                	<c:forEach items="${list}" var="m">
	                		<table class="table table-bordered" >
	                			<tbody>
	                				<tr>
	                					<th style="width:10%">Mid</th>
	                					<td style="width: 50%;">${m.mid }</td>
	                					<th>Like</th>
	                					<td style="color:blue; width: 20%">
	                						<span>${m.likeup}</span>&nbsp;
	                						<input type="hidden" name="nseq" value="${m.nseq }">
	                						<c:if test="${mid!=m.mid }">
	                							<a class="like" style="cursor: pointer;">like</a>
	                						</c:if>
	                					</td>
	                					<th>Unlike</th>
	                					<td style="width:20%; color:red">
	                						<span>${m.unlikeup}</span>&nbsp;
	                						<input type="hidden" name="nseq" value="${m.nseq }">
	                						<c:if test="${mid!=m.mid }">
	                						<a class="unlike" style="cursor: pointer;">unlike</a>
	                						</c:if>
	                					</td>
	                				</tr>
	                				<tr>
	                					<th>Regdate</th>
	                					<td colspan="4">${n.regdate.substring(0,16) }</td>
	                					<td style="margin: auto">
	                					<c:if test="${mid == m.mid }">
	                						<a class="btn btn-default edit">수정</a>
	                						<a class="btn btn-default del" href="nCommentDel.do?seq=${seq }&nseq=${m.nseq}&pg=${pg}&f=${f}&q=${q}">삭제</a>
	                					</c:if>
	                					</td>
	                				</tr>
	                				<tr class="commentTr">
	                					<th>Comment</th>
	                					<td style="font-weight: bold;" colspan="7" class="nComment">${m.comments }<input class="nseq" type="hidden" value="${m.nseq }"></td>
	                				</tr>
	                			</tbody>
	                		</table>
	                	</c:forEach>
	                	<div class="form-group">
	                		 <label for="comments">Comment:</label>
	                		<textarea class="form-control" rows="5" name="comments" ></textarea>
	                	</div>
	                </td>
	            </tr>
	            <tr>
	            	<td colspan="6">
	            		<c:if test="${nL!=1 }">
							<a href="notice.do?pg=${pg}&f=${f}&q=${q}&s=${q}&m=${m}" class="btn btn-default" >목록</a>
						</c:if>
	            		<c:if test="${nL==1 }">
							<a href="notice.do" class="btn btn-default" >목록</a>
						</c:if>
						<c:if test="${mid == n.writer }">
							<c:if test="${nL!=1 }">
								<a href="noticeEdit.do?seq=${seq}&pg=${pg}&f=${f}&q=${q}&s=${q}&m=${m}&nL=0" class="btn btn-default" >수정</a> 
							</c:if>
							<c:if test="${nL==1 }">
								<a href="noticeEdit.do?seq=${seq}&pg=${pg}&f=${f}&q=${q}&s=${q}&m=${m}&nL=1" class="btn btn-default" >수정</a> 
							</c:if>
							<c:if test="${nL!=1 }">
								<a href="noticeDel.do?seq=${seq}&pg=${pg}&f=${f}&q=${q}&nL=0" class="btn btn-default" >삭제</a>
							</c:if>
							<c:if test="${nL==1 }">
								<a href="noticeDel.do?seq=${seq}&pg=${pg}&f=${f}&q=${q}&nL=1" class="btn btn-default" >삭제</a>
							</c:if>
						</c:if>
						<c:if test="${(nr.recommend == null || nr.recommend==0) && mid != n.writer}">
							<span style="float: right"><a href="noticeLike.do?seq=${seq}&pg=${pg}&f=${f}&q=${q}&r=-1" class="btn btn-default" style="margin-left:2px; width:63.28px; height: 24px; padding-top:1px; font-family: hyundai; color: blue">반대</a></span>
							<span style="float: right"><a href="noticeLike.do?seq=${seq}&pg=${pg}&f=${f}&q=${q}&r=1" class="btn btn-default" style="margin-left:2px; width:63.28px; height: 24px; padding-top:1px; font-family: hyundai; color: blue">추천</a></span>
						</c:if>
						<c:if test="${nr.recommend == 1 && mid != n.writer}">
							<span style="float: right"><a href="noticeLike.do?seq=${seq}&pg=${pg}&f=${f}&q=${q}&r=-1" class="btn btn-default" style="margin-left:2px; width:63.28px; height: 24px; padding-top:1px; font-family: hyundai; color: red">추천취소</a></span>
						</c:if>
						<c:if test="${nr.recommend == -1 && mid != n.writer}">
							<span style="float: right"><a href="noticeLike.do?seq=${seq}&pg=${pg}&f=${f}&q=${q}&r=1" class="btn btn-default" style="margin-left:2px; width:63.28px; height: 24px; padding-top:1px; font-family: hyundai; color: red">비추취소</a></span>
						</c:if>
						<c:if test="${nL==1 }">
							<span style="float: right"><a href="${pageContext.request.contextPath}/mypage/noticeList.do?nL=1&pg=${pg}&f=${f}&q=${q}&s=${q}&m=${m}" class="btn btn-default" style="margin-left:2px; width:63.28px; height: 24px; padding-top:1px; font-family: hyundai;">뒤로가기</a></span>
						</c:if>
							<span style="float: right"><button class="btn btn-default">댓글등록</button></span>
					</td>
	            </tr>
	        </tbody>
	    </table>
	    <input type="hidden" name="seq" value="${param.seq }">
	    <input type="hidden" name="pg" value="${param.pg }">
	    <input type="hidden" name="q" value="${param.q }">
	    <input type="hidden" name="f" value="${param.f }">
	</form>
<script type="text/javascript">
	$("#nCommentRegForm").validate({ // joinForm에 validate를 적용
	    rules:{
	        comments:{required:true}, 
	        // minlength : 최소 입력 개수, digits: 정수만 입력 가능
	    }
	});
	
</script>
</div>

