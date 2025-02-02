Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  
  root 'pages#index'
 

  resources(:users, only: %i[new show create])
  resources(:user_deposits, only: %i[index new show create])
  resources(:session, only: %i[new create destroy])

  # Defines the root path route ("/")
  # root "posts#index"
end
