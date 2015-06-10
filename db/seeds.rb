# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Book.create(title:"The Jungle Book")
Book.create(title:"Alice's Adventures in Wonderland", description:"Alice's Adventures in Wonderland is an 1865 novel written by English author Charles Lutwidge Dodgson under the pseudonym Lewis Carroll.", publication_year:1865, isbn:9781552465707, author_id:2)
Book.create(title:"Rikki-Tikki-Tavi", description:"'Rikki-Tikki-Tavi' is a short story in The Jungle Book by Rudyard Kipling about the adventures of a valiant young mongoose. The story has often been anthologized, and has been published more than once as a short book in its own right.", publication_year:1894, isbn:1484123689, author_id:1)
Book.create(title:"Through the Looking-Glass", description:"Through the Looking-Glass, and What Alice Found There is a novel by Lewis Carroll, the sequel to Alice's Adventures in Wonderland. It is based on his meeting with another Alice, Alice Raikes", publication_year:1871, isbn:9781489500182, author_id:2)
Book.create(title:"The Time Machine", description:"The Time Machine is a science fiction novel by H. G. Wells, published in 1895. Wells is generally credited with the popularisation of the concept of time travel by using a vehicle that allows an operator to travel purposefully and selectively", publication_year:1895, isbn:9781423794417, author_id:3)