FactoryGirl.define do
  factory :book do
    sequence :title do |n|
      "Of Mice and Men #{n}"
    end
    author "John Steinbeck"
    description "A book about mice and men."
    url "http://www.sparknotes.com/lit/micemen/"

    association :user
  end
end
