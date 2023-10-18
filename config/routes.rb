Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    resources :doctors do
      resources :working_hours, only: [:index]
    end
  end
end

