Rails.application.routes.draw do
  devise_for :users
  root "pages#home"

  resources :projects do
    resources :labels
    resources :project_permissions
    resources :boards do
      resources :tasks
    end
  end
  resources :tasks do
    resources :task_labels, only: [:create, :new]
    resources :assignee, only: [:create, :new]
    patch 'deadline', to: 'tasks#update_deadline', as: 'deadline'
  end
end
