class SearchController < ApplicationController
  def index
    @query = params[:search]
    @page = (params["page"])? params["page"] : 1
    @sort_order = case @query["sort_order"]
      when "title_ascending"
        "title ASC"
      when "title_descending"
        "title DESC"
      when "oldest_first"
        "created_at ASC"
      else # when newest_first
        "created_at DESC"
      end
    @results = Version.order(@sort_order).full_text_search(@query[:keyword], allow_empty_search: true)
    unless @query[:tags].blank?
      target_tags = Page.split_tags @query[:tags]
      @results = @results.select do |ver|
        (target_tags - ver.page.tags).empty?
      end
    end
    @results = Kaminari.paginate_array(@results.group_by{ |ver| ver.page }.to_a).page @page
  end
end
