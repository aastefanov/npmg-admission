Admission::Application.routes.draw do
  devise_for :users
  devise_for :applicants

  controller "students" do
    post "/get_results", :to => :results, :as => "results"
  end
  
  root :to => "main#index"

  devise_scope :user do
    match "adnp/login", :to => "devise/sessions#new"
  end

  scope "adnp", :module => :rails_admin, :as => "rails_admin" do
    controller "assessments" do
      get "/protocols", :model_name => :assessments, :to => :index, :as => "protocols"
      get "/get_assessments/:id", :to => :get_assessments, :as => "get_assessments"
      get "/protocols/exam", :format => :csv, :to => :exam_protocol, :as => "exam_protocol"
      get "/protocols/inspector", :format => :csv, :to => :inspector_protocol, :as => "inspector_protocol"
      get "/protocols/all_students", :format => :csv, :to => :all_students, :as => "all_students_protocol"
    end

    controller "declassification" do
      get "/declassification", :model_name => "students", :to => :index, :as => "declass"
      post "/declassification/import", :model_name => "students", :to => :import, :as => "import_declass"
      get "/declassification/edit", :model_name => "students", :to => :edit, :as => "edit_declass"
      put "/declassification/edit", :model_name => "students", :to => :update, :as => "update_declass"
    end

    controller "miscellaneous" do
      get "/miscellaneous", :model_name => "students", :to => :index, :as => "misc"
      post "/miscellaneous/points_marks_import", :model_name => "students", :to => :points_marks_import, :as => "points_marks_import"
    end

    controller "approval" do
      get "/approval", :model_name => "students", :to => :index, :as => "approval"
      get "/approval/new", :model_name => "students", :to => :preview, :as => "preview_approval"
      get "/approval/:id/change_state", :model_name => "students", :to => :change_state, :as => "change_state_approval"
    end
  end

  mount RailsAdmin::Engine => '/adnp', :as => 'rails_admin'

  resources :applicants do
    get 'preview', :on => :member
    get 'certificate', :on => :member
  end
  match '/update_competitions_select/:exam_id', :controller => :applicants, :action => :update_competitions_select

  match ':controller(/:action(/:id(.:format)))'
end
