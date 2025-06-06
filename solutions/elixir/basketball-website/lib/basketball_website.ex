defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    path_keys = String.split(path, ".")
    do_extract_from_path(data, path_keys)
  end

  defp do_extract_from_path(data, [last_key]) do
    data[last_key]
  end

  defp do_extract_from_path(data, [current_key | rest_of_keys]) do
    do_extract_from_path(data[current_key], rest_of_keys)
  end

  def get_in_path(data, path) do
    get_in(data, String.split(path, "."))
  end
end
