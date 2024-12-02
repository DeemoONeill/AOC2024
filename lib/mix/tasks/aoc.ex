defmodule Mix.Tasks.Aoc do
  @moduledoc "creates a new scaffold for an advent of code problem"

  use Mix.Task

  @impl Mix.Task
  def run(args) do
    case args do
      ["run", day, "py"] ->
        Mix.shell().cmd("python3 lib/day#{day}.py")

      ["run", day] ->
        Mix.shell().cmd("mix run -e Day#{day}.main()")

      ["test", day] ->
        Mix.shell().cmd("mix test test/day#{day}_test.exs")

      [day] ->
        create_day(day)

      _ ->
        Mix.raise("Invalid arguments")
    end
  end

  def create_day(day) do
    input_file = "inputs/day#{day}.txt"

    unless File.exists?(input_file) or Date.utc_today().day < String.to_integer(day) do
      cookie = System.get_env("AOC_COOKIE")

      unless cookie do
        raise "AOC_COOKIE environment variable not set"
      end

      HTTPoison.start()

      HTTPoison.get!("https://adventofcode.com/2024/day/#{day}/input",
        Cookie: cookie
      )
      |> tap(fn %{body: body} -> File.write!(input_file, body |> String.trim()) end)
    end

    lib_file = "lib/day#{day}.ex"

    unless File.exists?(lib_file) do
      File.write("lib/day#{day}.ex", """
      defmodule Day#{day} do
        # defstruct

        def main() do
          _data = File.read!(\"inputs/day#{day}.txt\") |> IO.inspect(label: \"part 1\")
        end
        def part1(_data) do
        end

        def part2(_data) do
        end
      end
      """)
    end

    test_file = "test/day#{day}_test.exs"

    unless File.exists?(test_file) do
      File.write("test/day#{day}_test.exs", """
      defmodule Day#{day}Test do
        use ExUnit.Case

        #@example ""

        test \"\" do
          assert true
        end
      end

      """)
    end

    test_file = "test/day#{day}_test.exs"

    unless File.exists?(test_file) do
      File.write("test/day#{day}_test.exs", """
          defmodule Aoc.Day#{day}Test do\n
            use ExUnit.Case\n end
      """)
    end
  end
end
