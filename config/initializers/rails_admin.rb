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
    #    history_index
    history_show
  end

  config.label_methods << :full_name
  config.label_methods << :description

  config.model 'Student' do
    group :personal_data do
      field :first_name
      field :middle_name
      field :last_name
      field :ref_num
    end

    field :user

    group :approval do
      field :approved_at
      field :declined_at
      field :approver
    end

    field :school do
      inline_add false
      inline_edit false
    end

    field :exams

    list do
      field :status
    end

    show do
      field :status
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
      nested_form false
      inline_add false
      # inline_edit false
      queryable false
    end

    edit do
      group :password_change do
        field :password
        field :password_confirmation
      end
    end
  end

  config.model 'Post' do
    field :name

    create do
      field :content, :ck_editor
      field :user_id, :hidden do
        default_value do
          bindings[:view]._current_user.id
        end
      end
    end
    edit do
      field :content, :ck_editor
      field :user_id, :hidden do
        default_value do
          bindings[:view]._current_user.id
        end
      end
    end

    show do
      field :content do
        pretty_value do
          ERB.new(value).result(binding).html_safe
        end
      end
    end

  end

  config.model 'Page' do

    field :name
    edit do
      field :content, :ck_editor

    end
    show do
      field :content, :ck_editor
    end
  end
end
