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
      push_liker(id)
      update_likers
    end

    def unlike(liker)
      id = liker_id(liker)
      return unless liked? id
      pull_liker(id)
      update_likers
    end

    def liked?(liker)
      id = liker_id(liker)
      likers.include?(id)
    end

    private
    def push_liker(id)
      if Mongoid::VERSION.start_with?("3.")
        push :likers, id
      else
        push likers: id
      end
    end

    def pull_liker(id)
      if Mongoid::VERSION.start_with?("3.")
        pull :likers, id
      else
        pull likers: id
      end
    end

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
