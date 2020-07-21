<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	
	#wrap div { 
		display: inline-block;
	}
	
	section{
		margin-left: 300px; margin-right: 300px;
	}
	
	#storeInfo {
		border: 1px solid #e3e1da;
	}
	
	#menuInfo{
		margin-top: 50px;
	 }
	
	#buy {
		margin-left: 900px; margin-top: 30px;
	}
	
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
////////////////////////////////////////////////////예지///////////////////////////////////////////
//메뉴사진 읽기
function loadImage(){
	
	var file = $("#sajin")[0].files[0];
	
	//이미지파일 화면에 출력
	var reader = new FileReader();
	reader.onload = function(e){
		$("#show_menusajin").attr("src", e.target.result);
	}
	reader.readAsDataURL(file);
	return true;
	
}

//다음 지도API
function openDaumZipAddress() {
	new daum.Postcode({
		oncomplete:function(data) {
			jQuery("#zonecode").val(data.zonecode);
			jQuery("#address").val(data.address);
			jQuery("#address_etc").focus();
			console.log(data);
		}
		
	}).open();
}

$(function(){
	//5.주소API ,로 잘라 보이기
 	var beforejusoStr = "${storeRead.SAddress}";
 	var afterjusoStr = beforejusoStr.split(",");
 	
 	$("#zonecode").val(afterjusoStr[0]);
 	$("#address").val(afterjusoStr[1]);
 	$("#address_etc").val(afterjusoStr[2]);
 	
///////////////////////////////////////////////////////////예지///////////////////////////////////////////////////

///////////////////////////////////////////////////일관///////////////////////////////

	// 3. 장바구니에 추가
	$(".cart").on("click", function() {
		var params = {
			menuno: $(this).attr("data-menuno"),
			_csrf: "${_csrf.token}"
		}
		$.ajax({ 
			url: "/cheatingday/cart/add",
			method: "post",
			data: params,
		}).done(()=>{
			var choice = confirm("상품을 장바구니에 담았습니다. 장바구니로 이동하시겠습니까?");
			if(choice==true)
				location.href = "/cheatingday/cart/cartview"
		}).fail((xhr)=>{
			alert(xhr.responseText);
		})
	});
 	
})

</script>
</head>
<body>


<div id="wrap">
<div id="storeInfo">

	<div>
	 <span id="SName" style="font-size: 30px; font-weight: bold">${storeRead.SName}</span> <hr>
	</div>
	<br>
	
	<div>
	 <img id="show_storesajin" height="200px;" src="${storeRead.SSajin}">
	</div>
	
	
	<div>
	<c:forEach begin="1" end="${storeRead.SStarPoint}">
       <img src="https://assets.cdn.soomgo.com/icons/icon-common-review-star-small-full.svg">
         </c:forEach>
          <c:forEach begin="${storeRead.SStarPoint}" end="5">
        <img src="https://assets.cdn.soomgo.com/icons/icon-common-review-star-small-empty.svg">
         </c:forEach>
         
         <span id="SStarPoint"> / ${storeRead.SStarPoint}</span>
         
	</div>
	
	
	
	<div>
	매장 전화번호: <span id="STel">${storeRead.STel}</span>
	</div>
	
	<div>
         주소: <span>${storeRead.SAddress}</span>
	</div>
	
	<!-- 음식점 카테고리번호에 해당하는 내용을 읽어와야해  -->
	<div>
	<!-- 카테고리 : <input type="text" name="foodcategory" id="foodcategory" value="${storeRead.foodCategory}">  -->
	카테고리:<span id="foodcategory">${storeRead.foodCategory}</span>
	</div> 
	
	<div>
	리뷰수:<span id="SReviewCnt">${storeRead.SReviewCnt}</span>
	</div>
	
	
	
<div>
	매장정보: <span id="SInfo">${storeRead.SInfo}</span>
</div>	
</div>


<div id="menuInfo">
	
	<c:forEach items="${cartlist}" var="product" varStatus="status">
		<div class="card"   style="width: 176px; margin-right: 25px;">
			<img src="${product.menusajin}" width="176px" height="150px">
			<div>
				<span style="font-size: 1.5em;">${product.menuname}</span>
				<hr>
				<span>${product.menusal}원</span>
				
			</div>
			<span>
				<button class="cart btn btn-danger" data-menuno="${product.menuno}"><i class="fas fa-shopping-cart">&nbsp;장바구니 담기</i></button>
			</span>
		</div>
	</c:forEach>
	</div>
</div>


	<form action="/cheatingday/cart/cartview" method="get">
	<button id="buy" class="cart btn btn-danger">장바구니로 이동!<br></button><br>
	</form>



</body>
</html>