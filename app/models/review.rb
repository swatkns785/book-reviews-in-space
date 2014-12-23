class Review < ActiveRecord::Base
  belongs_to :book

  validates :description,
  presence: true,
  length: { minimum: 50 }
end
