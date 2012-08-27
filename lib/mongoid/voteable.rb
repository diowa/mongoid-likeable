require 'mongoid'

module Mongoid
  module Voteable

    extend ActiveSupport::Concern

    included do
      field :votes, :type => Integer, :default => 0
      field :voters, :type => Array, :default => []
    end

    def vote(amount, voter_id)
      unless voted?(voter_id)
        self.inc :votes, amount.to_i
        self.push :voters, voter_id
      end
    end

    def voted?(voter_id)
      voters.include?(voter_id)
    end

    def vote_count
      voters.count
    end
  end

end
