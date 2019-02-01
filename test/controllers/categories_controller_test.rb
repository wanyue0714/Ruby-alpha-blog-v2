require './test/test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: "Sport")
    @user = User.create(username: "test", email: "test@gmail.com", password: "passwordoftest", admin: true)
  end

  # test list categories path
  test "should get categories index" do
    get categories_path
    assert_response :success
  end

  # test new category path
  test "should get new" do
    sign_in_as(@user, "passwordoftest")
    get new_category_path
    assert_response :success
  end

  # test show category path
  test "should get show" do
    get category_path(@category)
    assert_response :success
  end

  test "should redirect create when admin not logged in" do
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: "sports" } }
    end
    assert_redirected_to categories_path
  end

end