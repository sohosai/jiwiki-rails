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

    @results = Version.
      full_text_search(@query[:keyword], allow_empty_search: true).
      order_by(@sort_order)

    @results = @results.group_by{ |ver| ver.page }

    unless @query[:tags].blank?
      target_tags = Page.split_tags @query[:tags]
      @results = @results.select do |p, v|
        (target_tags - p.tags).empty?
      end
    end

    case @query["archive"]
    when "not_archived"
      @results = @results.select do |k, v|
        ! k.deleted?
      end
    when "archived"
      @results = @results.select do |k, v|
        k.deleted?
      end
    end

    @results = Kaminari.paginate_array(@results.to_a).page @page
  end
end
