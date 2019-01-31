require './test/test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest

  # create two objs for test
  def setup
    @category1 = Category.create(name: "programming")
    @category2 = Category.create(name: "decoration")
  end


  test "should list all the categories" do
    # first get the index path
    get categories_path
    # assert the index page
    assert_template 'categories/index'
    assert_select "a[href=?]", category_path(@category1), text: @category1.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name
  end

end