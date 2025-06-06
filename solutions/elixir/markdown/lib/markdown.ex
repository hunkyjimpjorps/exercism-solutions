defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

      iex> Markdown.parse("This is a paragraph")
      "<p>This is a paragraph</p>"

      iex> Markdown.parse("# Header!\\n* __Bold Item__\\n* _Italic Item_")
      "<h1>Header!</h1><ul><li><strong>Bold Item</strong></li><li><em>Italic Item</em></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(m) do
    m
    |> String.split("\n")
    |> Enum.map_join(&process/1)
    |> tag_list_items()
  end

  defp process(t) do
    cond do
      String.starts_with?(t, "*") ->
        t |> parse_list_md_level()

      String.starts_with?(t, "#######") ->
        t |> enclose_with_paragraph_tag()

      String.starts_with?(t, "#") ->
        t |> parse_header_md_level() |> enclose_with_header_tag()

      true ->
        t |> enclose_with_paragraph_tag()
    end
  end

  defp parse_header_md_level(hwt) do
    [h, t] = String.split(hwt, " ", parts: 2)
    {to_string(String.length(h)), t}
  end

  defp parse_list_md_level(l) do
    t = l |> String.trim_leading("* ")
    "<li>#{replace_md_with_tag(t)}</li>"
  end

  defp enclose_with_header_tag({hl, htl}), do: "<h#{hl}>#{htl}</h#{hl}>"
  defp enclose_with_paragraph_tag(w), do: "<p>#{replace_md_with_tag(w)}</p>"

  defp replace_md_with_tag(w) do
    String.replace(w, ~r[__(.+)__], "<strong>\\g{1}</strong>")
    |> String.replace(~r[_(.+)_], "<em>\\g{1}</em>")
  end

  defp tag_list_items(l) do
    String.replace(l, ~r[<li>.*</li>], "<ul>\\g{0}</ul>")
  end
end
