defmodule Alphametics do
  @type puzzle :: binary
  @type solution :: %{required(?A..?Z) => 0..9}

  @doc """
  Takes an alphametics puzzle and returns a solution where every letter
  replaced by its number will make a valid equation. Returns `nil` when
  there is no valid solution to the given puzzle.

  ## Examples

    iex> Alphametics.solve("I + BB == ILL")
    %{?I => 1, ?B => 9, ?L => 0}

    iex> Alphametics.solve("A == B")
    nil
  """
  @spec solve(puzzle) :: solution | nil
  def solve(puzzle) do
    [sum | parts] = words = parse(puzzle)

    variables = for l <- List.flatten(words), uniq: true, do: l
    leading_variables = for w <- words, uniq: true, do: hd(w)

    problem = %{parts: parts, sum: sum, initials: leading_variables}

    do_solve(variables, Enum.to_list(0..9), %{}, problem)
  end

  defp parse(puzzle) do
    [left_side, right_side] = String.split(puzzle, " == ")

    parts = left_side |> String.split(" + ") |> Enum.map(&String.to_charlist/1)
    sum = right_side |> String.to_charlist()

    [sum | parts]
  end

  defp do_solve([], _, solution, %{parts: parts, sum: sum}) do
    if sum(parts, solution) == to_number(sum, solution), do: solution
  end

  defp do_solve([letter | rest], numbers, solution, problem) do
    Enum.find_value(numbers, fn n ->
      if not (n == 0 && letter in problem.initials) do
        solution = put_in(solution[letter], n)
        do_solve(rest, numbers -- [n], solution, problem)
      end
    end)
  end

  defp sum(parts, solution) do
    for p <- parts, reduce: 0 do
      acc -> acc + to_number(p, solution)
    end
  end

  defp to_number(letters, numbers) do
    letters
    |> Enum.map(&numbers[&1])
    |> Integer.undigits()
  end
end
