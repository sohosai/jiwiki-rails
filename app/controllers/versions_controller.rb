class VersionsController < ApplicationController
  before_action :set_version, only: [:show]
  before_action :set_page, only: [:index]

  def index
    @versions = @page.versions.order('created_at DESC').page params['page']
  end

  def show
  end

  def new
    @version = Version.new(page: Page.find_by(page_slug: params[:page_slug]))
  end

  def create
    @version = Version.new(
      body: params[:version][:body],
      page: Page.find_by(page_slug: params[:page_slug])
    )
    if @version.save
      redirect_to controller: "pages", action: "show", slug: params[:page_slug]
    end
  end

  private
  def set_version
    @version = Version.find(params[:id])
  end

  def set_page
    @page = Page.find_by page_slug: params["page_slug"]
  end
end
