function load_jquery_ui(){
  $(function(){ // JQuery UI settings
    $(".radioset").buttonset();
    $("input:submit, a.button, button").button();
    $(".checkbox").button();
  });
}
