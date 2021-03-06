class Book < ActiveRecord::Base
  belongs_to :user
  has_many :reviews

  validates :title,
  presence: true,
  length: { minimum: 1 }

  validates :description,
  presence: true,
  length: { minimum: 10 }

  validates :url,
  presence: true,
  format: { with: URI.regexp }

end
