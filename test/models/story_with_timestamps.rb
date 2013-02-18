class StoryWithTimestamps
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Likeable

  field :name
end
