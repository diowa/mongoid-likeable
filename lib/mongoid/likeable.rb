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
        self.inc :likes, 1
        self.push :likers, id
        self.touch
      end
    end

    def unlike(liker)
      id = liker_id(liker)
      if liked?(id)
        self.inc :likes, -1
        self.pull :likers, id
        self.touch
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
