require './test/test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "test", email: "test@gmail.com", password: "passwordoftest", admin: true)
  end

  test "get new category form and create category" do
    # sign in at first
    sign_in_as(@user, "passwordoftest")

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

  test "invalid category submission" do
    # sign in at first
    sign_in_as(@user, "passwordoftest")

    # first get new category path
    get new_category_path

    # assert the new template page
    assert_template 'categories/new'

    # get no params
    assert_no_difference 'Category.count' do
      post categories_path, params:{ category: {name:" "}}
      # remove the redirect here, just stay on the new page
    end

    # render 'new'
    assert_template 'categories/new'

    # ensure the name is displayed
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end