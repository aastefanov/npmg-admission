# encoding: UTF-8

RailsAdmin.config do |config|
  config.audit_with :history, User
  config.current_user_method { current_user } #auto-generated
  config.main_app_name = ["НПМГ", "Прием"]

  config.actions do
    dashboard
    index
    new
    history_index
    show
    edit
    delete
    history_show
    show_in_app
    assessment_certificate
    final_certificate
  end

  config.model Assessment do
    visible false

    field :exam
    field :competition_mark
    field :is_taking_exam
  end
  
  config.model Student do
    field :id
    field :first_name
    field :middle_name
    field :last_name
    field :egn
    field :phone
    
    group :grades do
      field :grades
      field :assessments
    end

    edit do 
      field :registered_by, :hidden do
        default_value do
          bindings[:view]._current_user.id
        end
      end
    end 
  end
  
  config.model Exam do
    field :id
    field :name
    field :held_in
  end
  
  config.model Grade do
    field :name
    field :exams
  end
  
  config.model User do
    field :is_active
    field :first_name
    field :last_name
    field :email
    
    group :password_change do
      field :password
      field :password_confirmation
    end
  end
end