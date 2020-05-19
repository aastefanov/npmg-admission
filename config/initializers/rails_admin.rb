RailsAdmin.config do |config|
  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
    I18n.locale = :en
  end
  config.current_user_method(&:current_user)

  ## == CancanCan ==
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
    dashboard # mandatory
    index # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    history_index
    history_show
  end

  config.label_methods << :full_name
  config.label_methods << :description

  config.model 'Student' do
    group :personal_data do
      field :first_name
      field :middle_name
      field :last_name

    end

    field :school do
      inline_add false
      inline_edit false
    end

    field :exams
    field :applicant, :belongs_to_association

    list do
      field :status
    end

    create do
      field :user_id, :hidden do
        default_value do
          bindings[:view]._current_user.id
        end
      end
    end

    show do
      field :status
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
    field :admin_id
    field :city do
      searchable false
      queryable false
    end
    show do
      field :students
    end
  end

  config.model 'User' do
    field :first_name
    field :last_name
    field :email
    field :phone
    field :roles do
      searchable false
      queryable false
    end

    edit do
      group :password_change do
        field :password
        field :password_confirmation
      end
    end
  end
end
