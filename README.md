# Relationships / Associations

## Part 1:Knowledge Integration: Practicing Rails Associations

[Rails Exercises](/associations.md)

## Part 2:Application: Integrating Into Rails App

Let's go back to the `blog_app` we built over the weekend and integrate our knowledge of the Rails associations.

Add a `one-to-many` assocciation betweeen `articles` and `users`. This means we can get rid of the silly `author` column in the `Article` model and use the `user`.

* Let's remove the `author` column from our article by generating a migration

  ```
  rails g migration RemoveAuthorFromArticles author:string
  ```

  and then migrate

  ```
  rake db:migrate
  ```

* Let's also add `user_id` *foriegn key*  to the `Article` model by using a migration.

  ```
  rails g migration AddUserIdToArticles user_id:integer
  ```

  and be sure to migrate

  ```
  rake db:migrate
  ```

* Use your knowledge of `one-to-many` to implement the association in the `user` and `aritcle` models

  

  ```
  class Library < ActiveRecord::Base
    has_many :articles
  end
  ```

  and also

  ```
  class Article < ActiveRecord::Base
    belongs_to :user
  end
  ```

* First go through all your views and remove all the erb that renders `article.author`
* In the `ArticlesController` change the `create` method to use the `current_user.articles.create` to create a new `article`. We don't want to do `Article.create` anymore.
* In the `UsersController` show page render the `current_user.articles`.