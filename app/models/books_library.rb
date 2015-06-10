class BooksLibrary < ActiveRecord::Base

  belongs_to :book
  belongs_to :library

end
