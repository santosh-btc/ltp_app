require 'test_helper'

class InsightsControllerTest < ActionController::TestCase
  setup do
    @insight = insights(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:insights)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create insight" do
    assert_difference('Insight.count') do
      post :create, insight: { article_text: @insight.article_text, posted_at: @insight.posted_at, posted_by: @insight.posted_by, title: @insight.title }
    end

    assert_redirected_to insight_path(assigns(:insight))
  end

  test "should show insight" do
    get :show, id: @insight
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @insight
    assert_response :success
  end

  test "should update insight" do
    patch :update, id: @insight, insight: { article_text: @insight.article_text, posted_at: @insight.posted_at, posted_by: @insight.posted_by, title: @insight.title }
    assert_redirected_to insight_path(assigns(:insight))
  end

  test "should destroy insight" do
    assert_difference('Insight.count', -1) do
      delete :destroy, id: @insight
    end

    assert_redirected_to insights_path
  end
end
