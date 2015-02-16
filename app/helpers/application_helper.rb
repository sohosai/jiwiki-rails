module ApplicationHelper
  def show_page_path(page)
    "/pages/#{page[:slug]}"
  end

  def edit_page_path(page)
    "/pages/#{page[:slug]}/versions/new"
  end

  def versions_path
  end

  def version_path(version)
    "/pages/#{version.page[:slug]}/versions/#{version[:id]}"
  end
end
