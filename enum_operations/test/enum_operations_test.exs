defmodule EnumOperationsTest do
  use ExUnit.Case
  doctest EnumOperations

  test "count" do
    assert EnumOperations.count([1,2,3,4,5]) == 5
    assert EnumOperations.count([]) == 0
    assert EnumOperations.count([1]) == 1
  end

  test "concat" do
    assert EnumOperations.concat([2,4,5], [3,4]) == [2,4,5,3,4]
  end

  test "reverse" do
    assert EnumOperations.reverse([1,2,3,4]) == [4,3,2,1]
  end

  test "filter" do
    assert EnumOperations.filter([1,2,3],(fn (odd) -> rem(odd,2) == 1 end)) == [1,3]
    assert EnumOperations.filter([1,2,3],(fn (even) -> rem(even,2) == 0 end)) == [2]
  end

end
