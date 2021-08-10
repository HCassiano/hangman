require "test_helper"

class HangmanControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get hangman_index_url
    assert_response :success
  end
end
