Rails.application.routes.draw do
  devise_for :users
  root "pages#home"

  resources :projects do
    resources :boards do
      resources :tasks do
        resources :assignee, :deadline, :label, :subtasks
      end
    end
  end
end
