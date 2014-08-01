var _run = function(videoId) {
  YouTube.loadPlayer(videoId);
}
var onYouTubePlayerReady = function(playerId) {
    ytplayer = document.getElementById("ytPlayer");
    ytplayer.addEventListener("onError", "onPlayerError");
  };

var YouTube = {
  loadVideo: function(videoId) {
    if (ytplayer) {
      ytplayer.loadVideoById(videoId);
    }
  },

  pauseVideo: function() {
    if (ytplayer) {
    ytplayer.pauseVideo();
    }
  },

  playVideo: function() {
    if (ytplayer) {
    ytplayer.playVideo();
    }
  },

  loadPlayer: function(videoID) {
    params = { allowScriptAccess: "always"};
    var atts = { id: "ytPlayer" };
    swfobject.embedSWF("http://www.youtube.com/v/" + videoID +
    "?controls=0&modestbranding=1&iv_load_policy=3version=3&enablejsapi=1&playerapiid=player1",
    "videoPlayer", "960", "540", "9", null, null, params, atts);
  },

  get_first_video: function() {
    $.ajax({
      url: "/retrieve_video_id",
      method: "GET",
      dataType: "jsonp",
      crossDomain: true
    }).success(function(response){
        _run(song_object.url.youtube_url);
        $("#videoDiv").slideDown();
      }).fail(function(response){
        console.log("Video Failed To Load");
    });
  },

  get_next_video: function() {
    $.ajax({
      url: "/retrieve_next_video_id",
      method: "GET",
      dataType: "json"
    }).success(function(response){
      YouTube.loadVideo(response.url.youtube_url);
    }).fail(function(response){
      console.log("Your video failed to load.");
    });
  }
};

var _initJquery = function() {
  $('.queue li').hide();
  $('.queue li:lt(5)').slideDown("slow");

  $(".button").hover(function(){
    $(this).animate({backgroundColor: "black"}, 200);
  }, function(){
    $(this).animate({backgroundColor: "#666666"}, 200);
  });
}

$(document).ready(function(){
  _initJquery();
  _run();
  YouTube.get_first_video();
  $("#start").hide();
  $(".queue li").eq(0).animate({color: "green"}, 700);
  $(".queue li").eq(1).delay(180).animate({color: "red"}, 700);


  $("#play").click(function(e){
    e.prevendDefault();
    YouTube.playVideo();
  });

  $("#pause").click(function(e){
    e.preventDefault();
    YouTube.pauseVideo();
  });

  $("body").on("click", "#next", function(e){
    e.preventDefault();
    YouTube.get_next_video();
    $(".queue li:first-child").slideUp("slow", function(){
      $(".queue li:first-child").remove();
      $(".queue li").eq(0).animate({color: "green"}, 700);
      $(".queue li").eq(1).delay(180).animate({color: "red"}, 700);
      $(".queue li").eq(4).slideDown("slow").show();
    });
  });
});
