defmodule DayTwo do
  def readlines(filepath) do
    case File.read(filepath) do
      {:ok, contents} ->
        contents
        |> String.split("\n")
    end
  end

  def config() do
    %{r: 12, g: 13, b: 14}
  end

  def create_game(line) when line != "" do
    [id | game] = String.split(line, ":")
    id = String.replace_prefix(id, "Game ", "") |> String.to_integer()
    config = config()

    [game | _] = game
    invalid = String.split(game, ";") |> Enum.any?(&check_number(&1, config))

    case invalid do
      false -> id
      _ -> 0
    end
  end

  def create_game(_) do
    0
  end

  def check_number(game, config) do
    colors = String.split(game, ",")

    Enum.any?(colors, fn color ->
      [number | rest] = String.trim(color) |> String.split(" ")
      number = String.to_integer(number)
      rest = List.first(rest) |> String.first()

      case rest do
        "g" -> number > config.g
        "r" -> number > config.r
        "b" -> number > config.b
      end
    end)
  end

  def run do
    readlines("input.txt")
    |> Enum.map(&create_game(&1))
    |> Enum.sum()
    |> IO.puts()
  end
end

DayTwo.run()
