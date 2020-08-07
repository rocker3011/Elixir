defmodule AwsBucketTest do
  use ExUnit.Case
  doctest AwsBucket

  test "greets the world" do
    assert AwsBucket.hello() == :world
  end
end
