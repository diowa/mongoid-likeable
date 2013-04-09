require 'mongoid'

module Mongoid
  module Likeable

    extend ActiveSupport::Concern

    included do
      LIKEABLE_MUTEX = Mutex.new

      field :likes, type: Integer, default: 0
      field :likers, type: Array, default: []
    end

    def like(liker)
      id = liker_id(liker)
      return if liked? id
      LIKEABLE_MUTEX.synchronize do
        inc :likes, 1
        push :likers, id
        touch
      end
    end

    def unlike(liker)
      id = liker_id(liker)
      return unless liked? id
      LIKEABLE_MUTEX.synchronize do
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
