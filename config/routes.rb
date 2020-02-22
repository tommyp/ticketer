Rails.application.routes.draw do
  post '/charge', to: 'charge#index', as: :charge
  get '/checkout', to: 'checkout#index', as: :checkout
  root to: 'landing#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
