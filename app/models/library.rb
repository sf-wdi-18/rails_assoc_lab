class Library < ActiveRecord::Base

  validates :name, presence: true

  has_many :books_libraries
  has_many :books, through: :books_libraries

end
