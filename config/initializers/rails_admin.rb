RailsAdmin.config do |config|
  config.excluded_models << Assessment
  
  config.model Exam do
    field :name
    field :held_in
  end
  
  config.model Grade do
    field :name
    field :exams
  end
end