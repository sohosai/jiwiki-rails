module ApplicationHelper
  def show_page_path(page)
    "/pages/#{page[:page_slug]}"
  end

  def edit_page_path(page)
    "/pages/#{page[:page_slug]}/versions/new"
  end

  def edit_page_meta_path(page)
    "/pages/#{page[:page_slug]}/edit"
  end

  def page_update_path(page)
    "/pages/#{page[:page_slug]}/"
  end

  def version_path(version)
    "/pages/#{version.page[:page_slug]}/versions/#{version[:id]}"
  end

  def versions_path
  end

  def utf8_enforcer_tag
    "".html_safe
  end
end
