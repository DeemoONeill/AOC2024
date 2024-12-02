defmodule Day1 do
  def main() do
    _data = File.read!("inputs/day1.txt") |> part1 |> IO.inspect(label: "part 1")
    _data = File.read!("inputs/day1.txt") |> part2 |> IO.inspect(label: "part 2")
  end

  def parse_lists(data) do
    data
    |> String.trim()
    |> String.split("\n")
    |> Stream.map(&String.split/1)
    |> Enum.reduce(
      [[], []],
      fn
        [a, b], [first, second] ->
          [[String.to_integer(a) | first], [String.to_integer(b) | second]]
      end
    )
  end

  def part1(data) do
    data
    |> parse_lists()
    |> Stream.map(&Enum.sort/1)
    |> Stream.zip()
    |> Stream.map(fn {a, b} -> abs(a - b) end)
    |> Enum.sum()
  end

  def part2(data) do
    [first, second] = parse_lists(data)

    counts =
      second
      |> Enum.reduce(%{}, fn num, map ->
        Map.update(map, num, 1, &(&1 + 1))
      end)

    first
    |> Enum.reduce(0, fn num, acc ->
      acc + num * Map.get(counts, num, 0)
    end)
  end
end
