<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<br>
<br>
<div class="table-responsive-vertical shadow-z-1"
style="border: 2px solid #ddd; border-radius: 10px; margin: auto; padding: 2%; width: 70%; font-family: hyundai; margin-top: 50px; margin-bottom: 50px;">
	<h2 id="mypage_content_h2" style="font-family: hyundai;">내가 쓴 글</h2><br><br>
	<form action="noticeListSearch.do" method="post">
		<button type="submit" class="btn btn-primary search" style="float: right; margin-left: 5px; height: 30px; margin-bottom: 20px">검색</button>
		<input class="form-control input-sm" type="text" name="search" style="width: 20%; float: right" value="${s }">
		<div class="form-group col-xs-3" style="float: right">
		  <select class="form-control" name="menu" style="height: 31px">
		  <c:if test="${m !=null && !m.equals('') }">
		  	<option value="" selected>${m }</option>
		  </c:if>
		    <option>Title Content</option>
		    <option>Position</option>
		    <option>Store</option>
		  </select>
		</div> 
		<input type="hidden" name="m1" value="${m }"> 
	</form>
	<div class="table-wrapper" style="width: 100%;">
		<br><br>

		<!-- Table starts here -->
		<table id="table" class="table table-hover table-mc-light-blue" style="margin: auto; ">
			<thead>
				<tr >
					<th style="text-align: left">No</th>
					<th style="text-align: left; text-align: left">Stroe</th>
					<th style="width: 10%; text-align: left">Position</th>
					<th style="width: 30%; text-align: left">Title</th>
					<th style="width: 100px; text-align: left">Writer</th>
					<th style="width: 200px; text-align: left">Regdate</th>
					<th style="width: 70px; text-align: left">Hit</th>
					<th style="text-align: left">Recommend</th>
					<th style="width: 70px; color: blue; text-align: left">Likes</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="n" items="${list}">
					<tr class="tr" onclick="location.href='${pageContext.request.contextPath}/notice/noticeDetail.do?seq=${n.seq}&pg=${pg}&f=${f }&q=${q}&h=1&nL=1&s=${q }&m=${m }'" style="cursor: pointer;">
						<td class="seq">${n.seq}</td>
						<td class="store"><img src="../img/search/${n.store }.png"></td>
						<td class="position">${n.position }</td>
						<td class="title" style="font-weight: bold; ">${n.title}</td>
						<td class="writer">${n.writer }</td>
						<td class="regdate">${n.regdate.substring(0,16) }</td>
						<td class="hit">${n.hit }</td>
						<c:if test="${n.stars=='1'}">
	            	        <td class="stars">★☆☆☆☆</td>
	                    </c:if>
	                    <c:if test="${n.stars=='2'}">
	          	        	<td class="stars">★★☆☆☆</td>
	                    </c:if>
	                    <c:if test="${n.stars=='3'}">
	         	         	<td class="stars">★★★☆☆</td>
	                    </c:if>
	                    <c:if test="${n.stars=='4'}">
	         	           	<td class="stars">★★★★☆</td>
	                    </c:if>
	                    <c:if test="${n.stars=='5'}">
	          	          	<td class="stars">★★★★★</td>
	                    </c:if>
	                    <td class="Likes" style="text-align: right; padding-right:40px;">${n.counts }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<br><br>
	<div class="col-lg-6"></div>
	<div class="col-lg-6">
	<c:if test="${startFN!=1 }">
		<div style="float: left;">
				<a href="noticeList.do?pg=${startFN-1}&f=${f }&q=${q}&m=${m}&s=${q}" style="padding-right:5px"><button class="btn btn-default" >◀</button></a>
		</div>
	</c:if>
		<ul>
			<c:forEach var="i" begin="0" end="4">
				<li style="float: left; padding-right: 5px">
					<c:if test="${startFN+i <=finalFN }">
						<c:if test="${startFN+i==pg }">
							<a>${i+startFN}</a>
						</c:if>
						<c:if test="${startFN+i!=pg }">
							<a href="noticeList.do?pg=${i+startFN }&f=${f }&q=${q}&m=${m}&s=${q}" >${i+startFN}</a>
						</c:if>

					</c:if>
				</li>
			</c:forEach>
		</ul>
	<c:if test="${startFN+4<finalFN }">
		<div style="float: left">
			<a class="btn" href="noticeList.do?pg=${startFN+5 }&f=${f}&q=${q}&m=${m}&s=${q}" ><button class="btn btn-default" style="margin-bottom: 30px;">▶</button></a>
	    </div>
	</c:if>
	</div>
</div>
<br>
<br>


</body>
</html>
