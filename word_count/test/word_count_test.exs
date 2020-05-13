defmodule WordCountTest do
  use ExUnit.Case
  doctest WordCount

  test "greets the world" do
    assert WordCount.count("Hello to all the world world") == %{"hello" => 1, "to" => 1, "all" => 1, "the" => 1, "world" => 2}
  end
end
