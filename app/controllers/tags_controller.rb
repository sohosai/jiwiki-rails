class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  # GET /tags
  # GET /tags.json
  def index
    @tags = ActsAsTaggableOn::Tag.all
  end

  # GET /tags/1
  # GET /tags/1.json
  def show
    @pages = @pages_with_tag.page params[:page]
  end

  def tag_cloud
    @tags = Page.tag_counts_on(:tags)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_tag
    @tag = params[:tag]
    @pages_with_tag = Page.tagged_with(@tag)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tag_params
    params[:tag]
  end
end
