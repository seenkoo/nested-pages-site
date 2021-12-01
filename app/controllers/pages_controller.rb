class PagesController < ApplicationController
  include ErrorHandling

  before_action :set_page!, only: %i[show edit update]

  def index
    @pages = Page.all.arrange
  end

  def show; end

  def new
    @page = Page.new
    @page.parent = Page.find_by!(slug: params[:slug]) if params[:slug].present?
  end

  def create
    @page = Page.new page_params_for_create
    if @page.save
      flash[:success] = 'Page created!'
      redirect_to page_path(@page)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @page.update page_params_for_update
      flash[:success] = 'Page updated!'
      redirect_to page_path(@page)
    else
      render :edit
    end
  end

  private

  def page_params_for_create
    params.require(:page).permit(:name, :title, :body, :parent_id)
  end

  def page_params_for_update
    params.require(:page).permit(:title, :body)
  end

  def set_page!
    @page = Page.find_by!(slug: params[:slug])
  end
end
