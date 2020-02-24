Rails.application.routes.draw do
  post '/allocate', to: 'allocate#index', as: :allocate
  get '/charge', to: 'charge#index', as: :charge
  get '/success', to: 'charge#success', as: :success
  get '/guests', to: 'guests#index', as: :guests
  get '/reset', to: 'guests#reset', as: :reset
  root to: 'landing#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
