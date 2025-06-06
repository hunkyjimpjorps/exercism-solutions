defmodule BinarySearch do
  @moduledoc false
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search({}, _), do: :not_found

  def search(numbers, key) do
    len = tuple_size(numbers)
    do_search(numbers, key, 0, div(len, 2), len - 1)
  end

  defp do_search(numbers, key, left, index, right) do
    test_element = elem(numbers, index)

    cond do
      test_element == key ->
        {:ok, index}

      left >= right ->
        :not_found

      test_element > key ->
        right = index - 1
        do_search(numbers, key, left, left + div(right - left, 2), right)

      test_element < key ->
        left = index + 1
        do_search(numbers, key, left, left + div(right - left, 2), right)
    end
  end
end
