Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  as :user do
    get "sign_in" => "users/sessions#new"
    post "sign_in" => "users/sessions#create"
    get "sign_out" => "users/sessions#destroy"
    get "sign_up" => "users/registrations#new"
    post "sign_up" => "users/registrations#create"
  end
  devise_scope :user do
    authenticated :user do
      root 'departments#index', as: :authenticated_root
      resources 'departments'
      resources 'projects'
      resources 'users_projects'
      resources 'users'
      get 'users_projects_detail' => 'projects#users_projects_detail'
    end

    unauthenticated do
      root 'users/sessions#new', as: :unauthenticated_root
    end
  end

end
