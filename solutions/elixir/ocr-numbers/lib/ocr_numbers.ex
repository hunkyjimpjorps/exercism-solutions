defmodule OcrNumbers do
  @doc """
  Given a 3 x 4 grid of pipes, underscores, and spaces, determine which number is represented, or
  whether it is garbled.
  """

  @numbers [
             " _     _  _     _  _  _  _  _ ",
             "| |  | _| _||_||_ |_   ||_||_|",
             "|_|  ||_  _|  | _||_|  ||_| _|",
             "                              "
           ]
           |> Enum.map(&(String.to_charlist(&1) |> Enum.chunk_every(3)))
           |> Enum.zip()
           |> Enum.zip(0..9)
           |> Enum.into(%{})

  @spec convert([String.t()]) :: {:ok, String.t()} | {:error, charlist()}
  def convert(input) when rem(length(input), 4) != 0 do
    {:error, 'invalid line count'}
  end

  def convert([head | _]) when rem(byte_size(head), 3) != 0 do
    {:error, 'invalid column count'}
  end

  def convert(input) do
    input
    |> Enum.chunk_every(4)
    |> Enum.map(fn line ->
      line
      |> Enum.map(&(String.to_charlist(&1) |> Enum.chunk_every(3)))
      |> Enum.zip()
      |> Enum.map(&Map.get(@numbers, &1, "?"))
      |> Enum.join()
    end)
    |> Enum.join(",")
    |> then(&{:ok, &1})
  end
end
