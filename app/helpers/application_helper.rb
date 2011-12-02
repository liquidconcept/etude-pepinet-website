module ApplicationHelper
  def link_to_with_active(name, path = '/', html_options = {}, &block)
    html_options[:class] = [html_options[:class], 'active'].join(' ') if path.split('/')[1] == request.path.split('/')[1]

    link_to(name, path, html_options, &block)
  end
end
