# 1:N and N:N Associations

## Setup

For this lab you'll need to start and setup a new application.

* `rails new assoc_lab -d postgresql`
* `cd assoc_lab`
* `rake db:create` (Why?)

## 1:N

The `one-to-many` relationship is the most common relationship one will come across when developing an application


### Authors Table

| `id` | `first_name` | `last_name` | `y_o_b` | `y_o_d` |
| :---  | :---  | :---  | :---  | :---  |
| 1 | Rudyard | Kipling | 1865 | 1936 |
| 2 | Lewis | Carroll | 1832 | 1892 |
| 3 | H.G.	| Wells	|  1866 | 1946	|



### Books Table

| `id` | `title` | `description` | `publication_year` | `isbn` | `author_id` |
| :---  | :---  | :---  | :---  | :---  | :---  |
|1 | The Jungle Book | The Jungle Book is a collection of stories by English author Rudyard Kipling. The stories were first published in magazines in 1893–94. The original publications contain illustrations, some by Rudyard's father, John Lockwood Kipling. | 1894 | 9788497896696 | 1 |
| 2 | Alice's Adventures in Wonderland | Alice's Adventures in Wonderland is an 1865 novel written by English author Charles Lutwidge Dodgson under the pseudonym Lewis Carroll. | 1865 | 9781552465707 | 2 |
| 3 | Rikki-Tikki-Tavi |"Rikki-Tikki-Tavi" is a short story in The Jungle Book by Rudyard Kipling about the adventures of a valiant young mongoose. The story has often been anthologized, and has been published more than once as a short book in its own right. | 1894 | 1484123689 | 1 |
| 4 | Through the Looking-Glass | Through the Looking-Glass, and What Alice Found There is a novel by Lewis Carroll, the sequel to Alice's Adventures in Wonderland. It is based on his meeting with another Alice, Alice Raikes | 1871 | 9781489500182 | 2 |
| 5 | The Time Machine | The Time Machine is a science fiction novel by H. G. Wells, published in 1895. Wells is generally credited with the popularisation of the concept of time travel by using a vehicle that allows an operator to travel purposefully and selectively | 1895  | 9781423794417 | 3 |


### Explanation

In this example we have shown how to associate tables using the concept of a `foriegn_key`. In the above `Books` table the `author_id` is a foriegn key that we can use to look up information about the author. 

### Implementation

We want to generate these models and setup the associations. First let's setup the `Author` model.

* Note that in the following `y_o_b` and `y_o_d` could be called `yob` and `yod` to cut down on typing.

	```
	rails g model author first_name:string last_name:string y_o_b:integer y_o_d:integer
	```
	
* Now let's generate the `Book` model. Keep in mind that here we will need a column for the foriegn key to associate to  the `Author` model.

	```
	rails g model book title:string description:text publication_year:integer isbn:string author_id:integer
	```
* Always be sure to migrate your changes

	```
	rake db:migrate
	```
* Setup the associations to `books` for `author`

	```
	class Author < ActiveRecord::Base
		has_many :books
	end
	```
	
* Setup the associations to `author` for `book`

	```
	class Author < ActiveRecord::Base
		belongs_to :author
	end
	```

	

### Working with Active Record in the Command Line

* Open the Rails console
* First create some authors. Please use the ones listed in the table above for the sake of consistency.
	
	```
	> Author.create(first_name:"Rudyard", last_name:"Kipling")
	```
	
* Find `Rudyard Kipling` like so (only find by id if you know for sure what the id is):

	```
    > rud = Author.find(1)
    or
    > rud = Author.find_by(first_name:"Rudyard")
	```
	
* Add `The Jungle Book` as a `book` to `rud` using the helper methods, i.e.
	
	```
	> rud.books.create(title: "The Jungle Book", description: "Cool sh!t", publication_year: 1894, isbn: 9788497896696)
	```
	
* Find `The Jungle Book` and update its description.
	
	
	```
	> jungle_bk = rud.books.find_by(isbn: 9788497896696)
	> jungle_bk.update(description: "The sh!t.")
	```
		
* Or we can do the following, which is just the typical way to update. However, keep in mind that this doesn't guarantee that the `book` we are updating is properly associated to our `author`, good ole `rud`.

    ```
    > jungle_bk = Book.find_by(isbn: 9788497896696)
    > jungle_bk.update(description: "very cool")
    ```
* Let's create a second `book` for `Rikki-Tikki_tavi` using a different way.

    ```
    > rikki_tikki = Book.create(title: "Rikki-Tikki-Tavi", isbn: 1484123689)
    > rud.books.push(rikki_tikki)
    ```
* Verify that `rud` is associated to the new book.

    ```
    > rud.books.find(isbn: 1484123689) 
    # or do the following
    > rikki_tikki = Book.find_by(isbn: 1484123689)
    > rikki_tikki.author_id == rud.id # should be true
    ```

### Moar

Repeat the process we went through for `rud` above with `lewis_carroll` and `h_g_wells`.


### N:N

The many to many (N:N) relationship is about as common of an association as `1:N`.


### Implementation

A very common form of association for the many-to-many association is the `library-book` association. A `many-to-many` association will need what's called a join table that will store the foriegn keys of the table rows being associated. I call it the glue table.



#### Books Table

| `id` | `title` | `description` | `publication_year` | `isbn` | `author_id` |
| :---  | :---  | :---  | :---  | :---  | :---  |
|1 | The Jungle Book | The Jungle Book is a collection of stories by English author Rudyard Kipling. The stories were first published in magazines in 1893–94. The original publications contain illustrations, some by Rudyard's father, John Lockwood Kipling. | 1894 | 9788497896696 | 1 |
| 2 | Alice's Adventures in Wonderland | Alice's Adventures in Wonderland is an 1865 novel written by English author Charles Lutwidge Dodgson under the pseudonym Lewis Carroll. | 1865 | 9781552465707 | 2 |
| 3 | Rikki-Tikki-Tavi |"Rikki-Tikki-Tavi" is a short story in The Jungle Book by Rudyard Kipling about the adventures of a valiant young mongoose. The story has often been anthologized, and has been published more than once as a short book in its own right. | 1894 | 1484123689 | 1 |
| 4 | Through the Looking-Glass | Through the Looking-Glass, and What Alice Found There is a novel by Lewis Carroll, the sequel to Alice's Adventures in Wonderland. It is based on his meeting with another Alice, Alice Raikes | 1871 | 9781489500182 | 2 |
| 5 | The Time Machine | The Time Machine is a science fiction novel by H. G. Wells, published in 1895. Wells is generally credited with the popularisation of the concept of time travel by using a vehicle that allows an operator to travel purposefully and selectively | 1895  | 9781423794417 | 3 |

#### BooksLibraries Table 


| `id` | `library_id` | `book_id` |
| :-- | :-- | :-- |
| 1 | 1 | 1 |
| 2 | 1 | 2 |
| 3 | 1 | 3 |
| 4 | 2 | 2 |
| 5 | 2 | 3 |
| 6 | 3 | 1 |
| 6 | 3 | 2 |


### Libraries Table

| `id` | `name` | `city` | `state` |
| :--- | :--- | :---  |   :---  |
| 1 | Library of Congress |  Washington | DC |
| 2 | George Peabody Library | Baltimore | Maryland |
| 3 | Central Library |   Seattle |  Washington |


### Implementation 

* Generate a model called `BooksLibrary` with columns to represent foreign keys

-> `Books` is pluralized and `Library` is not because we ultimately want Rails to create a table called
`BooksLibaries`.  Rails will pluralize model names in order to generate table names (it's smart
enough to change `Library` to `Libraries`, but we need to pluralize `Books` for it) 
 

  ```
  rails g model BooksLibrary library_id:integer book_id:integer
  ```

* Generate a model for the `Library`

  ```
  rails g model Library name:string city:string state:string
  ```

* Make sure to migrate

```
rake db:migrate
```

* Set up the association between the `BooksLibrary` model and `Book` model

  ```
  class BooksLibrary < ActiveRecord::Base
    belongs_to :book
  end
  ```

* Set up the association between the `BooksLibrary` model and `Library` model

  ```
  class BooksLibrary < ActiveRecord::Base
    belongs_to :book
    belongs_to :library
  end
  ```

* Set up the association between the `Book` model and `BooksLibrary` model

  ```
  class Book < ActiveRecord::Base
    belongs_to :author
    has_many :books_libraries
  end
  ```

* Set up the association between the `Book` model and the `Library` model through the join table model

  ```
  class Book < ActiveRecord::Base
    belongs_to :author
    has_many :books_libraries
    has_many :libraries, through: :books_libraries
  end
  ```

* Set up the association between the `Library` model and the `BooksLibrary` model.

  ```
  class Library < ActiveRecord::Base
    has_many :books_libraries
  end
  ```

* Setup the association between the `Library` model and the `Book` model through the join table model.

  ```
  class Library < ActiveRecord::Base
    has_many :books_libraries
    has_many :books, through: :books_libraries
  end
  ```



### Back to the Command Line

* Create some libraries using the table above as reference
* Add an associated `book` to a `library` in rails console.

  ```
    > congress = Library.find(1) # library of congress
    > jungle_bk = Book.find_by(isbn: 9788497896696)
    > congress.books.push(jungle_bk)
  ```

* Add `rikki_tikki` and `the_time_machine` to library of congress by finding them and pushing them into the `congress.books` collection.
* Find the `George Peabody Library` and add  `rikki_tikki` and `the_time_machine` to the `g_p_lib.books` collection using `push`.
* Find the `Central Library` and add the `jungle_bk` and `rikki_tikki` to the `central_lib.books` collection using `push`.
* Type the following in rails console:

  ```
  > BooksLibrary.all.count
  ```
  * How many `BooksLibrary` objects are there?
  * Why does that make sense?
  
* Using the `congress` library try the following:

  ```
  > Book.all.count
  > BooksLibrary.all.count
  > congress.books.count
  > congress.books.delete(1)
  > Book.all.count
  > BooksLibrary.count
  ```
  
  * Which number changed after the `congress.books.delete`, `Book.all.count` or `BooksLibrary.all.count`?
  * Why does that make sense?





## Bonus

Add a User model to your application.  A User has many favorite books.

* You will have to add a `user_id` foreign key to your `books` table

```
rails g migration AddUserIdToBooks user_id:integer
```
* Don't forget to migrate!



* Use your knowledge of `many-to-many` (N:N) to implement the association in the `user` and `book` models
* Test the association in Console

  
