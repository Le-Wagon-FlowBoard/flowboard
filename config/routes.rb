Rails.application.routes.draw do
  devise_for :users
  root "pages#home"

  resources :projects do
    resources :labels
    resources :boards do
      resources :tasks do
        resources :assignee, :deadline, :label, :subtasks
      end
    end
  end
  resources :tasks, only: [] do
    resources :task_labels, only: [:create]
  end


end
