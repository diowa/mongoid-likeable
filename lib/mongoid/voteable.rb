require 'mongoid'

module Mongoid
  module Voteable

    extend ActiveSupport::Concern

    included do
      field :votes, :type => Integer, :default => 0
      field :voters, :type => Array, :default => []
    end

    def vote(amount, voter)
      id = voter_id(voter)
      unless voted?(id)
        self.inc :votes, amount.to_i
        self.push :voters, id
      end
    end

    def voted?(voter)
      id = voter_id(voter)
      voters.include?(id)
    end

    def vote_count
      voters.count
    end

    private

    def voter_id(voter)
      if voter.respond_to?(:_id)
        voter._id
      else
        voter
      end
    end
  end

end
