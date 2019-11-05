Rails.application.routes.draw do
  #URLの末尾が/のときtasksコントローラのindexアクションを実行。
  root to: 'tasks#index'
  
  #index, show, new, create, edit, update, destroyアクションを作成。
  resources :tasks
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  #URLが'/users/new'だとカッコ悪いので、'/signup'にするための記述。
  get 'signup', to: 'users#new'
  resources :users, only: [:new, :create]
end
