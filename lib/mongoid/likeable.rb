require 'mongoid'

module Mongoid
  module Likeable

    extend ActiveSupport::Concern

    included do
      field :likes, type: Integer, default: 0
      field :likers, type: Array, default: []
    end

    def like(liker)
      id = liker_id(liker)
      return if liked? id
      push likers: id
      update_likers
    end

    def unlike(liker)
      id = liker_id(liker)
      return unless liked? id
      pull likers: id
      update_likers
    end

    def liked?(liker)
      id = liker_id(liker)
      likers.include?(id)
    end

    private
    def liker_id(liker)
      if liker.respond_to?(:_id)
        liker._id
      else
        liker
      end
    end

    def update_likers
      update_attribute :likes, likers.size
    end
  end
end
