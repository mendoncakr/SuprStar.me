
var seconds = function(date) {
 return new Date(date).getTime() / 1000;
}

var Comment = {
  
  updateComments: function(){
    var latestCommentTime = {time: $(".comment li:last-child").attr("data-time")};
    if (latestCommentTime.time === undefined) {
      var latestCommentTime = {time: 0};
    }
    $.ajax({
      url: "/retrieve_comments",
      method: "GET",
      data: latestCommentTime
    }).success(function(response){
      var meterScore = response.sentimental_score;
      if (meterScore !== 0) {
        // Add number to sum (Make sure sum is not reset!)
        meterSum += meterScore;
        var meterValue = meterSum + 50 / response.comment_size;
        // Pass integer to divide sum by and append sum.
        $("#booMeter").attr("value", meterValue);
      }
      for (var i=0; i < response.content.length; i++) {
        var time = response.content[i].obj.created_at;
        var time_in_seconds = seconds(time);
        if($(".comment li").size() >= 5) {
          $(".comment li:first-child").slideUp("slow", function(){
            $(".comment li:first-child").remove();
          });
        }
        $('.comment').append('<li data-time="'+ time_in_seconds +'">' + response.content[i].name +"- "+ response.content[i].obj.content + '</li>');
      };
    }).fail(function(response){
      console.log("Either the UL does not contain comments or there is an error with your aJax request.");
    });
  },

  updateQueue: function(){
    $.ajax({
      url: "/retrieve_queue",
      method: "GET"
    }).success(function(response){     
      for (var i=0; i < response.queue.length; i++) {
        var song_title = response.queue[i].name;        
        var itemQueue = '<li id="'+ response.queue[i].id +'">' + song_title + '</li>';
        var howManyFound = $('.queue').find("li[id='"+ response.queue[i].id +"']").size();
        if ( howManyFound < 1) {
          if ($('.queue li').size() > 5) {
            $(".queue").append(itemQueue).hide(); // *****note
          } else {
          $(".queue").append(itemQueue);
          }
        }
      }
    $(".queue li").hide(); 
    $(".queue li:lt(5)").show();
    }).fail(function(response){
      console.log("FAILED to updateQueue");
    });
  }
};

var _runPolling = function() {
  setTimeout(function(){
    Comment.updateComments();
    Comment.updateQueue();
    _runPolling();
  }, 5000);
};

$(document).ready(function(){
    meterSum = 0;
    _runPolling();
});
