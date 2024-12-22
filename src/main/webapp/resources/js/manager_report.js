/**
 * 
 */
$(function(){
	//기본 화면 게시글 탭으로 고정하거나, url파라미터가 있으면 해당 값으로 로드
	const params = new URLSearchParams(window.location.search);
	const initialTab = params.get("reportTab") || "newReport";
	$("ul.tabnav li").removeClass("current");
	$("ul.tabnav li[data-tab='"+initialTab+"']").addClass("current");
	$("#tab-content").load("./"+initialTab+".jsp", function(){
		$(this).addClass("current");
	});
	
	
    //내 활동 메뉴 탭 누를 때
    $("ul.tabnav li").click(function () {
      let dataTab = $(this).attr("data-tab"); //클릭된 li의 'data-tab'을 가져옴
      
      $("ul.tabnav li").removeClass("current");
      $(".tab-content").removeClass("current");
      $(this).addClass("current");
      
      //가져온 data-tab을 기준으로 불러온 파일 설정
      let url="./"+dataTab+".jsp";

			console.log('[manager_report.js] tab open url : ', url);
			
      if(url){
    	  $("#tab-content").load(url, function(){
    		  $(this).addClass("current");
    		  //url 변경하고 기록하기
    		  history.pushState({reportTab:dataTab}, null, "?reportTab="+dataTab);
    	  });
      }
      
    });
    
    //뒤로가기, 앞으로 가기 할 때 사용되는
    $(window).on("popstate",function(e){
    	//현재 url의 tab매개변수를 읽어와서 해당 탭을 활성화하는 로직
    	let params = new URLSearchParams(window.location.search);
    	let tab = params.get("reportTab");
    	if(tab){
    		$("ul.tabnav li").removeClass("current");
    		$("ul.tabnav li[data-tab='"+tab+"']").addClass("current");
    		$("#tab-content").load("./"+tab+".jsp");
    	}else{
    		$("#tab-content").load("./newReport.jsp");
    	}
    });
});