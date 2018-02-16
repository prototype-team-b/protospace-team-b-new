Rails.application.routes.draw do
  devise_for :users
  root 'prototypes#index'
  resources :users, only: [:show, :edit, :update]
  resources :tags, only: [:index, :show]
  resources :prototypes, only: [:index, :new, :create, :show, :destroy, :edit, :update] do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
  post   '/like/:prototype_id' => 'likes#like',   as: 'like'
  delete '/like/:prototype_id' => 'likes#unlike', as: 'unlike'

end
