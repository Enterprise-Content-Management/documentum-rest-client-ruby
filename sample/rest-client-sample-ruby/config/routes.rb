Boxroom::Application.routes.draw do
  delete '/signout', :to => 'sessions#destroy'

  resources :users, :sessions, :groups, :search,
            :checked_out_objects, :cabinets,
            :folders, :documents

  resources :clipboard do
    collection do
      get 'add'
    end
  end

  resources :sysobjects do
    collection do
      get 'copy'
      get 'link'
      get 'move'
      post 'check_in'
    end

    member do
      get 'cancel_check_out'
      get 'check_out'
      get 'upload_file_for_check_in'
    end
  end

  root :to => 'users#index'

end
