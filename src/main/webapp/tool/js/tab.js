/**
 * 
 */
function openTab(evt, tabName_tool) {
    var i, tabcontent, tablinks;

    // 저장된 스크롤 위치로 이동
    var LoadName = tabName_tool + "-scroll";
    var scrollPosition = localStorage.getItem(LoadName);

    tabcontent = document.getElementsByClassName("tab-content");

    for (i = 0; i < tabcontent.length; i++) {
      // 현재 탭의 스크롤 위치 저장
      var name = tabcontent[i].id + "-scroll";
      localStorage.setItem(name, window.scrollY);
      console.log("save : " + name + " : " + window.scrollY);

      tabcontent[i].classList.remove("active");
    }

    tablinks = document.getElementsByClassName("tab-link");

    for (i = 0; i < tablinks.length; i++) {
      tablinks[i].className = tablinks[i].className.replace(" active", "");
    }

    document.getElementById(tabName_tool).classList.add("active");

    evt.currentTarget.className += " active";

    console.log("load : " + LoadName + " : " + scrollPosition);
    if (0 < scrollPosition) {
      window.scrollTo(0, scrollPosition);
    }
}

// Set default tab to be displayed
document.getElementById("Tab1").classList.add("active");


	  
	  
	  