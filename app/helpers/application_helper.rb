module ApplicationHelper
  def page_show_path(page)
    "/pages/#{page[:slug]}"
  end
end
