Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  
  root 'pages#index'
 

  resources(:users, only: %i[new show create])
  resources(:user_deposits, only: %i[index show create destroy])
  resources(:session, only: %i[new create destroy])

  get('user_deposits_new/:id', to: 'user_deposits#new', as: 'user_deposits_new')
  get('user_all_deposits', to: 'user_deposits#show_all_deposit', as: 'user_all_deposits')
  
  # Defines the root path route ("/")
  # root "posts#index"
end
