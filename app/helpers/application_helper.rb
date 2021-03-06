module ApplicationHelper
  def show_page_path(page)
    "/pages/#{page[:page_slug]}"
  end

  def fork_page_path(page)
    "/pages/new?forked_from=#{page.versions.first.id}"
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

  def page_versions_path(page)
    "/pages/#{page[:page_slug]}/versions"
  end

  def version_path(version)
    "/pages/#{version.page[:page_slug]}/versions/#{version[:id]}"
  end

  def versions_path
  end

  def utf8_enforcer_tag
    "".html_safe
  end

  def tags_path
    "/tags"
  end

  def show_tag_path(tag)
    "/tags/#{tag}"
  end

  def full_title(page_title)
    if page_title.empty?
      "JiWiki"
    else
      "#{page_title} - JiWiki"
    end
  end

  def full_time_ago(time)
    "#{time_ago_in_words time} ago (#{time.in_time_zone.strftime "%Y-%m-%d %a %H:%M:%S"})"
  end
end
