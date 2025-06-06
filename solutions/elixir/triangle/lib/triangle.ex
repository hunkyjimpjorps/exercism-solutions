defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  defguardp invalid_inequality(a, b, c)
            when a + b <= c or
                   b + c <= a or
                   a + c <= b

  defguardp invalid_sides(a, b, c) when a <= 0 or b <= 0 or c <= 0

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}

  def kind(a, b, c) when invalid_sides(a, b, c),
    do: {:error, "all side lengths must be positive"}

  def kind(a, b, c) when invalid_inequality(a, b, c),
    do: {:error, "side lengths violate triangle inequality"}

  def kind(a, b, c) do
    case [a, b, c] |> Enum.uniq() |> Enum.count() do
      1 -> {:ok, :equilateral}
      2 -> {:ok, :isosceles}
      3 -> {:ok, :scalene}
    end
  end
end
