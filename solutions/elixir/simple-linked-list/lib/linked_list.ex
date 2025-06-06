defmodule LinkedList do
  @opaque t :: tuple()
  @type cons_pair :: {any, nil | cons_pair}

  @empty {:error, :empty_list}

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new() do
    {nil}
  end

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, elem) do
    {elem, list}
  end

  @doc """
  Counts the number of elements in a LinkedList
  """
  @spec count(t) :: non_neg_integer()
  def count({nil}), do: 0
  def count({_, tail}), do: 1 + count(tail)

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?({nil}), do: true
  def empty?({_, _}), do: false

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek({nil}), do: @empty
  def peek({head, _}), do: {:ok, head}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail({nil}), do: @empty
  def tail({_, tail}), do: {:ok, tail}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop({nil}), do: @empty
  def pop({head, tail}), do: {:ok, head, tail}

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list([]), do: {nil}
  def from_list([head | tail]), do: {head, from_list(tail)}

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list({nil}), do: []
  def to_list({head, tail}), do: [head | to_list(tail)]

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list), do: do_reverse(list, {nil})
  defp do_reverse({nil}, acc), do: acc
  defp do_reverse({head, tail}, acc), do: do_reverse(tail, {head, acc})
end
