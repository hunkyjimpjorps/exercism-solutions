defmodule FoodChain do
  @doc """
  Generate consecutive verses of the song 'I Know an Old Lady Who Swallowed a Fly'.
  """

  @creatures %{
    1 => %{animal: "fly", rejoinder: []},
    2 => %{animal: "spider", rejoinder: "It wriggled and jiggled and tickled inside her."},
    3 => %{animal: "bird", rejoinder: "How absurd to swallow a bird!"},
    4 => %{animal: "cat", rejoinder: "Imagine that, to swallow a cat!"},
    5 => %{animal: "dog", rejoinder: "What a hog, to swallow a dog!"},
    6 => %{animal: "goat", rejoinder: "Just opened her throat and swallowed a goat!"},
    7 => %{animal: "cow", rejoinder: "I don't know how she swallowed a cow!"},
    8 => %{animal: "horse", rejoinder: []}
  }

  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop) do
    for verse <- start..stop do
      do_verse(verse)
    end
    |> Enum.join("\n")
  end

  defp do_verse(8) do
    """
    I know an old lady who swallowed a horse.
    She's dead, of course!
    """
  end

  defp do_verse(verse) do
    [
      "I know an old lady who swallowed a #{@creatures[verse].animal}.",
      @creatures[verse].rejoinder,
      for n <- verse..2//-1 do
        predator = @creatures[n].animal
        prey = spider_exception(@creatures[n - 1].animal)
        "She swallowed the #{predator} to catch the #{prey}."
      end,
      "I don't know why she swallowed the fly. Perhaps she'll die.\n"
    ]
    |> List.flatten()
    |> Enum.join("\n")
  end

  defp spider_exception("spider"), do: "spider that wriggled and jiggled and tickled inside her"
  defp spider_exception(str), do: str
end
