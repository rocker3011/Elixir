defmodule EnumOperations do
  def count([]) do
    0
  end

  def count(list) do
      [_head | tail] = list
      count(tail) + 1
  end

  def concat(left,right) do
    if(left == []) do
      right
    else
      [head | tail] = left
      [head | concat(tail,right)]
    end
  end

  def reverse(list) do
    if (list==[]) do
      []
    else
      [head | tail] = list
      concat(reverse(tail),[head])
    end
  end

  def filter(list,foo) do
    if(list ==[]) do
      []
    else
      [head | tail] = list
      if foo.(head) , do: [ head | filter(tail,foo)], else: filter(tail,foo)
    end

  end

end
