// 다중 셀렉트 박스
function doChange(srcE, targetId){
    var val = srcE.options[srcE.selectedIndex].value;
    var targetE = document.getElementById(targetId);
    removeAll(targetE);
    
    switch(val) {
    // 서울
    case "서울":
       addOption('강남구', targetE);
       addOption('강동구', targetE);
       addOption('강북구', targetE);
       addOption('강서구', targetE);
       addOption('관악구', targetE);
       addOption('광진구', targetE);
       addOption('구로구', targetE);
       addOption('금천구', targetE);
       addOption('노원구', targetE);
       addOption('도봉구', targetE);
       addOption('동대문구', targetE);
       addOption('동작구', targetE);
       addOption('마포구', targetE);
       addOption('서대문구', targetE);
       addOption('서초구', targetE);
       addOption('성동구', targetE);
       addOption('성북구', targetE);
       addOption('송파구', targetE);
       addOption('양천구', targetE);
       addOption('영등포구', targetE);
       addOption('용산구', targetE);
       addOption('은평구', targetE);
       addOption('종로구', targetE);
       addOption('중구', targetE);
       addOption('중랑구', targetE);
       break;
    
    // 경기
    case "경기":
       addOption('가평군', targetE);
       addOption('고양시', targetE);
       addOption('과천시', targetE);
       addOption('광명시', targetE);
       addOption('광주시', targetE);
       addOption('구리시', targetE);
       addOption('군포시', targetE);
       addOption('김포시', targetE);
       addOption('남양주시', targetE);
       addOption('동두천시', targetE);
       addOption('부천시', targetE);
       addOption('성남시', targetE);
       addOption('수원시', targetE);
       addOption('시흥시', targetE);
       addOption('안산시', targetE);
       addOption('안성시', targetE);
       addOption('안양시', targetE);
       addOption('양주시', targetE);
       addOption('양평군', targetE);
       addOption('여주군', targetE);
       addOption('오산시', targetE);
       addOption('용인시', targetE);
       addOption('의왕시', targetE);
       addOption('의정부시', targetE);
       addOption('이천시', targetE);
       addOption('파주시', targetE);
       addOption('평택시', targetE);
       addOption('포천시', targetE);
       addOption('하남시', targetE);
       addOption('화성시', targetE);
       break;
    
    // 인천
    case "인천":
       addOption('강화군', targetE);
       addOption('계양구', targetE);
       addOption('남구', targetE);
       addOption('남동구', targetE);
       addOption('동구', targetE);
       addOption('부평구', targetE);
       addOption('서구', targetE);
       addOption('연수구', targetE);
       addOption('옹진군', targetE);
       addOption('중구', targetE);
       break;
       
    // 강원
    case "강원":
       addOption('강릉시', targetE);
       addOption('고성군', targetE);
       addOption('동해시', targetE);
       addOption('삼척시', targetE);
       addOption('속초시', targetE);
       addOption('양구군', targetE);
       addOption('양양군', targetE);
       addOption('영월군', targetE);
       addOption('원주시', targetE);
       addOption('인제군', targetE);
       addOption('정선군', targetE);
       addOption('칠원군', targetE);
       addOption('춘천시', targetE);
       addOption('태백시', targetE);
       addOption('평창군', targetE);
       addOption('홍천군', targetE);
       addOption('화천군', targetE);
       addOption('횡성군', targetE);
       break;
       
    // 부산
    case "부산":
       addOption('강서구', targetE);
       addOption('금정구', targetE);
       addOption('기장군', targetE);
       addOption('남구', targetE);
       addOption('동구', targetE);
       addOption('동래구', targetE);
       addOption('부산진구', targetE);
       addOption('북구', targetE);
       addOption('사상구', targetE);
       addOption('사하구', targetE);
       addOption('서구', targetE);
       addOption('수영구', targetE);
       addOption('연제구', targetE);
       addOption('영도구', targetE);
       addOption('중구', targetE);
       addOption('해운대구', targetE);
       break;
       
    // 경남
    case "경남":
       addOption('거제시', targetE);
       addOption('거창군', targetE);
       addOption('고성군', targetE);
       addOption('김해시', targetE);
       addOption('남해군', targetE);
       addOption('밀양시', targetE);
       addOption('사천시', targetE);
       addOption('사천시', targetE);
       addOption('산청군', targetE);
       addOption('양산시', targetE);
       addOption('의령군', targetE);
       addOption('진주시', targetE);
       addOption('창녕군', targetE);
       addOption('창원시', targetE);
       addOption('통영시', targetE);
       addOption('하동군', targetE);
       addOption('함안군', targetE);
       addOption('함양군', targetE);
       addOption('합천군', targetE);
       break;
       
    // 대구
    case "대구":
       addOption('남구', targetE);
       addOption('달서구', targetE);
       addOption('달성군', targetE);
       addOption('동구', targetE);
       addOption('북구', targetE);
       addOption('서구', targetE);
       addOption('수성구', targetE);
       addOption('중구', targetE);
       break;
       
    // 경북
    case "경북":
       addOption('경산시', targetE);
       addOption('경주시', targetE);
       addOption('고령군', targetE);
       addOption('구미시', targetE);
       addOption('군위군', targetE);
       addOption('김천시', targetE);
       addOption('문경시', targetE);
       addOption('봉화군', targetE);
       addOption('상주시', targetE);
       addOption('성주군', targetE);
       addOption('안동시', targetE);
       addOption('영덕군', targetE);
       addOption('영양군', targetE);
       addOption('영주시', targetE);
       addOption('영천시', targetE);
       addOption('예천군', targetE);
       addOption('울릉군', targetE);
       addOption('울진군', targetE);
       addOption('의성군', targetE);
       addOption('청도군', targetE);
       addOption('청송군', targetE);
       addOption('칠곡군', targetE);
       addOption('포항시', targetE);
       break;
       
    // 울산
    case "울산":
       addOption('남구', targetE);
       addOption('동구', targetE);
       addOption('북구', targetE);
       addOption('울주군', targetE);
       addOption('중구', targetE);
       break;
       
    // 대전
    case "대전":
       addOption('대덕구', targetE);
       addOption('동구', targetE);
       addOption('서구', targetE);
       addOption('유성구', targetE);
       addOption('중구', targetE);
       break;
    
    // 충남
    case "충남":
       addOption('계룡시', targetE);
       addOption('공주시', targetE);
       addOption('금산군', targetE);
       addOption('논산시', targetE);
       addOption('당진군', targetE);
       addOption('보령시', targetE);
       addOption('부여군', targetE);
       addOption('서산시', targetE);
       addOption('서천군', targetE);
       addOption('아산시', targetE);
       addOption('연기군', targetE);
       addOption('예산군', targetE);
       addOption('천안시', targetE);
       addOption('청양군', targetE);
       addOption('태안군', targetE);
       addOption('홍성군', targetE);
       break;
       
    // 충북
    case "충북":
       addOption('괴산군', targetE);
       addOption('단양군', targetE);
       addOption('보은군', targetE);
       addOption('영동군', targetE);
       addOption('옥천군', targetE);
       addOption('음성군', targetE);
       addOption('제천시', targetE);
       addOption('증평군', targetE);
       addOption('진천군', targetE);
       addOption('청원군', targetE);
       addOption('청주시', targetE);
       addOption('충주시', targetE);
       break;
       
    // 광주
    case "광주":
       addOption('광산구', targetE);
       addOption('남구', targetE);
       addOption('동구', targetE);
       addOption('북구', targetE);
       addOption('서구', targetE);
       break;
       
    // 전남
    case "전남":
       addOption('강진군', targetE);
       addOption('고흥군', targetE);
       addOption('곡성군', targetE);
       addOption('광양시', targetE);
       addOption('구례군', targetE);
       addOption('나주시', targetE);
       addOption('담양군', targetE);
       addOption('목포시', targetE);
       addOption('무안군', targetE);
       addOption('보성군', targetE);
       addOption('순천시', targetE);
       addOption('신안군', targetE);
       addOption('여수시', targetE);
       addOption('영광군', targetE);
       addOption('영암군', targetE);
       addOption('완도군', targetE);
       addOption('장성군', targetE);
       addOption('장흥군', targetE);
       addOption('진도군', targetE);
       addOption('함평군', targetE);
       addOption('해남군', targetE);
       addOption('화순군', targetE);
       break;
       
   // 전북
    case "전북":
       addOption('고창군', targetE);
       addOption('군산시', targetE);
       addOption('김제시', targetE);
       addOption('남원시', targetE);
       addOption('무주군', targetE);
       addOption('부안군', targetE);
       addOption('순창군', targetE);
       addOption('완주군', targetE);
       addOption('익산시', targetE);
       addOption('임실군', targetE);
       addOption('장수군', targetE);
       addOption('전주시', targetE);
       addOption('정읍시', targetE);
       addOption('진안군', targetE);
       break;
       
    // 제주
    case "제주":
       addOption('서귀포시', targetE);
       addOption('제주시', targetE);
       break;
    }
}

function addOption(value, e){
    var o = new Option(value);
    try{
        e.add(o);
    }catch(ee){
        e.add(o, null);
    }
}

function removeAll(e){
    for(var i = 0, limit = e.options.length; i < limit - 1; ++i){
        e.remove(1);
    }
}