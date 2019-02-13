
let ready = () => {
  
  var $loader = $('.load_spinner')
  $loader.on('click', () => {
    console.log("ooo?")
    $loader.hide();
    $('.loader').show();
  })
}

$(document).on('turbolinks:load', ready);


