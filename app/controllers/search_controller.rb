class SearchController < ApplicationController
  def index
    @query = params[:search]
    @page = (params["page"])? params["page"] : 1
    @pages = Page.desc(:updated_at).page @page
    @results = Version.full_text_search(@query[:keyword], allow_empty_search: true)
    unless @query[:tags].blank?
      target_tags = Page.split_tags @query[:tags]
      @results = @results.select do |ver|
        (target_tags - ver.page.tags).empty?
      end
    end
    @results = Kaminari.paginate_array(@results.group_by{ |ver| ver.page }.to_a).page @page
  end
end
