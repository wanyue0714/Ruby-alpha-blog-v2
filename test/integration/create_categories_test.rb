require './test/test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  test "get new category form and create category" do
    # first get new category path
    get new_category_path

    # assert the new template page
    assert_template 'categories/new'

    # actually get the params and post it on the index page
    assert_difference 'Category.count', 1 do
      post categories_path, params:{ category: {name:"sports"}}
      follow_redirect!
    end

    # where do we go after send the params
    assert_template 'categories/index'

    # ensure the name is displayed
    assert_match "sports", response.body
  end
end