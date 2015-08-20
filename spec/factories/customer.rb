FactoryGirl.define do
    sequence :email do |n|
        "customer#{n}@test.com"
    end

    factory :customer do
        email
        first_name "factory"
        last_name "user"
    end

end
