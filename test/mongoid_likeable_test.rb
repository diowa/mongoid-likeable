require 'test_helper'

class TestMongoidLikeable < MiniTest::Unit::TestCase
  def setup
    DatabaseCleaner.start

    @simon = User.create name: 'Simon'
    @emily = User.create name: 'Emily'
    @story = Story.create name: 'Mongoid Rocks'
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_add_likers_field_to_document
    refute_nil Story.fields['likers']
  end

  def test_defines_like_method
    story = Story.new
    refute_nil story.respond_to?('like')
  end

  def test_defines_unlike_method
    story = Story.new
    refute_nil story.respond_to?('unlike')
  end

  def test_defines_liked_method
    story = Story.new
    refute_nil story.respond_to?('liked?')
  end

  def test_defines_like_count_method
    story = Story.new
    refute_nil story.respond_to?('like_count')
  end

  def test_tracks_number_of_likers
    @story.like @simon
    @story.like @emily
    assert_equal 2, @story.like_count
  end

  def test_can_like_by_user_id
    @story.like @simon._id
    assert_equal 1, @story.like_count
  end

  def test_can_like_by_user
    @story.like @simon
    assert_equal 1, @story.like_count
  end

  def test_can_unlike_by_user
    @story.like @simon
    assert_equal 1, @story.like_count
    @story.unlike @simon
    assert_equal 0, @story.like_count
  end

  def test_limits_one_like_per_liker
    @story.like @simon
    @story.like @simon
    assert_equal 1, @story.like_count
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
    assert_equal 2, story.like_count
    assert story.liked? @simon
    assert story.liked? @emily
    story.unlike @simon
    story = Story.where(:name => 'Mongoid Rocks').first
    assert_equal 1, story.like_count
    refute story.liked? @simon
    assert story.liked? @emily
  end
end
