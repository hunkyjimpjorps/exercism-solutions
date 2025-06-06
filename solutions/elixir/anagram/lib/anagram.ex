defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  defp sort_letters(word) do
    word      
    |> String.downcase() 
    |> String.to_charlist()
    |> Enum.sort()
  end

  defp anagram?(word, base) do
    String.downcase(word) != String.downcase(base) 
      && sort_letters(word) == sort_letters(base)
  end
  
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    Enum.filter(candidates, &(anagram?(&1, base)))
  end
end
