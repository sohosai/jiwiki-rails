class VersionsController < ApplicationController
  before_action :set_version, only: [:show]

  def show
  end

  def new
    @version = Version.new(page: Page.find_by(slug: params[:page_slug]))
  end

  def create
    @version = Version.new
    @version.body = params[:version][:body]
    @version.page = Page.find_by slug: params[:page_slug]
    @version.title = @version.page.title
    params[:slug] = params[:page_slug]
    if @version.save
      redirect_to controller: "pages", action: "show", slug: params[:page_slug]
    end
  end

  private
  def set_version
    @version = Version.find(params[:id])
  end
end
