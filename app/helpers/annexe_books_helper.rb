module AnnexeBooksHelper
  def ensure_links_contain_scheme(link)
    return if link.nil?

    link.present? && link !~ %r{^\w+://} ? 'http://' + link : link
  end
end