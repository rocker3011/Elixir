defmodule ApiResponse do
  def handle_response_if({res,_}) do
    if res == :ok do
      "OK"
    else
      if res == :error do
        "Error"
      else
        :no_match_message_error
      end
    end
  end

  def handle_response_case({res,_}) do
    case {res} do
      {:ok} -> "OK"
      {:error} -> "Error"
      {_} -> :no_match_message_error
    end
  end

  def handle_response_cond({res,_}) do
    cond do
      res == :ok -> "OK"
      res == :error -> "Error"
      true -> :no_match_message_error
    end
  end

  def handle_response_recur({res,_}) when res == :ok  do
    "OK"
  end

  def handle_response_recur({res,_}) when res == :error  do
    "Error"
  end

  def handle_response_recur(_) do
    :no_match_message_error
  end

end
