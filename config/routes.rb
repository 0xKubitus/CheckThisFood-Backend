Rails.application.routes.draw do
  resources :recipes
  resources :comments

  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }
  get '/member-data', to: 'members#show'
  get '/trends', to: 'recipes#trendy'
  get '/breakfast', to: 'recipes#breakfasts'
  get '/meals', to: 'recipes#meals'
  get '/snacks', to: 'recipes#snacks'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end