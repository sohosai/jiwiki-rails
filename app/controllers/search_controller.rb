class SearchController < ApplicationController
  def index
    if params[:search].empty? || params[:search][:keyword].empty?
      redirect_to Page
    else
      @query = params[:search]
      @sort_order = Page.sort_order_to_query @query[:sort_order]
      @results = Version.order(@sort_order).latests.full_text_search(@query[:keyword]).includes(:page).eager_load(:page).page params[:page]
    end
  end
end
