
var Comment = {
  updateComments: function(){
    var latestCommentTime = {time: $(".comment li:last-child").attr("data-time")};
    $.ajax({
      url: "/retrieve_comments",
      method: "GET",
      dataType: "jsonp",
      data: latestCommentTime, 
      crossDomain: true
    }).success(function(response){
      for (var i=0; i < response.content.length; i++) {
        var time = response.content[i].obj.created_at;
        var time_in_seconds = seconds(time);
        var appendLi = $('.comment').append('<li data-time="'+ time_in_seconds +'">' + response.content[i].obj.content + response.content[i].name + '</li>').fadeIn();
        if($(".comment li").size() >= 5) {
          $(".comment li:first-child").slideUp("slow").remove();
        }
        appendLi;
      }
    }).fail(function(response){
      console.log("No Comments yet");
    });
  },

  updateQueue: function(){
    $.ajax({
      url: "/retrieve_queue",
      method: "GET",
      dataType: "jsonp",
      crossDomain: true
    }).success(function(response){
      for (var i=0; i < response.queue.length; i++) {
        var comment = '<li>' + response.queue[i].name + '</li>';
        if ($('.queue li:contains("'+ response.queue[i].name +'")').length < 1) {
          $('.queue').append(comment);
        }
      }
    }).fail(function(response){
      console.log("FAIL");
    });
  }
};

var polling = function(){
  if ($("#comments").length > 0) {
    setTimeout(Comment.updateQueue, 5000);
    setTimeout(Comment.updateComments, 5000);
  }
};

var _runPolling = function() {
  polling();
};

$(document).ready(function(){
 $("#start").on("click", function(e){
  e.preventDefault();
  _runPolling();
  });
});
