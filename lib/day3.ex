defmodule Day3 do
  @mul_regex ~r"mul\((\d{1,3}),(\d{1,3})\)"

  def main() do
    _data = File.read!("inputs/day3.txt") |> part1 |> IO.inspect(label: "part 1")
    _data = File.read!("inputs/day3.txt") |> part2 |> IO.inspect(label: "part 2")
  end

  def part1(data) do
    @mul_regex
    |> Regex.scan(data)
    |> Enum.map(fn [_match, a, b] -> String.to_integer(a) * String.to_integer(b) end)
    |> Enum.sum()
  end

  def part2(data) do
    scan_string(data, :do, 0)
  end

  def scan_string(string, on, acc)

  def scan_string(<<>>, _, acc), do: acc

  def scan_string(<<"mul(", next::binary>> = string, :do, acc) do
    len_str = String.length(string)
    <<possible_match::binary-size(min(13, len_str)), _::binary>> = string

    tot =
      case Regex.run(@mul_regex, possible_match) do
        [_match, a, b] -> String.to_integer(a) * String.to_integer(b)
        _ -> 0
      end

    scan_string(next, :do, tot + acc)
  end

  def scan_string(<<"don't()", rest::binary>>, :do, acc) do
    scan_string(rest, :dont, acc)
  end

  def scan_string(<<"do()", rest::binary>>, :dont, acc) do
    scan_string(rest, :do, acc)
  end

  def scan_string(<<_::binary-size(1), rest::binary>>, on, acc) do
    scan_string(rest, on, acc)
  end
end
