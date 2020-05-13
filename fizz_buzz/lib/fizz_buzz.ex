defmodule FizzBuzz do
  def fuzzleCond(a,b,c) do
    cond do
      a == 0 and b==0 -> "FizzBuzz"
      a == 0 -> "Fizz"
      b == 0 -> "Buzz"
      true -> c
    end
  end

  def fuzzleCase(a,b,c) do
    case {a,b,c} do
      {0,0,_} -> "FizzBuzz"
      {0,_,_} -> "Fizz"
      {_,0,_} -> "Buzz"
      _ -> c
    end
  end
end
