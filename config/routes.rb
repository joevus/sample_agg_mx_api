Rails.application.routes.draw do
  root 'pages#index'
  resources :users do
    resources :members do
      get :status
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
