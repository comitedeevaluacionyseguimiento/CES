require 'test_helper'

class AprendicesControllerTest < ActionController::TestCase
  setup do
    @aprendiz = aprendices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:aprendices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create aprendiz" do
    assert_difference('Aprendiz.count') do
      post :create, aprendiz: { ficha: @aprendiz.ficha, name: @aprendiz.name, num_document: @aprendiz.num_document }
    end

    assert_redirected_to aprendiz_path(assigns(:aprendiz))
  end

  test "should show aprendiz" do
    get :show, id: @aprendiz
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @aprendiz
    assert_response :success
  end

  test "should update aprendiz" do
    put :update, id: @aprendiz, aprendiz: { ficha: @aprendiz.ficha, name: @aprendiz.name, num_document: @aprendiz.num_document }
    assert_redirected_to aprendiz_path(assigns(:aprendiz))
  end

  test "should destroy aprendiz" do
    assert_difference('Aprendiz.count', -1) do
      delete :destroy, id: @aprendiz
    end

    assert_redirected_to aprendices_path
  end
end
