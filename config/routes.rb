Admission::Application.routes.draw do
  devise_for :users

  
  root :to => "welcome#index"

    # Prefix route urls with "admin" and route names with "rails_admin_"
  scope "admin", :module => :rails_admin, :as => "rails_admin" do
    # Routes for rails_admin controller
    controller "main" do
      match "/", :to => :index, :as => "dashboard"
      get "/:model_name", :to => :list, :as => "list"
      get "/:model_name/new", :to => :new, :as => "new"
      match "/:model_name/get_pages", :to => :get_pages, :as => "get_pages"
      post "/:model_name", :to => :create, :as => "create"
      get "/:model_name/:id/edit", :to => :edit, :as => "edit"
      put "/:model_name/:id", :to => :update, :as => "update"
      get "/:model_name/:id/delete", :to => :delete, :as => "delete"
      delete "/:model_name/:id", :to => :destroy, :as => "destroy"
      get "/:model_name/bulk_delete", :to => :bulk_delete, :as => "bulk_delete"
      post "/:model_name/bulk_destroy", :to => :bulk_destroy, :as => "bulk_destroy"
      
      get "/students/:id/certificate", :model_name => "students", :to => :certificate, :as => "certificate"
      get "/students/:id/final_certificate", :model_name => "students", :to => :final_certificate, :as => "final_certificate"
    end
    scope "history", :as => "history" do
      controller "history" do
        match "/list", :to => :list, :as => "list"
        match "/slider", :to => :slider, :as => "slider"
        match "/:model_name", :to => :for_model, :as => "model"
        match "/:model_name/:id", :to => :for_object, :as => "object"
      end
    end
  end  

  # match ':controller(/:action(/:id(.:format)))'
end
