Rails.application.routes.draw do

  # devise_for :users
  # as :user do
  #   get "sign_in" => "devise/sessions#new"
  #   post "sign_in" => "devise/sessions#create"
  #   delete "sign_out" => "devise/sessions#destroy"
  # end

  devise_for :users
  as :user do
    get 'sign_out' => "devise/sessions#destroy"
  end
  devise_scope :user do
    authenticated :user do
      root 'projects#index', as: :authenticated_root
      resources 'departments'
      resources 'projects'
      resources 'users_projects'
      resources 'users'
      get 'users_projects_detail' => 'projects#users_projects_detail'
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

end
