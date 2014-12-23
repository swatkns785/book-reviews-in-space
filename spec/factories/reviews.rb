FactoryGirl.define do
  factory :review do
    sequence :description do |n|
      "Mice are friggin awesome, a lot cooler than men #{n}."
    end

    association :user
    association :book
  end
end
