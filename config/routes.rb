Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' }, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/healthcheck" => "healthcheck#healthcheck"
  
  # boards controller
  get    "boards/index"       => "boards#index"
  get    "boards/new"         => "boards#new"
  post   "boards/create"      => "boards#create"
  #get    "boards/:id/edit"    => "boards#edit"
  get    'boards/:id/edit', to: 'boards#edit', as: 'boards_edit'
  put    "boards/:id/update"  => "boards#update"
  delete "boards/:id/destroy" => "boards#destroy"
  get    "boards/:id/show"    => "boards#show"
  put    "boards/:id/share"    => "boards#share"


  post "boards/get_board_data"=> "apis/boards#get_board_data"

  # lists controller
  post   "lists/create" => "apis/lists#create"
  put    "lists/update" => "apis/lists#update"
  delete "lists/destroy"=> "apis/lists#destroy"
  post   "lists/move"   => "apis/lists#move"

  # items controller
  post   "items/create" => "apis/items#create"
  put    "items/update" => "apis/items#update"
  delete "items/destroy"=> "apis/items#destroy"
  post   "items/move"   => "apis/items#move"

end
