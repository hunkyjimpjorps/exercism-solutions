defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    Regex.replace(~r/[^\[\]\(\)\{\}]/, str, "")
    |> String.graphemes()
    |> do_check_brackets([])
  end

  defguardp is_opening_bracket(str) when str in ~w/{ ( [/

  defguardp is_matching_brackets(l, r)
            when (l == "(" and r == ")") or (l == "[" and r == "]") or (l == "{" and r == "}")

  defp do_check_brackets(str, acc) do
    case {str, acc} do
      {[], []} ->
        true

      {[h | t], acc} when is_opening_bracket(h) ->
        do_check_brackets(t, [h | acc])

      {[h | t], [acc_h | acc_t]} when is_matching_brackets(acc_h, h) ->
        do_check_brackets(t, acc_t)

      _ ->
        false
    end
  end
end
