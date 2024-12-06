defmodule Day6Test do
  use ExUnit.Case

  @example "
  ....#.....
  .........#
  ..........
  ..#.......
  .......#..
  ..........
  .#..^.....
  ........#.
  #.........
  ......#..."

  test "" do
    assert @example |> Day6.part1() == 41
  end

  test "r" do
    assert @example |> Day6.part2() == 6
  end
end
