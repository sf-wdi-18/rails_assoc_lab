class User < ActiveRecord::Base

  validates :email, presence: true, uniqueness: true

  has_many :users_books
  has_many :books, through: :users_books

end
