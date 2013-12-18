require 'test_helper'

class BoltsControllerTest < ActionController::TestCase
  setup do
    @bolt = bolts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bolts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bolt" do
    assert_difference('Bolt.count') do
      post :create, bolt: { address: @bolt.address, description: @bolt.description, user_id: @bolt.user_id }
    end

    assert_redirected_to bolt_path(assigns(:bolt))
  end

  test "should show bolt" do
    get :show, id: @bolt
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bolt
    assert_response :success
  end

  test "should update bolt" do
    patch :update, id: @bolt, bolt: { address: @bolt.address, description: @bolt.description, user_id: @bolt.user_id }
    assert_redirected_to bolt_path(assigns(:bolt))
  end

  test "should destroy bolt" do
    assert_difference('Bolt.count', -1) do
      delete :destroy, id: @bolt
    end

    assert_redirected_to bolts_path
  end
end
