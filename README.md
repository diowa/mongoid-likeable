# mongoid-likeable
[![Build Status](https://secure.travis-ci.org/diowa/mongoid-likeable.png?branch=master)](https://travis-ci.org/diowa/mongoid-likeable)
[![Gem Version](https://badge.fury.io/rb/mongoid-likeable.png)](http://badge.fury.io/rb/mongoid-likeable)
[![Dependency Status](https://gemnasium.com/diowa/mongoid-likeable.png)](https://gemnasium.com/diowa/mongoid-likeable)
[![Code Climate](https://codeclimate.com/github/diowa/mongoid-likeable.png)](https://codeclimate.com/github/diowa/mongoid-likeable)
[![Coverage Status](https://coveralls.io/repos/diowa/mongoid-likeable/badge.png?branch=master)](https://coveralls.io/r/diowa/mongoid-likeable)

Add like to your Mongoid documents.
This is a fork of `tombell/mongoid-voteable` for people who only need likes.



## Installation

Install the gem

    $ gem install mongoid-likeable

or add the gem to your `Gemfile`

    gem 'mongoid-likeable'



## Thread safety

This gem is thread safe.



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
@story.like @user   # @user likes @story
@story.unlike @user # @user doesn't like @story anymore
```

You also have access to a helpful method.

```ruby
@story.liked? @user # true if @user likes @story
```
Like count is stored in a field called `likes`, so you can sort models by that field.

**Note** if your users are not stored in a Mongo collection or the ID field is
not called `_id` you can still pass the ID in as the second parameter instead.

```ruby
@story.like @user.id

@story.liked? @user.id
```



## Contributing

Please read through our [contributing guidelines](CONTRIBUTING.md). Included are directions for opening issues, coding standards, and notes on development.

More over, if your pull request contains patches or features, you must include relevant unit tests.

Editor preferences are available in the [editor config](.editorconfig) for easy use in common text editors. Read more and download plugins at <http://editorconfig.org>.



## Versioning

For transparency and insight into our release cycle, and for striving to maintain backward compatibility, mongoid-likeable will be maintained under the Semantic Versioning guidelines as much as possible. mongoid-likeable will not follow mongoid's version number.

Releases will be numbered with the following format:

`<major>.<minor>.<patch>`

And constructed with the following guidelines:

* Breaking backward compatibility bumps the major (and resets the minor and patch)
* New additions without breaking backward compatibility bumps the minor (and resets the patch)
* Bug fixes and misc changes bumps the patch

For more information on SemVer, please visit [http://semver.org/](http://semver.org/).



## Authors

**Geremia Taglialatela**

+ http://github.com/tagliala
+ http://twitter.com/gtagliala

**Cesidio Di Landa**

+ http://github.com/cesidio
+ http://twitter.com/cesid



## Copyright and license

Copyright 2014 diowa under [the BSD 2-Clause license](LICENSE).

mongoid-voteable is licensed under the MIT License - Copyright (c) 2012 Tom Bell
