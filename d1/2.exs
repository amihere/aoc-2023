defmodule DayOne do
  def readlines(filepath) do
    case File.read(filepath) do
      {:ok, contents} ->
        contents
        |> String.split("\n")
    end
  end

  def helper(line) do
    Regex.replace(~r/\D/, line, "") |> addFirstAndLast |> String.to_integer()
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

  def replace_with_digit(line, result) when line == "" do
    result
  end

  def replace_with_digit(line, result) do
    word =
      for {x, y} <- number_list(),
          val = String.replace_prefix(line, x, y),
          val != line,
          into: [],
          do: x

    case word do
      [] ->
        replace_with_digit(String.slice(line, 1..-1), result)

      [h | _] ->
        new_val = number_list()[h]
        new_line = String.replace(line, String.slice(h, 0..-2), new_val)

        replace_with_digit(
          String.slice(new_line, 1..-1),
          String.replace(result, String.slice(h, 0..-2), new_val)
        )
    end
  end

  def number_list() do
    %{
      "one" => "1",
      "two" => "2",
      "three" => "3",
      "four" => "4",
      "five" => "5",
      "six" => "6",
      "seven" => "7",
      "eight" => "8",
      "nine" => "9"
    }
  end

  def run do
    readlines("input.txt")
    |> Enum.map(&replace_with_digit(&1, &1))
    |> Enum.map(&helper(&1))
    |> Enum.reduce(fn x, acc -> x + acc end)
    |> IO.puts()
  end
end

DayOne.run()
