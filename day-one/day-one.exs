defmodule DayOne do
  def readlines(filepath) do
    case File.read(filepath) do
      {:ok, contents} ->
        contents
        |> String.split("\n")
    end
  end

  def sum_numbers(list) do
    hd(list) + List.last(list)
  end

  def get_numbers(list) do
    Regex.scan(~r/\d/, list) |> List.flatten() |> Enum.map(&parse_number(&1))
  end

  def parse_number(val) do
    case Integer.parse(val) do
      {x, ""} -> x
      _ -> 0
    end
  end

  def run do
    # |> get_numbers |> IO.puts
    readlines("input-3.txt") |> Enum.map(&get_numbers(&1)) |> Enum.reduce(fn x, acc -> x + acc end)
  end
end

DayOne.run()
