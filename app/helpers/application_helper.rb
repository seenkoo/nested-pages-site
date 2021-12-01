module ApplicationHelper
  def nested_pages(pages)
    return '' unless pages.present?
    content_tag(:ul) do
      pages.map do |page, sub_pages|
        page_link = link_to page.name, page_path(page)
        content_tag(:li, page_link + nested_pages(sub_pages).html_safe)
      end.join.html_safe
    end
  end
end
