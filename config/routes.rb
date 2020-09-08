Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' }, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "static_pages/home"
  post "static_pages/show"

  # boards controller
  post "boards/get_board_data", "boards#get_board_data"

  # lists controller
  post "lists/create" , "lists#create"
  put  "lists/edit"   , "lists#edit"
  post "lists/destroy", "lists#destroy"
  post "lists/move"   , "lists#move"

  # items controller
  post "items/create" , "items#create"
  put  "items/edit"   , "items#edit"
  post "items/destroy", "items#destroy"
  post "items/move"   , "items#move"

end
