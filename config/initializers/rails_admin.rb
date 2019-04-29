RailsAdmin.config do |config|
  config.main_app_name = ["Национално Състезание по Природни Науки и География \"Акад. Л. Чакалов\"", "Регистрация"]
  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  config.show_gravatar = false

  config.actions do
    dashboard
    index
    new
    export
    bulk_delete
    show
    edit
    delete
  end

  config.label_methods << :full_name
  config.label_methods << :description

  config.model 'Student' do
    group :personal_data do
      field :first_name
      field :middle_name
      field :last_name

      field :status
    end

    group :school_data do
      field :school do
        inline_add false
        inline_edit false
      end
    end

    group :exams do
      field :exams
    end
    # end
    create do
      field :user_id, :hidden do
        default_value do
          bindings[:view]._current_user.id
        end
      end
    end

    show do
      group :parent_data do
        field :user
      end
    end
  end

  config.model 'Exam' do
    field :name
    field :held_in
  end

  config.model 'Region' do
    field :name
    field :short_name
    show do
      field :cities
      field :schools
    end
  end

  config.model 'City' do
    field :name
    field :region
    show do
      field :schools
    end
  end

  config.model 'School' do
    field :name
    field :city
    show do
      field :students
    end
  end

  config.model 'User' do
    field :first_name
    field :last_name
    field :email
    field :phone
    field :roles

    edit do
      group :password_change do
        field :password
        field :password_confirmation
      end
    end
  end

  config.model 'ApprovalRequest' do

  end

  config.model 'ApprovalComment' do

  end
end
