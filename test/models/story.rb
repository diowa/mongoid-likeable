# frozen_string_literal: true

class Story
  include Mongoid::Document
  include Mongoid::Likeable

  field :name
end
