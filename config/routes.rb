Rails.application.routes.draw do
  get 'home/index'
  get 'home/registered'
  get 'home/confirmed'


  devise_for :users, controllers: {
      registrations: 'users/registrations',
      confirmations: 'users/confirmations'
  }
  root to: "home#index"
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :approvals
  resources :protocols
  resources :students

  resources :approvals do
    get :approve, :on => :member
    get :reject, :on => :member
    post :comment
  end

  scope :api, :module => :api do
    get 'regions', to: 'regions#index'
    get 'regions/:id', to: 'regions#show'
    get 'regions/:id/cities', to: 'regions#cities_in_region'
    # get 'regions/:id/schools', to: 'regions#schools_in_region'
    get 'cities/:id', to: 'regions#city'
    get 'cities/:id/schools', to: 'regions#schools_in_city'
    get 'schools/:id', to: 'regions#school'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
