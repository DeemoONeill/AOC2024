defmodule AOC do
  def parse_grid(lines) when is_binary(lines) do
    lines |> String.split() |> parse_grid
  end

  def parse_grid(lines) when is_list(lines) do
    lines
    |> Enum.with_index()
    |> Enum.reduce(
      %{},
      fn {row, y}, map ->
        row
        |> String.graphemes()
        |> Enum.with_index()
        |> Map.new(fn {item, x} -> {{y, x}, item} end)
        |> Map.merge(map)
      end
    )
  end

  def parse_grid(lines, splitter) when is_binary(lines) and is_binary(splitter) do
    lines |> String.split(splitter, trim: true) |> parse_grid
  end
end
