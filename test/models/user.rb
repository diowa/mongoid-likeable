class User
  include Mongoid::Document
  include Mongoid::Voteable

  field :name
end
