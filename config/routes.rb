Rails.application.routes.draw do
  get '/', to: 'pages#index', as: :pages
  get '(/*slug)/add', to: 'pages#new', as: :new_page
  get '/*slug/edit', to: 'pages#edit', as: :edit_page
  get '/*slug', to: 'pages#show', as: :page, constraints: ->(request) {
    slug = request.path_parameters[:slug]
    slug.match? /\A[a-zA-Zа-яА-ЯёЁ0-9_\/]+\z/
  }
  patch '/*slug', to: 'pages#update'
  put '/*slug', to: 'pages#update'
  delete '/*slug', to: 'pages#destroy'
  post '/*slug', to: 'pages#create'

  root 'pages#index'
end
