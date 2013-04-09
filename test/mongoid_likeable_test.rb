require 'test_helper'
require 'debugger'
require 'delorean'

class TestMongoidLikeable < MiniTest::Unit::TestCase
  def setup
    DatabaseCleaner.start

    @simon = User.create name: 'Simon'
    @emily = User.create name: 'Emily'
    @story = Story.create name: 'Mongoid Rocks'
    Delorean.time_travel_to(5.minutes.ago) { @story_with_timestamps = StoryWithTimestamps.create name: 'Mongoid Rocks' }
  end

  def teardown
    DatabaseCleaner.clean
    Delorean.back_to_the_present
  end

  def test_add_likes_field_to_document
    refute_nil Story.fields['likes']
  end

  def test_add_likers_field_to_document
    refute_nil Story.fields['likers']
  end

  def test_defines_like_method
    story = Story.new
    assert story.respond_to?('like')
  end

  def test_defines_unlike_method
    story = Story.new
    assert story.respond_to?('unlike')
  end

  def test_defines_liked_method
    story = Story.new
    assert story.respond_to?('liked?')
  end

  def test_tracks_number_of_likers
    @story.like @simon
    @story.like @emily
    assert_equal 2, @story.likes
  end

  def test_can_like_by_user_id
    @story.like @simon._id
    assert_equal 1, @story.likes
  end

  def test_can_like_by_user
    @story.like @simon
    assert_equal 1, @story.likes
  end

  def test_can_unlike_by_user
    @story.like @simon
    assert_equal 1, @story.likes
    @story.unlike @simon
    assert_equal 0, @story.likes
  end

  def test_limits_one_like_per_liker
    @story.like @simon
    @story.like @simon
    assert_equal 1, @story.likes
  end

  def test_successful_like_return_value
    assert_equal true, @story.like(@simon)
  end

  def test_failed_like_return_value
    @story.like @simon
    assert_equal nil, @story.like(@simon)
  end

  def test_knows_who_has_liked
    @story.like @simon
    assert @story.liked? @simon
    refute @story.liked? @emily
  end

  def test_updates_collection_correctly
    @story.like @simon
    @story.like @emily
    story = Story.where(:name => 'Mongoid Rocks').first
    assert_equal 2, story.likes
    assert story.liked? @simon
    assert story.liked? @emily
    story.unlike @simon
    story = Story.where(:name => 'Mongoid Rocks').first
    assert_equal 1, story.likes
    refute story.liked? @simon
    assert story.liked? @emily
  end

  def test_touches_updated_at_when_liking
    updated_at = @story_with_timestamps.updated_at
    Delorean.time_travel_to(1.month.from_now) { @story_with_timestamps.like @simon }
    assert @story_with_timestamps.updated_at > updated_at
  end

  def test_does_not_touche_updated_at_when_liking_without_success
    @story_with_timestamps.like @simon
    updated_at = @story_with_timestamps.updated_at
    Delorean.time_travel_to(1.month.from_now) { @story_with_timestamps.like @simon }
    assert @story_with_timestamps.updated_at == updated_at
  end

  def test_touches_updated_at_when_unliking
    @story_with_timestamps.like @simon
    updated_at = @story_with_timestamps.updated_at
    Delorean.time_travel_to(1.month.from_now) { @story_with_timestamps.unlike @simon }
    assert @story_with_timestamps.updated_at > updated_at
  end

  def test_does_not_touche_updated_at_when_unliking_without_success
    updated_at = @story_with_timestamps.updated_at
    Delorean.time_travel_to(1.month.from_now) { @story_with_timestamps.unlike @simon }
    assert @story_with_timestamps.updated_at == updated_at
  end

  def test_touches_updated_at_and_updates_collection_correctly
    updated_at = @story_with_timestamps.updated_at
    Delorean.time_travel_to(1.month.from_now) do
      @story_with_timestamps.like @simon
      @story_with_timestamps.like @emily
    end
    story = StoryWithTimestamps.where(:name => 'Mongoid Rocks').first
    assert_equal 2, story.likes
    assert story.liked? @simon
    assert story.liked? @emily
    assert story.updated_at > updated_at
    updated_at = @story_with_timestamps.updated_at
    Delorean.time_travel_to(1.month.from_now) do
      story.unlike @simon
    end
    story = StoryWithTimestamps.where(:name => 'Mongoid Rocks').first
    assert_equal 1, story.likes
    refute story.liked? @simon
    assert story.liked? @emily
    assert story.updated_at > updated_at
  end
end
