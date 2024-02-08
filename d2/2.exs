defmodule DayTwo do
  def readlines(filepath) do
    case File.read(filepath) do
      {:ok, contents} ->
        contents
        |> String.trim()
        |> String.split("\n")
    end
  end

  def create_game(line) do
    {_, readable} = String.split_at(line, 5)
    {_id, ": " <> rest} = Integer.parse(readable)

    games = String.split(rest, ";")

    for game <- games, split = String.split(game, ", "), reduce: %{} do
      acc ->
        parse_game(split, acc)
    end
  end

  def parse_game(split, acc) when split == [] do
    acc
  end

  def parse_game(split, acc) when is_list(split) do
    [h | t] = split
    acc = parse_game(h, acc)
    parse_game(t, acc)
  end

  def parse_game(split, acc) when is_binary(split) do
    {number, " " <> color} = String.trim(split) |> Integer.parse()
    color = String.first(color) |> String.to_atom()

    Map.update(acc, color, number, fn val -> max(val, number) end)
  end

  def run do
    readlines("input.txt")
    |> Enum.map(&create_game(&1))
    |> Enum.reduce(0, fn bag, prod -> prod + (bag.r * bag.g * bag.b) end)
    |> IO.inspect
    # |> Enum.sum

    # |> Enum.sum
  end
end

DayTwo.run()
