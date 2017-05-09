$(document).ready(function() {
  var flash = $(".alert");
  flash.delay(5000).fadeOut('fast');
  flash.on('click', function() {
    flash.clearQueue();
    flash.fadeOut('fast');
  });
});