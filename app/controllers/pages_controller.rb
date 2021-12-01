class PagesController < ApplicationController
  include ErrorHandling

  before_action :set_page!, only: %i[show]

  def index
    @pages = Page.all.arrange
  end

  def show; end

  private

  def set_page!
    @page = Page.find_by!(slug: params[:slug])
  end
end
