<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>함께해요 중앙😊</title>
	
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="resources/css/font.css" />

</head>
<style>
.card-body {
	background-color : #F8F9FA;
}
/* 호버 효과 */
.card:hover {
    /* 들썩이는 애니메이션 적용 */
    cursor : pointer;
    animation: bounce 0.3s ease 1;
}

/* 들썩이는 애니메이션 키프레임 정의 */
@keyframes bounce {
    0%, 20%, 50%, 80%, 100% {
        transform: translateY(0);
    }
    40% {
        transform: translateY(-10px);
    }
    60% {
        transform: translateY(-5px);
    }
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/inc/header.jsp" %>
    
    <div class="container-fluid p-0">
  		<img class="img-fluid w-100" src="resources/img/main3.jpg">
	</div>

	<div class="container mt-4">
        <div class="row">
        
            <!-- 첫 번째 카드 -->
            <div class="col-md-4 mb-4" onclick="redirectToLink('https://www.megabox.co.kr/')">
			    <div class="card h-100 border rounded shadow">
			        <img src="resources/img/mega.png" class="card-img-top" alt="메가박스">
			        <div class="card-body">
			        	<hr>
			            <h5 class="card-title text-center mb-3" style="font-size: 1.5rem; color: black; font-weight: bold;">메가박스 중앙</h5>
			            <p class="card-text text-muted">중앙그룹 계열사 중 하나인 콘텐트리중앙 산하의 자회사 '메가박스중앙(주)'에서 운영하는 멀티플렉스 영화관. 합병 전 씨너스의 경우 전국 극장주 연합 체인 브랜드다.
본사는 서울특별시 성동구 왕십리로 50 메가박스 스퀘어에 있다. 같은 건물에 메가박스 성수도 있다.</p>
			        </div>
			    </div>
			</div>

            <!-- 두 번째 카드 -->
            <div class="col-md-4 mb-4" onclick="redirectToLink('https://phoenixhnr.co.kr/page/main')">
			    <div class="card h-100 border rounded shadow">
			        <img src="resources/img/condo.png" class="card-img-top" alt="휘닉스">
			        <div class="card-body">
			        	<hr>
			            <h5 class="card-title text-center mb-3" style="font-size: 1.5rem; color: black; font-weight: bold;">휘닉스 중앙</h5>
			            <p class="card-text text-muted">중앙그룹 계열사인 중앙리조트투자(주)의 자회사이며, 사명은 휘닉스중앙이다. 휘닉스 평창과 휘닉스 제주로 나누어 있다. 휘닉스 평창은 여의도 면적의 두 배가 넘는 660만㎡(약 200만평)의 부지에 낮은 기온, 많은 적설량, 국내 최고의 제설 능력 및 설질로 이름이 높다. 
			            휘닉스 제주는 제주특별자치도 서귀포시 성산읍 섭지코지로 107에 있다. 쉽게 말해, 그 유명한 섭지코지 내에 있다.</p>
			        </div>
			    </div>
			</div>

            <!-- 세 번째 카드 -->
            <div class="col-md-4 mb-4" onclick="redirectToLink('https://www.worldplaytime.com/KO/index.php')">
			    <div class="card h-100 border rounded shadow">
			        <img src="resources/img/play.png" class="card-img-top" alt="플레이타임">
			        <div class="card-body">
			        	<hr>
			            <h5 class="card-title text-center mb-3" style="font-size: 1.5rem; color: black; font-weight: bold;">플레이타임 중앙</h5>
			            <p class="card-text text-muted">플레이타임중앙은 1993년 설립, 1994년 로컬키즈카페로 출범한 뒤 30년간 어린이들의 놀이에 집중해 왔으며, 국내 200여 개 및 해외 20여개 매장을 보유하고 있습니다.</p>
			        </div>
			    </div>
			</div>
        </div>
    </div>
    
    <div class="container mt-4">
        <div class="row">
            
            <!-- 네 번째 카드 -->
            <div class="col-md-4 mb-4" onclick="redirectToLink('https://jtbc.co.kr/')">
			    <div class="card h-100 border rounded shadow">
			        <img src="resources/img/jtbc.png" class="card-img-top" alt="jtbc">
			        <div class="card-body">
			        	<hr>
			            <h5 class="card-title text-center mb-3" style="font-size: 1.5rem; color: black; font-weight: bold;">JTBC</h5>
			            <p class="card-text text-muted">중앙그룹 계열의 종합편성채널로 2011년 12월 1일부터 개국했다. 중앙그룹이 삼성그룹에서 분리하기 전 인 1964년 TBC(동양방송)가 개국하였다가 1980년 언론통폐합으로 사라진 후 31년 만에 종합편성채널로 방송에 재진출한 채널이다. 동양방송의 정신적인 후신.</p>
			        </div>
			    </div>
			</div>

            <!-- 다섯 번째 카드 -->
            <div class="col-md-4 mb-4" onclick="redirectToLink('https://www.joongang.co.kr/')">
			    <div class="card h-100 border rounded shadow">
			        <img src="resources/img/joongang.png" class="card-img-top" alt="중앙일보">
			        <div class="card-body">
			        	<hr>
			            <h5 class="card-title text-center mb-3" style="font-size: 1.5rem; color: black; font-weight: bold;">중앙일보</h5>
			            <p class="card-text text-muted">1965년 창간 당시에는 삼성그룹의 계열사로 출범하였으며, 1999년에 삼성그룹으로부터 계열 분리되었다. 현재는 중앙그룹 계열 중앙일보(주)에서 발행하며, 본사는 서울특별시 마포구 상암산로 48-6 (상암동)에 입주해 있다. 원래는 사명이 '(주)중앙일보'였으나 2018년 3월에 '중앙일보(주)'로 변경하였다.</p>
			        </div>
			    </div>
			</div>

            <!-- 여섯 번째 카드 -->
            <div class="col-md-4 mb-4" onclick="redirectToLink('https://stemcoffee.com/')">
			    <div class="card h-100 border rounded shadow">
			        <img src="resources/img/stem.png" class="card-img-top" alt="스템커피">
			        <div class="card-body">
			        	<hr>
			            <h5 class="card-title text-center mb-3" style="font-size: 1.5rem; color: black; font-weight: bold;">스템커피</h5>
			            <p class="card-text text-muted">중앙그룹 내의 카페로써 젊은 연인들의 데이트 장소로도 유명한 스템커피는 초록초록한 분위기에 깔끔한 카페로, 여러 지점으로 영역을 확대하고 있다.</p>
			        </div>
			    </div>
			</div>
        </div>
    </div>
    
    <div class="container mt-4">
        <div class="row">
            
            <!-- 일곱 번째 카드 -->
            <div class="col-md-4 mb-4" onclick="redirectToLink('https://www.contentreej.com/joins')">
			    <div class="card h-100 border rounded shadow">
			        <img src="resources/img/contentree.png" class="card-img-top" alt="콘텐트리중앙">
			        <div class="card-body">
			        	<hr>
			            <h5 class="card-title text-center mb-3" style="font-size: 1.5rem; color: black; font-weight: bold;">콘텐트리중앙</h5>
			            <p class="card-text text-muted">IT Leader & Value Creator IT 전문성과 기술력을 바탕으로 고객 비즈니스 성공과 미래를 그리며 성장과 혁신을 돕는 최고의 파트너입니다.
			            <br>현재 IT Service, Infra Service, Media Operation Service 가 있다.</p>
			        </div>
			    </div>
			</div>

            <!-- 여덟 번째 카드 -->
            <div class="col-md-4 mb-4" onclick="redirectToLink('https://www.contentreej.com/hll/')">
			    <div class="card h-100 border rounded shadow">
			        <img src="resources/img/hll.png" class="card-img-top" alt="HLL">
			        <div class="card-body">
			        	<hr>
			            <h5 class="card-title text-center mb-3" style="font-size: 1.5rem; color: black; font-weight: bold;">HLL</h5>
			            <p class="card-text text-muted">HLL은 국내 1위 매거진, 라이브 커머스 및 연예 매니지먼트 사업을 겸비한
Consumer Trend Leading Company<br>현재 Cosmopolitan, Elle, Harper's Bazaar, Esquire 가 있다.</p>
			        </div>
			    </div>
			</div>

            <!-- 아홉 번째 카드 -->
            <div class="col-md-4 mb-4" onclick="redirectToLink('https://www.contentreej.com/sll/')">
			    <div class="card h-100 border rounded shadow">
			        <img src="resources/img/sll.png" class="card-img-top" alt="SLL">
			        <div class="card-body">
			        	<hr>
			            <h5 class="card-title text-center mb-3" style="font-size: 1.5rem; color: black; font-weight: bold;">SLL</h5>
			            <p class="card-text text-muted">World's Leading Creative Studio, SLL은 이야기를 만드는 사람들의 집단으로, PRODUCTION, DISTRIBUTION, LICENSE를 제공하고 있다.
			            <br>재벌집 막내아들, 범죄도시, 수리남, 종이의 집, 스카이캐슬 등 다양한 콘텐츠를 선보이고 있다.</p>
			        </div>
			    </div>
			</div>
        </div>
    </div>
    
    <%@ include file="/WEB-INF/views/inc/footer.jsp" %>

    <!-- 부트스트랩 JS 및 Popper.js (햄버거 아이콘을 사용하기 위함) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
//클릭 시 -> 링크로 이동
function redirectToLink(link) {
    
    window.location.href = link;
}
</script>
</body>
</html>