class Review < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  validates :description,
  presence: true,
  length: { minimum: 50 }
end
