Rails.application.routes.draw do

  root "ideas#index"

  resources :ideas do
    resources :comments
    resources :joins
    resources :likes
  end


  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
end
