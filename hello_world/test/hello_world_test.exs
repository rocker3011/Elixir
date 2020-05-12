defmodule HelloWorldTest do
  use ExUnit.Case
  doctest HelloWorld

  test "greets the world" do
    assert String.equivalent?(HelloWorld.hello(),"Hello World")
  end
end
