Rails.application.routes.draw do
  #URLの末尾が/のときtasksコントローラのindexアクションを実行。
  root to: 'tasks#index'
  
  #index, show, new, create, edit, update, destroyアクションを作成。
  resources :tasks
  
  #URLが'/users/new'だとカッコ悪いので、'/signup'にするための記述。
  get 'signup', to: 'users#new'
  
  resources :users, only: [:index, :show, :new, :create]
end
