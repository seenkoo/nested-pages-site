class PagesController < ApplicationController
  include ErrorHandling

  before_action :set_page!, only: %i[show]

  def index
    @pages = Page.all.arrange
  end

  def show; end

  def new
    @page = Page.new
    @page.parent = Page.find_by!(slug: params[:slug]) if params[:slug].present?
  end

  def create
    @page = Page.new page_params
    if @page.save
      flash[:success] = 'Page created!'
      redirect_to page_path(@page)
    else
      render :new
    end
  end

  private

  def page_params
    params.require(:page).permit(:name, :title, :body, :parent_id)
  end

  def set_page!
    @page = Page.find_by!(slug: params[:slug])
  end
end
