require 'test_helper'

class TestMongoidVoteable < MiniTest::Unit::TestCase
  def setup
    DatabaseCleaner.start

    @simon = User.create :name => 'Simon'
    @emily = User.create :name => 'Emily'
    @story = Story.create :name => 'Mongoid Rocks'
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_add_votes_field_to_document
    refute_nil User.fields['votes']
  end

  def test_add_voters_field_to_document
    refute_nil User.fields['voters']
  end

  def test_defines_vote_method
    story = Story.new
    refute_nil story.respond_to?('vote')
  end

  def test_defines_voted_method
    story = Story.new
    refute_nil story.respond_to?('voted?')
  end

  def test_defines_vote_count_method
    story = Story.new
    refute_nil story.respond_to?('vote_count')
  end

  def test_tracks_number_of_votes
    @story.vote 1, @simon._id
    @story.vote 1, @emily._id
    assert_equal 2, @story.votes
  end

  def test_limits_one_vote_per_voter
    @story.vote 1, @simon._id
    @story.vote 3, @simon._id
    assert_equal 1, @story.votes
  end

  def test_allows_negative_and_positive_votes
    @story.vote 1, @simon._id
    @story.vote -5, @emily._id
    assert_equal -4, @story.votes
  end

  def test_knows_who_has_voted
    @story.vote 5, @simon._id
    assert @story.voted?(@simon._id)
    refute @story.voted?(@emily._id)
  end

  def test_knows_how_many_votes_have_been_cast
    @story.vote 1, @simon._id
    @story.vote 10, @emily._id
    assert_equal 2, @story.vote_count
  end

  def test_updates_collection_correctly
    @story.vote 8, @simon._id
    @story.vote -10, @emily._id
    story = Story.where(:name => 'Mongoid Rocks').first
    assert_equal -2, story.votes
    assert story.voted?(@simon._id)
    assert story.voted?(@emily._id)
    assert_equal 2, story.vote_count
  end
end
