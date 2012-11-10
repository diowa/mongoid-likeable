# mongoid-likeable

Add like to your Mongoid documents.
This is a fork of `tombell/mongoid-voteable` for people who only need likes.

**Note** Breaking changes from version 1.0 to 2.0. Check out our wiki for an update script

## Installation

Install the gem

    $ gem install mongoid-likeable

or add the gem to your `Gemfile`

    gem 'mongoid-likeable'

## Usage

Include the `Mongoid::Likeable` module into your models you want to like.

```ruby
class Story
  include Mongoid::Document
  include Mongoid::Likeable

  # ...
end
```

You can then like by simply using the `like` method on the model.

```ruby
@story = Story.first
@user = User.where(name: 'Simon')

@story.like @user   # you like it
@story.unlike @user # you don't like it anymore
```

You also have access to a helpful method.

```ruby
@story.liked? @user # true if the user has already liked this
```
Likes are stored in a field called `likes`, so you can sort models by like count.

**Note** if your users are not stored in a Mongo collection or the ID field is
not called `_id` you can still pass the ID in as the second parameter instead.

```ruby
@story.like @user.id

@story.liked? @user.id
```

## License

mongoid-likeable is licensed under the BSD 2-Clause License
mongoid-voteable is licensed under the MIT License - Copyright (c) 2012 Tom Bell
