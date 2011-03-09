RailsAdmin.config do |config|
  config.excluded_models << Assessment
  
  config.model Student do
    field :first_name
    field :middle_name
    field :last_name
    field :is_girl
    field :egn
    field :ref_number
    
    group :contacts do
      field :email
      field :phone
      field :address
    end
    
    group :grades do
      field :grades
    end
  end
  
  config.model Exam do
    field :name
    field :held_in
  end
  
  config.model Grade do
    field :name
    field :exams
  end
  
  config.model User do
    field :first_name
    field :last_name
    field :email
    
    group :password_change do
      field :password
      field :password_confirmation
    end
  end
end