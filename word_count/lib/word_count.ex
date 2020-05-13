defmodule WordCount do
  def count(phrase) do
    tokens = String.downcase(phrase)
    |> String.split(" ")
    Enum.frequencies(tokens)
  end
end
