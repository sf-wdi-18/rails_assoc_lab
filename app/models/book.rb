class Book < ActiveRecord::Base

  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, uniqueness: true

  belongs_to :author

  has_many :books_libraries
  has_many :libraries, through: :books_libraries

  has_many :users_books  # books are favorited by users
  has_many :users, through: :users_books

end
