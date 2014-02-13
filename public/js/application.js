$(document).ready(function() {

  $('#create').on("click", function(e){
    e.preventDefault();

    $.get('/create', function(html){
      console.log(html);
      $(html).appendTo('.container');
    })

  });


})
