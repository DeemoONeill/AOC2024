defmodule Day4Test do
  use ExUnit.Case

  @example "MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
" |> AOC.parse_grid()

  test "part 1 has 18 xmas" do
    assert @example |> Day4.part1() == 18
  end

  test "part 2 has 9 mas crosses" do
    assert @example |> Day4.part2() == 9
  end
end
