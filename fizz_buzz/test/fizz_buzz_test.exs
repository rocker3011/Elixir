defmodule FizzBuzzTest do
  use ExUnit.Case
  doctest FizzBuzz

  test "fuzzle case" do
    assert FizzBuzz.fuzzleCase(0,0,0) == "FizzBuzz"
    assert FizzBuzz.fuzzleCase(1,1,1) == 1
  end

  test "fuzzle cond" do
    assert FizzBuzz.fuzzleCase(0,0,0) == "FizzBuzz"
    assert FizzBuzz.fuzzleCase(1,1,1) == 1
  end
end
