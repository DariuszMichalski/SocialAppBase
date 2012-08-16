// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//
//function set_up_dialog(header) {
//$( "#dialog" ).dialog({
//resizable: false,
//title: header,
//position: [100, 100],
//modal: true,
//autoOpen: false,
//width: 350,
//height: 80
//});
//}
//

function load_jquery_ui(){
  $(function(){ // JQuery UI settings
    if ( typeof selected_tab != 'undefined' ) { $( "#tabs" ).tabs({ selected: selected_tab }); }
    $("input:submit, a.button, button").button();
    $(".checkbox").button();
  });
}

function scroll_to_top(){
  $(document).ready(function(){ FB.Canvas. scrollTo(0,0); });
}

function sortable_it(sid, sortable_url, handler){ // JQuery UI settings
  if (handler === undefined) { handler = '' }
  $("#" + sid).sortable({
    items: 'li',
    handle: handler,
    revert: true,
    update: function() {
      $.ajax({
        type: 'post',
      data: $('#' + sid).sortable('serialize'),
      dataType: 'script',
      url: sortable_url
      })
    }
  });
  $( "ul, li" ).disableSelection();
}

function watch_photo_counter(){
  if (photo_counter >= 3)
    $('.add_fields').hide();
  else
    $('.add_fields').show();
}

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
    $(link).parent().before(content.replace(regexp, new_id));
}

function is_browser_incompatibile(){
  if ($.browser.msie  && (parseInt($.browser.version, 10) === 7 || parseInt($.browser.version, 10) === 6)) {
    return true;
  } else {
    return false;
  }
}
//

function send_form_with_ajax(form_id) {
    the_form = $(form_id);
    serialized = the_form.serialize();
    $.ajax({
      url: the_form.attr('action'),
      data: serialized,
      async: true,
      type: the_form.attr('method'),
      dataType: 'script'
    });
} 
