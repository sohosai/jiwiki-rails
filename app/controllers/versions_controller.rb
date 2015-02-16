class VersionsController < ApplicationController
  before_action :set_version, only: [:show]

  def show
  end

  private
  def set_version
    @version = Version.find(params[:id])
  end
end
