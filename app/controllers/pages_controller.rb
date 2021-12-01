class PagesController < ApplicationController
  def index
    @pages = Page.all.arrange
  end
end
