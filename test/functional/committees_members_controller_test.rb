require 'test_helper'

class CommitteesMembersControllerTest < ActionController::TestCase
  setup do
    @committee_members = committees_members(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:committees_members)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create committee_members" do
    assert_difference('CommitteeMembers.count') do
      post :create, committee_members: { email: @committee_members.email, name: @committee_members.name }
    end

    assert_redirected_to committee_members_path(assigns(:committee_members))
  end

  test "should show committee_members" do
    get :show, id: @committee_members
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @committee_members
    assert_response :success
  end

  test "should update committee_members" do
    put :update, id: @committee_members, committee_members: { email: @committee_members.email, name: @committee_members.name }
    assert_redirected_to committee_members_path(assigns(:committee_members))
  end

  test "should destroy committee_members" do
    assert_difference('CommitteeMembers.count', -1) do
      delete :destroy, id: @committee_members
    end

    assert_redirected_to committees_members_path
  end
end
