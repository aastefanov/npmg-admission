FactoryBot.define do

  factory :user do
    first_name {'Test'}
    last_name {'Test'}
    email {'test@test.test'}
    phone {'0888888888'}
    factory :admin do
      roles { [Role.new(:name => :admin)] }
    end
  end

  factory :region do
    name {'Region'}
    short_name {'REG'}
  end

  factory :city do
    name {'City'}
    region
  end

  factory :school do
    name {'School'}
    city
  end

  factory :exam do
    name {'Exam'}
    held_in {Date.new(2018, 1, 1)}
  end
end