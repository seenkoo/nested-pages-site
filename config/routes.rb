Rails.application.routes.draw do
  get '/', to: 'pages#index', as: :pages
  get '(/*slug)/add', to: 'pages#new', as: :new_page
  get '/*slug/edit', to: 'pages#edit', as: :edit_page
  get '/*slug', to: 'pages#show', as: :page
  patch '/*slug', to: 'pages#update'
  put '/*slug', to: 'pages#update'
  delete '/*slug', to: 'pages#destroy'
  post '/*slug', to: 'pages#create'

  root 'pages#index'
end
