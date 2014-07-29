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
  loadPlayer: function(videoID) {
    params = { allowScriptAccess: "always"};
    var atts = { id: "ytPlayer" };
    swfobject.embedSWF("http://www.youtube.com/v/" + videoID +
    "?version=3&enablejsapi=1&playerapiid=player1",
    "videoPlayer", "960", "540", "9", null, null, params, atts);
  },
  get_first_video: function() {
    $.ajax({
      url: "/retrieve_video_id",
      method: "GET",
      dataType: "json"
    }).success(function(response){
        _run(response.url.youtube_url);
        $("#videoDiv").slideDown();
      }).fail(function(response){
        console.log("Video Failed To Load");
    });
  },

  get_next_video: function() {
    $.ajax({
      url: "/retrieve_video_id",
      method: "GET",
      dataType: "json"
    }).success(function(response){
      console.log(response.url)
      YouTube.loadVideo(response.url.youtube_url);
    }).fail(function(response){
      console.log("Your video failed to load.");
    });
  }
};

$(document).ready(function(){
  $("#videoPlayer").hide();
  $("#start").on("click", function(e){
    e.preventDefault();
    $("#start").fadeOut();
    YouTube.get_first_video();
  });
  $("#next").on("click", function(e){
    e.preventDefault();
    YouTube.get_next_video();
  });
});
