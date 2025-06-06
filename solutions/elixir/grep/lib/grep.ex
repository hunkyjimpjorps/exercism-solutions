defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, files) do
    many? = match?([_, _ | _], files)

    for f <- files,
        {l, n} <- File.read!(f) |> String.split("\n", trim: true) |> Enum.with_index(1),
        matches?(l, pattern, flags),
        into: "",
        uniq: true do
      "#{file_text(flags, f, many?)}#{line_text(flags, n)}#{match_text(flags, f, l)}\n"
    end
  end

  defp matches?(line, pattern, flags) do
    [line, pattern]
    |> then(fn x -> if "-i" in flags, do: Enum.map(x, &String.downcase/1), else: x end)
    |> then(fn [l, p] -> if "-x" in flags, do: l == p, else: l =~ p end)
    |> then(&if "-v" in flags, do: not &1, else: &1)
  end

  defp file_text(flags, f, many?) do
    cond do
      "-l" in flags -> ""
      many? -> "#{f}:"
      true -> ""
    end
  end

  defp line_text(flags, n) do
    cond do
      "-l" in flags -> ""
      "-n" in flags -> "#{Integer.to_string(n)}:"
      true -> ""
    end
  end

  defp match_text(flags, f, l) do
    if "-l" in flags, do: f, else: l
  end
end
