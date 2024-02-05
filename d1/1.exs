defmodule DayOne do
  def readlines(filepath) do
    case File.read(filepath) do
      {:ok, contents} ->
        contents
        |> String.split("\n")
    end
  end

  def helper(line) do
    Regex.replace(~r/\D/, line, "") |> addFirstAndLast |> String.to_integer
  end

  def addFirstAndLast(line) do
    case String.length(line) do
      0 -> "0"
      _ -> adder(line, String.reverse(line))
    end
  end

  def adder(first, second) do
    String.first(first) <> String.first(second)
  end

  def run do
    readlines("input.txt")
    |> Enum.map(&helper(&1))
    |> Enum.reduce(fn x, acc -> x + acc end)
    |> IO.puts()
  end
end

DayOne.run()
