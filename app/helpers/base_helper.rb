module BaseHelper
  def back_button(url, klass='')
    link_to("<button id='back'>#{t('back')}</button>".html_safe, url, :class => klass) +
    javascript_tag('$(function() { $("#back").button({icons: { primary: "ui-icon-triangle-1-w" }, text: false }) });')
  end
  def back_label_button(url, label, klass='')
    link_to("<button id='back'>#{label}</button>".html_safe, url, :class => klass) +
    javascript_tag('$(function() { $("#back").button({icons: { primary: "ui-icon-triangle-1-w" }, text: true }) });')
  end

  # ------------------ Nested attributes / Nested models ------------------ #
  def link_to_remove_fields(name, f, klas=nil)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this); photo_counter = photo_counter - 1; watch_photo_counter();", :class=>klas)
  end

  def link_to_add_fields(name, f, association, klas=nil)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(f.object.class.to_s.pluralize.downcase + "/" + association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \'#{association}\', \'#{escape_javascript(fields)}\'); photo_counter = photo_counter + 1; watch_photo_counter();",:class=>klas)
  end
  # ---------------------------------------------------------------------- #

  def confirmation_dialog(confirm_text, cancel_text, dom)
    "function confirmation_dialog(pos_y, url){
      $( '#{dom}' ).dialog({
        resizable: false, height:140, width:320, modal: false, position: [100,pos_y],
        buttons: {
          #{confirm_text} : function() {
            $.post(url, function() { $('#{dom}').dialog( 'close' ); });
          },
          #{cancel_text} : function() { $( this ).dialog( 'close' ); }
        }
      });
    }
    "
  end

  def normal_page_view?
    # sprawdza czy strona ktora sie wyswietla to strona dla zwyklego uzytkownika (a nie podglad strony administratora)
    (controller.controller_name == "pages" and (controller.action_name == "show" or controller.action_name == "update")) ? true : false
    # action "update" dla zmian z poziomu administratora (gazetka / oferta)
  end

  def open_specific_tab
    # otwiera konkretny tab ustawien administratora na podstawie parametru 'tab' z requestu GET
    "selected_tab=#{params[:tab]}" if params[:tab].present?
  end
end