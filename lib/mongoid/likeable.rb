require 'mongoid'

module Mongoid
  module Likeable

    extend ActiveSupport::Concern

    included do
      field :likes, type: Integer, default: 0
      field :likers, type: Array, default: []
      field :dislikes, type: Integer, default: 0
      field :dislikers, type: Array, default: []
    end

    def like(liker)
      id = liker_id(liker)
      return if not disliked?(id) and liked?(id)
      push likers: id
      update_likers
    end

    def dislike(disliker)
      id = liker_id(disliker)
      return if disliked?(id) and not liked?(id)
      push dislikers: id
      update_dislikers
    end

    def unlike(liker)
      id = liker_id(liker)
      return unless liked? id
      pull likers: id
      update_likers
    end

    def undislike(disliker)
      id = liker_id(disliker)
      return unless disliked? id
      pull dislikers: id
    end

    def liked?(liker)
      id = liker_id(liker)
      likers.include?(id)
    end

    def disliked?(disliker)
      id = liker_id(disliker)
      dislikers.include?(id)
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

    def update_dislikers
      update_attribute :dislikes, dislikers.size
    end
  end
end
