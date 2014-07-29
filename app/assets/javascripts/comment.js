$(function(){
  if ($("#comments").length > 0) {
    setTimeout(YouTube.updateQueue, 5000);
  };
});

var Comment = {
  updateComments: function(){
    var latestCommentTime = {time: $(".comment li:last-child").attr("data-time")};
    $.ajax({
      url: "/retrieve_comments",
      method: "POST",
      data: latestCommentTime
    }).success(function(response){
      for (var i=0; i < response.content.length; i++) {
        var time = response.content[i].obj.created_at;
        var time_in_seconds = seconds(time);
        var appendLi = $('.comment').append('<li data-time="'+ time_in_seconds +'">' + response.content[i].obj.content + response.content[i].name + '</li>').fadeIn();
        if($(".comment li").size() >= 5) {
          $(".comment li:first-child").slideUp("slow").remove();
        }
        appendLi
      };
    }).fail(function(response){
      console.log("No Comments yet");
    });
  },

  updateQueue: function(){
    $.ajax({
      url: "/retrieve_queue",
      method: "GET"
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

var _runPolling = function() {
  Comment.updateComments();
  Comment.updateQueue();
};

$(document).ready(function(){
 _runPolling();

});
