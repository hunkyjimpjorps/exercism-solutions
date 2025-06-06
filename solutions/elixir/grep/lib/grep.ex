defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, files) do
    for file <- files,
        {line, number} <-
          File.read!(file) |> String.split("\n", trim: true) |> Enum.with_index(1),
        matches?(line, pattern, flags) do
      file_text =
        cond do
          "-l" in flags -> ""
          match?([_, _ | _], files) -> file <> ":"
          true -> ""
        end

      line_text =
        cond do
          "-l" in flags -> ""
          "-n" in flags -> Integer.to_string(number) <> ":"
          true -> ""
        end

      match_text = if "-l" in flags, do: file, else: line

      file_text <> line_text <> match_text <> "\n"
    end
    |> Enum.dedup()
    |> Enum.join()
  end

  defp matches?(line, pattern, flags) do
    cond do
      "-i" in flags and "-x" in flags -> String.downcase(line) == String.downcase(pattern)
      "-x" in flags -> line == pattern
      "-i" in flags -> String.downcase(line) =~ String.downcase(pattern)
      true -> line =~ pattern
    end
    |> then(&if "-v" in flags, do: not &1, else: &1)
  end
end
