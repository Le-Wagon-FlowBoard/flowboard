Rails.application.routes.draw do
  devise_for :users
  root "pages#home"

  resources :projects do
    resources :labels
    resources :boards do
      resources :tasks do
        post '/add_labels_to_task', to: 'tasks#add_labels_to_task', as: 'add_labels_to_task'
        resources :assignee, :deadline, :label, :subtasks
      end
    end
  end
end
