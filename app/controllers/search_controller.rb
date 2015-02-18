class SearchController < ApplicationController
  def index
    @query = params[:search]
    @results =
      if @query[:keyword].blank?
        Version.all
      else
        Version.full_text_search(@query[:keyword])
      end
    unless @query[:tags].blank?
      target_tags = Page.split_tags @query[:tags]
      @results = @results.select do |ver|
        (target_tags - ver.page.tags).empty?
      end
    end
    @results = @results.group_by do |ver|
      ver.page
    end
  end
end
