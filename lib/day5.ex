defmodule Day5 do
  @empty_set MapSet.new()

  def parse(data) do
    [ordering, page_lists] = String.split(data, "\n\n")

    ordering =
      ordering
      |> String.split("\n")
      |> Enum.map(&String.split(&1, "|"))
      |> Enum.reduce(%{}, fn [key, value], map ->
        Map.update(map, key, MapSet.put(@empty_set, value), fn set ->
          MapSet.put(set, value)
        end)
      end)

    pages = page_lists |> String.split("\n") |> Enum.map(&String.split(&1, ","))

    {ordering, pages}
  end

  def main() do
    _data = File.read!("inputs/day5.txt") |> parse() |> part1() |> IO.inspect(label: "part 1")
    _data = File.read!("inputs/day5.txt") |> parse() |> part2() |> IO.inspect(label: "part 2")
  end

  def part1({ordering, pages}) do
    pages
    |> Stream.filter(&(check_pages(&1, ordering) != false))
    |> Stream.map(&get_center/1)
    |> Enum.sum()
  end

  def part2({ordering, pages}) do
    pages
    |> Stream.filter(&(check_pages(&1, ordering) == false))
    |> Stream.map(&sort_pages(&1, ordering))
    |> Stream.map(&get_center/1)
    |> Enum.sum()
  end

  def check_pages(page_list, ordering) do
    page_list
    |> Enum.reduce_while({@empty_set, @empty_set}, fn page, {seen, expected} ->
      after_this = Map.get(ordering, page, @empty_set)

      unless MapSet.intersection(after_this, seen) == @empty_set do
        {:halt, false}
      else
        {:cont, {MapSet.put(seen, page), MapSet.union(expected, after_this)}}
      end
    end)
  end

  def sort_pages(page_list, ordering) do
    page_list |> Enum.sort(fn a, b -> Map.get(ordering, a, @empty_set) |> MapSet.member?(b) end)
  end

  def get_center(pages) do
    centre_page = floor(length(pages) / 2)

    Enum.drop(pages, centre_page) |> hd |> String.to_integer()
  end
end
