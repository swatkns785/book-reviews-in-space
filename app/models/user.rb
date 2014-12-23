class User < ActiveRecord::Base
  has_many :books

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         validates :first_name,
         presence: true

         validates :last_name,
         presence: true

         validates :email,
         presence: true,
         uniqueness: { message: "This email address has already been registered." }

         validates :password,
         presence: true
end
