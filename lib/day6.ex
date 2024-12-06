defmodule Day6 do
  @up {-1, 0}

  def main() do
    _data = File.read!("inputs/day6.txt") |> part1 |> IO.inspect(label: "part 1")
    _data = File.read!("inputs/day6.txt") |> part2 |> IO.inspect(label: "part 2")
  end

  def part1(data) do
    data |> AOC.parse_grid() |> move_guard |> elem(1) |> MapSet.size()
  end

  def part2(data) do
    grid = AOC.parse_grid(data)
    {guard_location, test_positions} = move_guard(grid)

    test_positions
    |> MapSet.difference(MapSet.new([guard_location]))
    |> Stream.map(fn test_position -> Map.put(grid, test_position, "#") end)
    |> Task.async_stream(&guard_cycle(guard_location, @up, &1, MapSet.new()))
    |> Stream.filter(&(&1 |> elem(1)))
    |> Enum.count()
  end

  def move_guard(grid) do
    guard_loc =
      grid
      |> Enum.filter(fn
        {_, "^"} -> true
        _ -> false
      end)
      |> hd
      |> elem(0)

    {guard_loc, move_guard(guard_loc, @up, grid, MapSet.new())}
  end

  def move_guard({gy, gx} = guard_loc, {movey, movex} = direction, grid, seen) do
    next_location = {gy + movey, gx + movex}

    case grid[next_location] do
      nil -> MapSet.put(seen, guard_loc)
      "#" -> move_guard(guard_loc, {movex, -movey}, grid, MapSet.put(seen, guard_loc))
      _ -> move_guard(next_location, direction, grid, MapSet.put(seen, guard_loc))
    end
  end

  def guard_cycle({gy, gx} = guard_loc, {movey, movex} = direction, grid, seen) do
    next_location = {gy + movey, gx + movex}

    case {grid[next_location], MapSet.member?(seen, {next_location, direction})} do
      {_, true} ->
        true

      {nil, _} ->
        false

      {"#", _} ->
        guard_cycle(guard_loc, {movex, -movey}, grid, MapSet.put(seen, {guard_loc, direction}))

      _ ->
        guard_cycle(next_location, direction, grid, MapSet.put(seen, {guard_loc, direction}))
    end
  end
end
