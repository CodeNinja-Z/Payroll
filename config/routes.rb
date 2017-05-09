Rails.application.routes.draw do
  resources :reports, only: [:index] do
    collection { post :upload }
  end

  root 'reports#index'
end
