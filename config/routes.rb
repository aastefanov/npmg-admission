Admission::Application.routes.draw do
  

  devise_for :users

  controller "students" do
    post "/get_results", :to => :results, :as => "results"
  end
  
  root :to => "main#index"

  scope "adnp2012", :module => :rails_admin, :as => "rails_admin" do
    controller "assessments" do
      get "/protocols", :model_name => :assessments, :to => :index, :as => "protocols"
      get "/get_assessments/:id", :to => :get_assessments, :as => "get_assessments"
      get "/protocols/exam", :format => :csv, :to => :exam_protocol, :as => "exam_protocol"
      get "/protocols/inspector", :format => :csv, :to => :inspector_protocol, :as => "inspector_protocol"
      get "/protocols/all_students", :format => :csv, :to => :all_students, :as => "all_students_protocol"
    end

    controller "declassification" do
      get "/declassification", :model_name => "students", :to => :index, :as => "declass"
      post "/declassification/import", :model_name => "assessment", :to => :import, :as => "import_declass"
      get "/declassification/edit", :model_name => "assessment", :to => :edit, :as => "edit_declass"
      put "/declassification/edit", :model_name => "assessment", :to => :update, :as => "update_declass"
    end
  end

  mount RailsAdmin::Engine => '/adnp2012', :as => 'rails_admin'

  #   # Prefix route urls with "admin" and route names with "rails_admin_"
  # scope "adnp2011", :module => :rails_admin, :as => "rails_admin" do
  #   
  #   controller "main" do
  #     match "/", :to => :index, :as => "dashboard"
  #     get "/:model_name", :to => :list, :as => "list"
  #     get "/:model_name/new", :to => :new, :as => "new"
  #     match "/:model_name/get_pages", :to => :get_pages, :as => "get_pages"
  #     post "/:model_name", :to => :create, :as => "create"
  #     get "/:model_name/:id/edit", :to => :edit, :as => "edit"
  #     put "/:model_name/:id", :to => :update, :as => "update"
  #     get "/:model_name/:id/delete", :to => :delete, :as => "delete"
  #     delete "/:model_name/:id", :to => :destroy, :as => "destroy"
  #     get "/:model_name/bulk_delete", :to => :bulk_delete, :as => "bulk_delete"
  #     post "/:model_name/bulk_destroy", :to => :bulk_destroy, :as => "bulk_destroy"
      
  #     get "/students/:id/certificate", :model_name => "students", :to => :certificate, :as => "certificate"
  #     get "/students/:id/final_certificate", :model_name => "students", :to => :final_certificate, :as => "final_certificate"
  #   end

  #   
  # end 


  match ':controller(/:action(/:id(.:format)))'
end
