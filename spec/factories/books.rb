FactoryGirl.define do
  factory :book do
    title "Of Mice and Men"
    author "John Steinbeck"
    description "A book about mice and men."
    url "http://www.sparknotes.com/lit/micemen/"

    association :user
  end
end
