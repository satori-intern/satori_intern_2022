Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' }, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "static_pages/home"
  get "/healthcheck" => "static_pages#healthcheck"

  # boards controller
  get    "boards/index"       => "boards#index"
  get    "boards/new"         => "boards#new"
  post   "boards/create"      => "boards#create"
  get    "boards/:id/edit"    => "boards#edit"
  put    "boards/:id/update"  => "boards#update"
  delete "boards/:id/destroy" => "boards#destroy"
  get    "boards/:id/show"    => "boards#show"

  post "boards/get_board_data", "boards#get_board_data"

  # lists controller
  post   "lists/create" , "lists#create"
  put    "lists/update" , "lists#update"
  delete "lists/destroy", "lists#destroy"
  post   "lists/move"   , "lists#move"

  # items controller
  post   "items/create" , "items#create"
  put    "items/update" , "items#update"
  delete "items/destroy", "items#destroy"
  post   "items/move"   , "items#move"

end
