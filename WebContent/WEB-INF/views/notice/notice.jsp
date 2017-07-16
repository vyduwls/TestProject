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
<div class="table-responsive-vertical shadow-z-1" style="border: 2px solid #ddd; border-radius:10px; margin: auto; padding:2%; width: 70%; font-family: hyundai; margin-top:50px; margin-bottom: 50px;">
	<form action="noticeSearch.do" method="post">
		<button type="submit" class="btn btn-primary search" style="float: right; margin-left: 5px; height: 30px; margin-bottom: 20px">검색</button>
		<input class="form-control input-sm" type="text" name="search" style="width: 20%; float: right" value="${s }">
		<div class="form-group col-xs-3" style="float: right">
		  <select class="form-control" name="menu" style="height: 31px">
		  <c:if test="${m !=null && !m.equals('') }">
		  	<option value="" selected>${m }</option>
		  </c:if>
		    <option>Title Content</option>
		    <option>Writer</option>
		    <option>Position</option>
		    <option>Store</option>
		  </select>
		</div> 
		<input type="hidden" name="m1" value="${m }"> 
	</form>
	
    <!-- Table starts here -->
    <table id="table" class="table table-hover table-mc-light-blue" >
        <thead>
            <tr>
                <th>No</th>
                <th>Stroe</th>
                <th style="width: 10%">Position</th>
                <th style="width: 30%">Title</th>
                <th style="width: 100px">Writer</th>
                <th style="width: 200px">Regdate</th>
                <th style="width: 70px">Hit</th>
                <th>Recommend</th>
                <th style="width: 70px; color: blue">Likes</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="n" items="${list}">
                <tr class="tr" onclick="location.href='noticeDetail.do?seq=${n.seq}&pg=${pg}&f=${f }&q=${q}&h=1&s=${q}&m=${m}'" style="cursor: pointer;">
	                    <td class="seq" >${n.seq}</td>
	                    <td class="store" ><img src="../img/search/${n.store }.png"></td>
	                    <td class="position" >${n.position }</td>
	                    <td class="title" style="font-weight: bold; ">
	                    	${n.title}
	                    	<c:forEach var="c" items="${cList }">
	                    		<c:if test="${n.seq == c.seq }">
	                    		<span style="color: gray; font-weight: normal;">(${c.counts })</span> 
	                    		</c:if>
	                    	</c:forEach>
	                    </td>
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

	<div class="col-lg-6">
		<a href="noticeReg.do"><button class="btn btn-default" >글쓰기</button></a>
	</div>
	<div class="col-lg-6">
	<c:if test="${startFN!=1 }">
		<div style="float: left;">
				<a href="notice.do?pg=${startFN-1}&f=${f }&q=${q}&s=${q}&m=${m}" style="padding-right:5px"><button class="btn btn-default" >◀</button></a>
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
							<a href="notice.do?pg=${i+startFN }&f=${f }&q=${q}&s=${q}&m=${m}" >${i+startFN}</a>
						</c:if>

					</c:if>
				</li>
			</c:forEach>
		</ul>
	<c:if test="${startFN+4<finalFN }">
		<div style="float: left">
			<a class="btn" href="notice.do?pg=${startFN+5 }&f=${f}&q=${q}&s=${q}&m=${m}" ><button class="btn btn-default">▶</button></a>
	    </div>
	</c:if>
	</div>
    <div style="clear:both"></div>
</div>

