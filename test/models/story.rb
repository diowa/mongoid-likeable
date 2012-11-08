class Story
  include Mongoid::Document
  include Mongoid::Likeable

  field :name
end
