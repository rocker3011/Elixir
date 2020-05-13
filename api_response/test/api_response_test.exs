defmodule ApiResponseTest do
  use ExUnit.Case
  doctest ApiResponse

  test "IF" do
    assert ApiResponse.handle_response_if({:ok, %{"blabla" => "lel"}}) == "OK"
    assert ApiResponse.handle_response_if({:error, %{"blabla" => "lel"}}) == "Error"
    assert ApiResponse.handle_response_if({:what,%{"blabla" => "lel"}}) ==  :no_match_message_error
  end
  test "CASE" do
    assert ApiResponse.handle_response_case({:ok,%{"blabla" => "lel"}}) == "OK"
    assert ApiResponse.handle_response_case({:error, %{"blabla" => "lel"}}) == "Error"
    assert ApiResponse.handle_response_case({:what, %{"blabla" => "lel"}}) ==  :no_match_message_error
  end
  test "COND" do
    assert ApiResponse.handle_response_cond({:ok,%{"blabla" => "lel"}}) == "OK"
    assert ApiResponse.handle_response_cond({:error, %{"blabla" => "lel"}}) == "Error"
    assert ApiResponse.handle_response_cond({:what, %{"blabla" => "lel"}}) ==  :no_match_message_error
  end
  test "PURE FUNCTION" do
    assert ApiResponse.handle_response_recur({:ok, %{"blabla" => "lel"}}) == "OK"
    assert ApiResponse.handle_response_recur({:error, %{"blabla" => "lel"}}) == "Error"
    assert ApiResponse.handle_response_recur({:what, %{"blabla" => "lel"}}) ==  :no_match_message_error
  end
end
