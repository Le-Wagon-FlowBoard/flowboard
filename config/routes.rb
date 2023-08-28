Rails.application.routes.draw do
  devise_for :users
  root "pages#home"

  resources :projects, only: [:new, :create, :update, :destroy] do
    resources :boards do
      resources :tasks do
        resources :assignee, :deadline, :label, :subtasks
      end
    end
  end
end
