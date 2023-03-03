﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿/**
 *작성자 : 남재욱, 이효원
 *작성일 : 2022.12.13
 *용도 : 검색어 없으면 alert창 띄우는 스크립트
 */
$(document).ready(function(){
	var searchList = $("#searchList");
	$("#searchList button").on("click", function(e){

	if(!searchList.find("input[name='keyword']").val()){
		alert("검색어를 입력하세요");
		return false;
	}

	searchList.submit();
	});

});