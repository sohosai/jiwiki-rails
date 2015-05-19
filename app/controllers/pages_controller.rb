# -*- coding: utf-8 -*-
class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  @@mkd_processor = Qiita::Markdown::Processor.new

  # GET /pages
  # GET /pages.json
  def index
    @table_view = (params["view"] == "table")
    @page = (params["page"])? params["page"] : 1
    @pages = Page.not.deleted.desc(:updated_at).page @page
  end

  def archived
    @page = (params["page"])? params["page"] : 1
    @pages = Page.deleted.desc(:updated_at).page @page
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new_with_body(params["page"])
    respond_to do |format|
      if @page.save
        format.html { redirect_to action: "show", slug: page_params[:page_slug] , notice: 'Page was successfully created.' }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    if page_params[:body]
      @page.versions << Version.new(body: page_params[:body], title: page_params[:title]).save
      page_params.delete :body
    end
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to controller: "pages", action: "show", slug: @page[:page_slug], notice: 'Page was successfully updated.' }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.delete
    respond_to do |format|
      format.html { redirect_to @page, notice: 'Page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def self.rendor_mkd(str)
    # preprocess embedded link between pages
    s = str.gsub(/\[\]\(:([^\/\?\s\+=]+)\)/m) do
      Page.slug_to_markdown_link $1
    end
    @@mkd_processor.call(s)[:output].to_s
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_page
    @page = Page.find_by(page_slug: params[:slug])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def page_params
    params.require(:page).permit(:page_slug, :title, :body, :tags)
  end
end
