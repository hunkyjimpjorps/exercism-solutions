defmodule LogParser do
  @valid_starts ["[DEBUG]", "[INFO]", "[WARNING]", "[ERROR]"]

  def valid_line?(line) do
    String.starts_with?(line, @valid_starts)
  end

  def split_line(line) do
    String.split(line, ~r/<[~*=-]*>/)
  end

  def remove_artifacts(line) do
    String.replace(line, ~r/end-of-line[0-9]+/i, "")
  end

  def tag_with_user_name(line) do
    case Regex.run(~r/User\s+(\S+)/, line) do
      [_, name | _] -> "[USER] #{name} #{line}"
      _ -> line
    end
  end
end
