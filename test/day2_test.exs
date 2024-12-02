defmodule Day2Test do
  use ExUnit.Case

  @example "7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9"

  test "part1 is 2" do
    assert @example |> Day2.part1() == 2
  end

  test "part2 is 4" do
    assert @example |> Day2.part2() == 4
  end
end
