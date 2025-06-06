defmodule Dominoes do
  @type domino :: {1..6, 1..6}

  @doc """
  chain?/1 takes a list of domino stones and returns boolean indicating if it's
  possible to make a full chain
  """
  @spec chain?(dominoes :: [domino]) :: boolean
  def chain?([]), do: true
  def chain?([{a, a}]), do: true
  def chain?([_]), do: false

  def chain?([{l, r} = head | others] = dominoes) do
    Enum.any?(others, &find_possible_matches(&1, dominoes))
  end

  defp find_possible_matches(head, [{l, r} | others]) do
    case head do
      {x, ^l} = match -> chain?([{r, x} | List.delete(others, match)])
      {^l, x} = match -> chain?([{r, x} | List.delete(others, match)])
      _ -> false
    end
  end  
end
