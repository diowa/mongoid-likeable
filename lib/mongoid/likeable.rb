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
      unless liked?(id)
        inc :likes, 1
        push :likers, id
        touch
      end
    end

    def unlike(liker)
      id = liker_id(liker)
      if liked?(id)
        inc :likes, -1
        pull :likers, id
        touch
      end
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
  end
end
