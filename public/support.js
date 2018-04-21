$(document).ready(function() {
  $(".play-trailer").click(function() {
    var idt = $(this).attr('id');
    toggleVideo("show",idt);
    $("."+idt).addClass("movie-view-trailer");
  });

  $(".back-btn").click(function() {
    var idt = $(this).attr('id');
    $("."+idt).removeClass("movie-view-trailer");
    console.log("back aate hue",idt);
    toggleVideo("hide",idt);
  });
});

function toggleVideo(state,idt) {
  // if state == 'hide', hide. Else: show video
  var div = document.getElementsByClassName(idt)[1];
  console.log(div);
  var iframe = div.getElementsByTagName("iframe")[0].contentWindow;
  console.log(iframe);
  div.style.display = state == "hide" ? "none" : "";
  func = state == "hide" ? "pauseVideo" : "playVideo";
  console.log("func",func);
  iframe.postMessage(
    '{"event":"command","func":"' + func + '","args":""}',
    "https://www.youtube.com/embed/sOEg_YZQsTI"
  );
}