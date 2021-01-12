$(document).on('turbolinks:load', function(){
  $('.minus').on('click', ()=>{
    var currentValue = parseInt($('.quantity-input').val());
    if (currentValue > 1) {
      currentValue -= 1;
    }
    $('.quantity-input').val(currentValue);
  })

  $('.plus').on('click', ()=>{
    var currentValue = parseInt($('.quantity-input').val());
    currentValue += 1;
    $('.quantity-input').val(currentValue);
  })

  $('#more_text').css('display', 'none');

  $('#btn_read_more').on('click', ()=>{
    $('#more_text').css('display', 'inline');
    $('#btn_read_more').css('display', 'none');
    $('#short_text').css('display', 'none');
  })

  $('.star-score').raty({
    path: '/assets/',
    readOnly: true,
    score: function() {
      return $(this).attr('data-score')
    }
  })

  $('#star-score').raty({
    path: '/assets/',
    scoreName: 'review[score]',
  })
})
