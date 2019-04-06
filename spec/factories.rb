
FactoryBot.define do

  factory :user do
    first_name {'Test'}
    last_name {'Test'}
    email {'test@test.test'}
    phone {'0888888888'}
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
end