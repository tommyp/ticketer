Rails.application.routes.draw do
  post '/allocate', to: 'allocate#index', as: :allocate
  get '/charge', to: 'charge#index', as: :charge
  root to: 'landing#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
