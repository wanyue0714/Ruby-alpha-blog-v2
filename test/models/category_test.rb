require './test/test_helper'

# model user ActiveSupport::TestCase
class CategoryTest < ActiveSupport::TestCase
  # run before test
  def setup
    @category = Category.new(name: "sports")
  end

  test "categories should be valid" do
    assert @category.valid?
  end

  test "name should be present" do
    @category.name = " "
    assert_not @category.valid?
  end

  test "name should be unique" do
    @category.save
    category2 = Category.new(name: "sports")
    assert_not category2.valid?
  end

  test "name should not be too long" do
    @category.name = "a"*26
    assert_not category2.valid?
  end

  test "name should not be too short" do
    @category.name = "aa"
    assert_not category2.valid?
  end

end