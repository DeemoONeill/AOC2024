defmodule Day2 do
  def main() do
    _data = File.read!("inputs/day2.txt") |> part1 |> IO.inspect(label: "part 1")
    _data = File.read!("inputs/day2.txt") |> part2 |> IO.inspect(label: "part 2")
  end

  def parse_nums(data) do
    data
    |> String.split("\n")
    |> Enum.map(fn nums -> String.split(nums) |> Enum.map(&String.to_integer(&1)) end)
  end

  def part1(data) do
    data |> parse_nums() |> Enum.filter(&check_safe/1) |> Enum.count()
  end

  def part2(data) do
    data |> parse_nums() |> Enum.filter(&check_safe2/1) |> Enum.count()
  end

  def check_safe(num_list) do
    diffs =
      Enum.chunk_every(num_list, 2, 1, :discard)
      |> Enum.map(fn [a, b] -> a - b end)

    case hd(diffs) do
      num when num < 0 -> Enum.all?(diffs, fn item -> item < 0 and item > -4 end)
      num when num > 0 -> Enum.all?(diffs, fn item -> item > 0 and item < 4 end)
      _ -> false
    end
  end

  def check_safe2(num_list) do
    check_safe(num_list) or dampener(num_list)
  end

  def dampener(num_list) do
    0..length(num_list)
    |> Enum.reduce_while(false, fn index, _ ->
      start = Enum.take(num_list, index)
      end_ = Enum.drop(num_list, index + 1)

      if(check_safe(start ++ end_)) do
        {:halt, true}
      else
        {:cont, false}
      end
    end)
  end
end
