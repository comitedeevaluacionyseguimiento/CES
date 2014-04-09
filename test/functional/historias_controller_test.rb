require 'test_helper'

class HistoriasControllerTest < ActionController::TestCase
  setup do
    @historia = historias(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:historias)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create historia" do
    assert_difference('Historia.count') do
      post :create, historia: { llamada_atencion: @historia.llamada_atencion, tipo_recomendacion: @historia.tipo_recomendacion }
    end

    assert_redirected_to historia_path(assigns(:historia))
  end

  test "should show historia" do
    get :show, id: @historia
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @historia
    assert_response :success
  end

  test "should update historia" do
    put :update, id: @historia, historia: { llamada_atencion: @historia.llamada_atencion, tipo_recomendacion: @historia.tipo_recomendacion }
    assert_redirected_to historia_path(assigns(:historia))
  end

  test "should destroy historia" do
    assert_difference('Historia.count', -1) do
      delete :destroy, id: @historia
    end

    assert_redirected_to historias_path
  end
end
