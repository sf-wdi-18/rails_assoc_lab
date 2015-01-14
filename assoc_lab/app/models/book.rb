class Book < ActiveRecord::Base
  belongs_to :author
  has_many :book_libraries
  has_many :libraries, through: :book_libraries
end