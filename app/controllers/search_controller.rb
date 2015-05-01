class SearchController < ApplicationController
  def index
    @query = params[:search]
    @page = (params["page"])? params["page"] : 1
    @sort_order = case @query["sort_order"]
      when "title_ascending"
        :title.asc
      when "title_descending"
        :title.desc
      when "oldest_first"
        :created_at.asc
      else # when newest_first
        :created_at.desc
      end
    @results = Version.full_text_search(@query[:keyword], allow_empty_search: true).order_by(@sort_order)
    unless @query[:tags].blank?
      target_tags = Page.split_tags @query[:tags]
      @results = @results.select do |ver|
        (target_tags - ver.page.tags).empty?
      end
    end
    @results = Kaminari.paginate_array(@results.group_by{ |ver| ver.page }.to_a).page @page
  end
end
