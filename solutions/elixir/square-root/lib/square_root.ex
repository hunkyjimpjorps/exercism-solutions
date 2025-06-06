defmodule SquareRoot do
  @doc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(radicand) do
    do_calculate(radicand, radicand)
    |> round()
  end

  defp do_calculate(radicand, x0) do
    x1 = (x0 + radicand / x0) / 2

    if abs(radicand - x1 ** 2.0) < 0.01 do
      x1
    else
      do_calculate(radicand, x1)
    end
  end
end
