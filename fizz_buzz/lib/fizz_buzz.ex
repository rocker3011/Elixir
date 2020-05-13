defmodule FizzBuzz do
  def fuzzle(a,b,c) do
    cond do
      a == 0 and b == 0 -> "FizzBuzz"
      a == 0 -> "Fizz"
      b == 0 -> "Buzz"
      c -> c
    end
  end
end
