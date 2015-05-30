class SearchController < ApplicationController
  def index
    if params[:search].empty? || params[:search][:keyword].empty?
      redirect_to Page
    else
      @query = params[:search]
      @sort_order = sort_order_to_query @query[:sort_order]
      @results = Version.order(@sort_order).latests.full_text_search(@query[:keyword]).preload(:page).merge(Page.not_deleted).page(params[:page])
    end
  end

  private
  def sort_order_to_query(sort_order)
    case sort_order
    when "title_ascending"
      "pages.title ASC"
    when "title_descending"
      "pages.title DESC"
    when "oldest_first"
      "pages.created_at ASC"
    else # when newest_first or default
      "versions.created_at DESC"
    end
  end
end
