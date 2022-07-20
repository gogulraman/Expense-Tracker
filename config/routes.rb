Rails.application.routes.draw do
  get 'employees/index'
  devise_for :employees, :path_prefix => 'd'
  resources :expenses
  #
  resources :employees, :only =>[:show]
  match '/employees',   to: 'employees#index',   via: 'get'
  match '/employees/:id',     to: 'employees#show',       via: 'get'

  #get 'home/index'
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
