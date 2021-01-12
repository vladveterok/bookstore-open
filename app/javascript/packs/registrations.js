document.addEventListener("turbolinks:load", function() {
  $('#remove-account').on('click', function() {
     if($(this).is(':checked')) {
       $('#remove-button').attr('class', 'btn btn-default mb-20');
       return;
     }
     $('#remove-button').attr('class', 'btn disabled mb-20');
  });
});
