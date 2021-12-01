require 'rails_helper'

RSpec.describe 'Pages', type: :request do
  include Rails.application.routes.url_helpers

  describe 'request main page' do
    it 'has all pages and subpages tree' do
      root_page1 = Page.create(name: 'root_page1')
      root_page2 = Page.create(name: 'root_page2')
      sub_page11 = root_page1.children.create(name: 'sub_page11')
      sub_sub_page111 = sub_page11.children.create(name: 'sub_sub_page111')

      get pages_path

      expect(response).to be_successful
      expect(response.body).to(
        include('root_page1')
        .and include('root_page2')
        .and include('sub_page11')
        .and include('sub_sub_page111')
      )
    end
  end

  describe 'request inner page' do
    it 'has page title' do
      root_page = Page.create(name: 'root_page', title: 'Some title')

      get page_path root_page

      expect(response).to be_successful
      expect(response.body).to include('Some title')
    end

    it 'has page body' do
      root_page = Page.create(name: 'root_page', body: 'Some body')

      get page_path root_page

      expect(response).to be_successful
      expect(response.body).to include('Some body')
    end

    it 'has all subpages tree' do
      root_page = Page.create(name: 'root_page')
      sub_page = root_page.children.create(name: 'sub_page')
      sub_sub_page = sub_page.children.create(name: 'sub_sub_page')
      sub_sub_sub_page = sub_sub_page.children.create(name: 'sub_sub_sub_page')

      get page_path sub_page

      expect(response).to be_successful
      expect(response.body).to(
        include('sub_sub_page')
        .and include('sub_sub_sub_page')
      )
    end
  end
end
