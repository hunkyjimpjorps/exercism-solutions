defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @vowels 'aeiou'

  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split()
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  defp translate_word(<<xy>> <> <<cons>> <> _rest = word)
       when xy in 'xy' and cons not in @vowels do
    word <> "ay"
  end

  defp translate_word(<<vowel>> <> _rest = word)
       when vowel in @vowels do
    word <> "ay"
  end

  defp translate_word(word) do
    String.split(word, ~r/[^q]?(?<vowel>[aeiouy].*)/,
      include_captures: true,
      parts: 2,
      on: [:vowel]
    )
    |> (&["ay" | &1]).()
    |> Enum.reverse()
  end
end
