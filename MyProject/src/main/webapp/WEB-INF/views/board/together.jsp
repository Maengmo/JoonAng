<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
	<title>함께해요 중앙😊</title>
    <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=37x4nvryl9"></script>
	
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
	.info-window {
		overflow-y : auto;
	}
</style>

</head>
<body>
    <%@ include file="/WEB-INF/views/inc/header.jsp" %>

	<div class="form-group">
	    <select class="form-control" id="departmentSelect">
	      <option value="1">메가박스</option>
	      <option value="2">휘닉스</option>
	      <option value="3">플레이타임</option>
	      <option value="4">JTBC</option>
	      <option value="5">중앙일보</option>
	      <option value="6">스템커피</option>
	      <option value="7">콘텐트리중앙</option>
	      <option value="8">이외 근무처</option>
	    </select>
	  </div>

    <div id="map" style="width:100%;height:750px;"></div>
    
    <%@ include file="/WEB-INF/views/inc/footer.jsp" %>
	
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
<script>
	var tonum;
	
	//맵의 시작
    var mapOptions = {
        center: new naver.maps.LatLng(37.5770107, 126.890068),
        zoom: 14
    };

	//맵을 추가
    var map = new naver.maps.Map('map', mapOptions);

	//마커 배열 및 infowindow 배열 선언
    var markers = [];
    var infowindows = [];

    //서버에서 전송된 -> list에 따른 배열 -> 마커 생성
    <c:forEach items="${list}" var="dto">
        var position = new naver.maps.LatLng(${dto.sta_l}, ${dto.sta_h});
        var imageUrl;
		
        //부서에 따른 이미지 URL
        <c:choose>
            <c:when test="${dto.dep_num == 1}">
                imageUrl = 'resources/img/mega2.PNG';
            </c:when>
            <c:when test="${dto.dep_num == 2}">
                imageUrl = 'resources/img/m_condoLogo.png';
            </c:when>
            <c:when test="${dto.dep_num == 3}">
                imageUrl = 'resources/img/m_playLogo.png';
            </c:when>
            <c:when test="${dto.dep_num == 4}">
                imageUrl = 'resources/img/m_jtbc.png';
            </c:when>
            <c:when test="${dto.dep_num == 5}">
                imageUrl = 'resources/img/m_joongang.png';
            </c:when>
            <c:when test="${dto.dep_num == 6}">
                imageUrl = 'resources/img/m_stem.png';
            </c:when>
        </c:choose>
		
        //마커 옵션 생성
        var markerOptions = {
            position: position,
            map: map,
            icon: {
                url: imageUrl,
                size: new naver.maps.Size(50, 52),
                origin: new naver.maps.Point(0, 0),
                anchor: new naver.maps.Point(25, 26)
            }
        };
		
        //마커 찍기
        var marker = new naver.maps.Marker(markerOptions);
		
        
        //Content 작성 
        var contentString = [
            '<div class="info-window" style="width:400px; height:500px; overflow:scroll; overflow-x: hidden; padding:20px;">',
            '   <h4 class="mt-1 text-center fw-bold text-danger">❗ ${dto.work_place} ❗</h3>',
            '   <img class="img-fluid w-100" src="resources/img/together.png">',
            '   <div class="mb-3">',
            '       <h5 class="mt-2 text-center fw-bold text-danger">${dto.work_place} 함께해요!</h5>',
            '       <p class="mt-2 text-center fw-bold">주소 : ${dto.work_address}</p>',
            '   </div>',
            '   <hr class="my-4">',
            '   <h5 class="mb-3 text-center fw-bold">😄열려있는 소통의 창구😄</h5>',
            '<div id="dynamicContent"> ',
            <c:forEach items="${list2}" var="dto2">
            '<c:if test="${dto.sta_num eq dto2.sta_num}">',
            <c:set var="tonum" value="${dto2.to_num}" />
            '   <div class="container border mb-1">',
            '       <div class="row">',
            '            <div class="col-md-9">',
            '               <p class="mt-2">${dto2.to_content}</p>',
            '            </div>',
            '            <div class="col-md-3 text-end">',
            '               <p class="mt-2">${dto2.cus_id}</p>',
            '           </div>',
            '        </div>',
            '   </div>',
          	'</c:if>',
            </c:forEach>
          	'</div>',
            '   <div class="mb-3 mt-3">',
            '       <form>',
            '           <div class="mb-3 mt-1">',
            '               <textarea class="form-control" id="inputReview" rows="3"></textarea>',
            '           </div>',
            '           <div class="text-center">',
            '               <button type="button" class="btn btn-primary" onclick="addTanswer(${dto.sta_num})">작성 완료</button>',
            '               <button type="button" class="btn btn-danger" onclick="closeInfoWindow(${dto.sta_num})">닫기</button>',    
            '           </div>',
            '<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }">',
            '       </form>',
            '   </div>',
            '</div>'
        ].join('');
		
        //infowindow 설정 
        var infowindow = new naver.maps.InfoWindow({
            content: contentString,
            maxWidth: 400,
            maxheight: 100,
            backgroundColor: "#FFFAFA",
            borderColor: "#ddd",
            borderWidth: 1,
            padding: 0,
            anchorSize: new naver.maps.Size(30, 30),
            anchorSkew: true,
            anchorColor: "#fff",
            disableAnchor: true,
            pixelOffset: new naver.maps.Point(20, -20)
        });
		
        //마커 클릭시 -> infowindow 출력
        naver.maps.Event.addListener(marker, "click", (function (infowindow, marker) {
            return function (e) {
                if (infowindow.getMap()) {
                    infowindow.close();
                } else {
                    // 모든 정보 창을 닫음
                    for (var i = 0; i < infowindows.length; i++) {
                        infowindows[i].close();
                    }
                    infowindow.open(map, marker);
                }
            };
        })(infowindow, marker));
		
        markers.push(marker);
        infowindows.push(infowindow);
        
        //infowindow 닫기
        function closeInfoWindow() {
            for (var i = 0; i < infowindows.length; i++) {
                infowindows[i].close();
            }
        }
        
    </c:forEach>

//소통공간 -> 댓글 달기 -> Ajax 처리
function addTanswer(sta_num) {
    var reviewContent = $('#inputReview').val();  // 답변 내용을 textarea에서 가져옴
	
    console.log(sta_num);
    console.log(reviewContent);
    
    // Ajax 요청
    $.ajax({
        url: '/project/together/addTanswer',
        method: 'POST',
        data: {
            sta_num: sta_num,
            to_content: reviewContent 
        },
        success: function (data) {
            console.log('답변 추가 성공:', data);
            //location.reload();
            
            var dynamicContent = document.getElementById("dynamicContent");
            dynamicContent.innerHTML += '<div class="container border mb-0 mt-0">' +
                '<div class="row">' +
                '<div class="col-md-9">' +
                '<p class="mt-2">' + reviewContent + '</p>' +
                '</div>' +
                '<div class="col-md-3 text-end">' +
                '<p class="mt-2">' + data + '</p>' +
                '</div>' +
                '</div>' +
                '</div>';
                
        },
        error: function (xhr, status, error, data) {
            console.error('답변 추가 실패:', status, error);
            console.log(data);
            
            //location.reload();
        }
    });
}

//부서 별 마커찍기
$(document).ready(function () {
    // 부서 선택이 변경될 때 이벤트 처리
    $("#departmentSelect").change(function () {
        
        // 선택한 부서의 값 가져오기
        var selectedDepartmentId = $(this).val();
        console.log(selectedDepartmentId);
        
        // Ajax -> 부서 정보
        $.ajax({
            url: '/project/together/dep' + selectedDepartmentId,
            method: 'GET',
            data: JSON.stringify(),
            dataType: "json",
            success: function (data) {
                
                //기존의 마커 제거
                removeMarkers();
                
                //마커 추가
                addMarker(data);
                
                console.log(data);
            },
            error: function (xhr, status, error) {
                // 오류 발생 처리
                console.error('부서 정보 가져오기 실패:', status, error);
            }
        });
    });

// 지도에 마커 추가
function addMarker(data) {
	
    for (var i = 0; i < data.length; i++) {
        var dto = data[i];

        var position = new naver.maps.LatLng(dto.sta_l, dto.sta_h);
        var imageUrl;
        
        var dep_num = dto.dep_num;

        switch (dep_num) {
            case '1':
                imageUrl = 'resources/img/mega2.PNG';
                break;
            case '2':
                imageUrl = 'resources/img/m_condoLogo.png';
                break;
            case '3':
                imageUrl = 'resources/img/m_playLogo.png';
                break;
            case '4':
                imageUrl = 'resources/img/m_jtbc.png';
                break;
            case '5':
                imageUrl = 'resources/img/m_joongang.png';
                break;
            case '6':
                imageUrl = 'resources/img/m_stem.png';
                break;
            default:
                imageUrl = 'resources/img/m_stem.png'; // 디폴트 이미지 URL
        }

        var markerOptions2 = {
            position: position,
            map: map,
            icon: {
                url: imageUrl,
                size: new naver.maps.Size(50, 52),
                origin: new naver.maps.Point(0, 0),
                anchor: new naver.maps.Point(25, 26)
            }
        };

        	//console.log("추가됨");
        	
        var marker = new naver.maps.Marker(markerOptions2);
        
        var contentString = [
            '<div class="info-window" style="width:350px; height:500px; overflow:scroll;">',
            '   <h4 class="mt-1 text-center fw-bold text-danger">❗ ${dto.work_place} ❗</h3>',
            '   <img class="img-fluid w-100" src="resources/img/together.png">',
            '   <div class="mb-3">',
            '       <h5 class="mt-2 text-center fw-bold text-danger">${dto.work_place} 함께해요!</h5>',
            '       <p class="mt-2 text-center fw-bold">주소 : ${dto.work_address}</p>',
            '   </div>',
            '   <hr class="my-4">',
            '   <h5 class="mb-3 text-center fw-bold">😄열려있는 소통의 창구😄</h5>',
            <c:forEach items="${list2}" var="dto2">
            '<c:if test="${dto.sta_num eq dto2.sta_num}">',
            <c:set var="tonum" value="${dto2.to_num}" />
            '   <div class="container border">',
            '       <div class="row">',
            '            <div class="col-md-9">',
            '               <p class="mt-2">${dto2.to_content}</p>',
            '            </div>',
            '            <div class="col-md-3 text-end">',
            '               <p class="mt-2">${dto2.cus_id}</p>',
            '           </div>',
            '        </div>',
            '   </div>',
          	'</c:if>',
            </c:forEach>
            '   <div class="mb-3">',
            '       <form>',
            '           <div class="mb-3">',
            '               <textarea class="form-control" id="inputReview" rows="3"></textarea>',
            '           </div>',
            '           <div class="text-center">',
            '               <button type="button" class="btn btn-primary" onclick="addTanswer(${dto.sta_num})">작성 완료</button>',
            '               <button type="button" class="btn btn-danger" onclick="closeInfoWindow(${dto.sta_num})">닫기</button>',    
            '           </div>',
            '<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }">',
            '       </form>',
            '   </div>',
            '</div>'
        ].join('');

        var infowindow = new naver.maps.InfoWindow({
            content: contentString,
            maxWidth: 400,
            maxheight: 100,
            backgroundColor: "#FFFAFA",
            borderColor: "#ddd",
            borderWidth: 1,
            anchorSize: new naver.maps.Size(30, 30),
            anchorSkew: true,
            anchorColor: "#fff",
            disableAnchor: true,
            pixelOffset: new naver.maps.Point(20, -20)
        });
        
        naver.maps.Event.addListener(marker, "click", (function (infowindow, marker) {
            return function (e) {
                if (infowindow.getMap()) {
                    infowindow.close();
                } else {
                    // 모든 정보 창을 닫음
                    for (var i = 0; i < infowindows.length; i++) {
                        infowindows[i].close();
                    }
                    infowindow.open(map, marker);
                }
            };
        })(infowindow, marker));

        // 마커를 배열에 추가
        markers.push(marker);
        infowindows.push(infowindow);
    }
}
});

// 모든 마커 제거 함수
function removeMarkers() {
    for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(null);
    }

    // 배열 비우기
    markers = [];
}


	
    
</script>

</body>
</html>