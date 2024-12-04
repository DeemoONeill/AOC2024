defmodule Day4 do
  @up_left [0, 1, 2, 3]
  @down_right [0, -1, -2, -3]
  @xmas ~w"X M A S"

  def main() do
    data = File.read!("inputs/day4.txt") |> AOC.parse_grid()

    data |> part1 |> IO.inspect(label: "part 1")
    data |> part2 |> IO.inspect(label: "part 2")
  end

  def part1(grid) do
    grid
    |> Enum.filter(fn {_key, value} -> value == "X" end)
    |> Enum.map(&check_for_xmas(elem(&1, 0), grid))
    |> List.flatten()
    |> Enum.filter(& &1)
    |> Enum.count()
  end

  def part2(grid) do
    grid
    |> Enum.filter(fn {_key, value} -> value == "A" end)
    |> Enum.map(&check_for_x_mas(elem(&1, 0), grid))
    |> Enum.filter(& &1)
    |> Enum.count()
  end

  def check_for_xmas(starting_coord, grid) do
    [
      check_horizontal(starting_coord, grid),
      check_vertical(starting_coord, grid),
      check_diag(starting_coord, grid)
    ]
  end

  def check_horizontal({y, x}, grid) do
    [
      Enum.map(@up_left, fn offset -> grid[{y, x + offset}] end) == @xmas,
      Enum.map(@down_right, fn offset -> grid[{y, x + offset}] end) == @xmas
    ]
  end

  def check_vertical({y, x}, grid) do
    [
      Enum.map(@up_left, fn offset -> grid[{y + offset, x}] end) == @xmas,
      Enum.map(@down_right, fn offset -> grid[{y + offset, x}] end) == @xmas
    ]
  end

  def check_diag({y, x}, grid) do
    [
      Enum.map(@up_left, fn offset -> grid[{y + offset, x + offset}] end) == @xmas,
      Enum.map(@up_left, fn offset -> grid[{y - offset, x + offset}] end) == @xmas,
      Enum.map(@down_right, fn offset -> grid[{y + offset, x + offset}] end) == @xmas,
      Enum.map(@down_right, fn offset -> grid[{y - offset, x + offset}] end) == @xmas
    ]
  end

  def check_for_x_mas({y, x}, grid) do
    [bottom_right, top_left, top_right, bottom_left] = [
      grid[{y + 1, x + 1}],
      grid[{y - 1, x - 1}],
      grid[{y - 1, x + 1}],
      grid[{y + 1, x - 1}]
    ]

    [bottom_right, top_left, top_right, bottom_left]
    |> Enum.sort() == ~w"M M S S" and top_left != bottom_right
  end
end
