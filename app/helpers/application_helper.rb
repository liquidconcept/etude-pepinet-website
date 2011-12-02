module ApplicationHelper
  def link_to_with_active(name, options = {}, html_options = {}, &block)
    html_options[:class] = [html_options[:class], 'active'].join(' ') if current_page?(options)

    link_to(name, options, html_options, &block)
  end
end
