Rails.application.routes.draw do
  devise_for :users
  root "articles#index"
  devise_scope :user do
   get '/users/sign_out', to: 'devise/sessions#destroy'
  end
 resources :articles, param: :slug do
    resources :comments
  end
end

