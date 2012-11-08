require 'mongoid'

module Mongoid
  module Likeable

    extend ActiveSupport::Concern

    included do
      field :likers, :type => Array, :default => []
    end

    def like(liker)
      id = liker_id(liker)
      unless liked?(id)
        self.push :likers, id
      end
    end

    def unlike(liker)
      id = liker_id(liker)
      if liked?(id)
        self.pull :likers, id
      end
    end

    def liked?(liker)
      id = liker_id(liker)
      likers.include?(id)
    end

    def like_count
      likers.count
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
