var sound_effect = document.getElementById("sound-effect");

$(function() {
  window.addEventListener("message", function(event) {
    var item = event.data;

    if (item !== undefined) {
      if (item.type == "ui") {
        if (item.display == true) {
          $('.main').attr('id', 'open')
          $('.logo').attr('id', 'logo')
          $('.logo2').attr('id', 'logo2')
          $('.box').attr('id', 'box')
          sound_effect.play()
        } else {
          $('.main').attr('id', 'openb')
          $('.logo').attr('id', 'logob')
          $('.logo2').attr('id', 'logo2b')
          $('.box').attr('id', 'boxb')
        }
      } else if (item.type == "update") {
        $("#iduser").html(item.my_id);
        $("#my_phonenumber").html(item.my_phonenmumber);
        $("#my_fullname").html(item.my_fullname);
        $("#my_job").html(item.my_job);
        /* $("#my_ping").html(item.my_ping + "ms"); */

        $("#players").html(item.players);
        $("#police").html(item.police);
        $("#ems").html(item.ems);
        $("#mc").html(item.mc);
        $("#chef").html(item.cf);
      }
    }
  });
});
