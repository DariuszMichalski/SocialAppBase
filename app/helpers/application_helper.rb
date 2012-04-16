module ApplicationHelper
  def back_button(url, klass='')
    link_to("<button id='back'>#{t('back')}</button>".html_safe, url, :class => klass) +
    javascript_tag('$(function() { $("#back").button({icons: { primary: "ui-icon-triangle-1-w" }, text: false }) });')
  end
  def back_label_button(url, label, klass='')
    link_to("<button id='back'>#{label}</button>".html_safe, url, :class => klass) +
    javascript_tag('$(function() { $("#back").button({icons: { primary: "ui-icon-triangle-1-w" }, text: true }) });')
  end
end
