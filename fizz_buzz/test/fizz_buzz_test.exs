defmodule FizzBuzzTest do
  use ExUnit.Case
  doctest FizzBuzz

  test "greets the world" do
    assert FizzBuzz.fuzzle(0,0,1) == "FizzBuzz"
    assert FizzBuzz.fuzzle(1,0,1) == "Buzz"
    assert FizzBuzz.fuzzle(0,1,1) == "Fizz"
    assert FizzBuzz.fuzzle(1,1,1) == 1
  end
end
