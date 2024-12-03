defmodule Day3Test do
  use ExUnit.Case

  @example "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

  test "part 1 is 161" do
    assert @example |> Day3.part1() == 161
  end

  test "part 2 is 48" do
    assert @example |> Day3.part2() == 48
  end
end
