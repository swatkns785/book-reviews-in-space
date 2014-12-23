FactoryGirl.define do
  factory :user do
    first_name "Marlo"
    last_name "Stanfield"
    sequence(:email) { |n| "#{n}marlo.stanfield@bmore.com"}
    password "mynameismyname"
  end
end
