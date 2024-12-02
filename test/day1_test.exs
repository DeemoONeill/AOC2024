defmodule Day1Test do
  use ExUnit.Case

  @example "3   4
4   3
2   5
1   3
3   9
3   3"

  test "example is 11" do
    assert @example |> Day1.part1() == 11
  end

  test "example part2 is 31" do
    assert @example |> Day1.part2() == 31
  end
end
