Admission::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :students

  resources :approvals do
    get :approve, :on => :member
    get :reject, :on => :member
    post :comment
  end

  root :to => 'main#index'

  devise_for :users, controllers: {
      registrations: 'users/registrations'
  }

  scope :api, :module => :api do
    get 'regions', to: 'regions#index'
    get 'regions/:id', to: 'regions#show'
    get 'regions/:id/cities', to: 'regions#cities_in_region'
    # get 'regions/:id/schools', to: 'regions#schools_in_region'
    get 'cities/:id', to: 'regions#city'
    get 'cities/:id/schools', to: 'regions#schools_in_city'
    get 'schools/:id', to: 'regions#school'
  end
end
