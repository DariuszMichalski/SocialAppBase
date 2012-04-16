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

function load_tiny_mce(){
  $(document).ready(function(){
    $('.tinymce').tinymce({
            script_url : "/tiny_mce/tiny_mce.js",
            // General options
            mode : "textareas",
            theme : "advanced",
            skin : "o2k7",
            skin_variant : "silver",
            width : '480',
            // Theme options
            theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,formatselect,|,removeformat,|,forecolor,backcolor",
            theme_advanced_buttons2 : "",
            theme_advanced_buttons3 : "",
            theme_advanced_buttons4 : "",
            theme_advanced_toolbar_location : "top",
            theme_advanced_toolbar_align : "left",
            theme_advanced_statusbar_location : "bottom",
            theme_advanced_resizing : true,

            // Example content CSS (should be your site CSS)
            content_css : "/tiny_mce/content.css",

            // Style formats
            style_formats : [
                    {title : 'Bold text', inline : 'b'},
                    {title : 'Example 1', inline : 'span', classes : 'example1'},
                    {title : 'Example 2', inline : 'span', classes : 'example2'},
            ],

            formats : {
                    alignleft : {selector : 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes : 'left'},
                    aligncenter : {selector : 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes : 'center'},
                    alignright : {selector : 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes : 'right'},
                    alignfull : {selector : 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes : 'full'},
                    bold : {inline : 'span', 'classes' : 'bold'},
                    italic : {inline : 'span', 'classes' : 'italic'},
                    underline : {inline : 'span', 'classes' : 'underline', exact : true},
                    strikethrough : {inline : 'del'},
                    customformat : {inline : 'span', styles : {color : '#00ff00', fontSize : '20px'}, attributes : {title : 'My custom format'}}
            }
    });
  });
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
