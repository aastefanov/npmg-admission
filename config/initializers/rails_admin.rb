# encoding: UTF-8

RailsAdmin.config do |config|
  config.audit_with :paper_trail, User
  config.current_user_method { current_user }
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
    assessment_certificate
    final_certificate
  end

  config.model Configurable do
    visible false
  end

  config.model Assessment do
    visible false

    field :exam
    field :competition_mark
    field :is_taking_exam
  end

  config.model Competition do
    field :name
    field :exam
  end

  config.model Applicant do
    field :status_text
    field :approved do
      hide
    end
    field :first_name
    field :middle_name
    field :last_name
    field :egn
    field :phone
    field :email
    
    group :enrollment_assessments do
      field :enrollment_assessments
    end

    group :assets do
      field :assets
    end

    group :reviews do
      field :reviews
    end
  end

  config.model Review do
    visible false

    field :content
  end

  config.model PointsToMark do
    field :competition
    field :to_range
    field :mark
  end

  config.model Asset do
    visible false

    field :file
    field :description
  end

  config.model EnrollmentAssessment do
    visible false

    field :exam
    field :is_taking_exam
    field :competition
    field :points
  end
  
  config.model Student do
    field :id
    field :first_name
    field :middle_name
    field :last_name
    field :egn
    field :phone
    
    group :grades do
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