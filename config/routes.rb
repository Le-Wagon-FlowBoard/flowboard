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
    resources :assignees, only: [:create, :new]
    patch 'deadline', to: 'tasks#update_deadline', as: 'deadline'
  end
  # in this code i need three routes that will return a ruby erb file as a text/html so that i can use it in my js file
  get "/add_label_modal", to: "pages#add_label_modal", as: "add_label_modal"
  get "/add_deadline_modal", to: "pages#add_deadline_modal", as: "add_deadline_modal"
  get "/add_assignee_modal", to: "pages#add_assignee_modal", as: "add_assignee_modal"
end
