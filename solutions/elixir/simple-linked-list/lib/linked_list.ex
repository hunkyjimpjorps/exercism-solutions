defmodule LinkedList do
  @type cons_pair :: {any, cons_pair} | {nil}

  @empty {:error, :empty_list}

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: cons_pair
  def new() do
    {nil}
  end

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(cons_pair, any()) :: cons_pair
  def push(list, elem) do
    {elem, list}
  end

  @doc """
  Counts the number of elements in a LinkedList
  """
  @spec count(cons_pair) :: non_neg_integer()
  def count({nil}), do: 0
  def count({_, tail}), do: 1 + count(tail)

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(cons_pair) :: boolean()
  def empty?({nil}), do: true
  def empty?({_, _}), do: false

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(cons_pair) :: {:ok, any()} | {:error, :empty_list}
  def peek({nil}), do: @empty
  def peek({head, _}), do: {:ok, head}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(cons_pair) :: {:ok, cons_pair} | {:error, :empty_list}
  def tail({nil}), do: @empty
  def tail({_, tail}), do: {:ok, tail}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(cons_pair) :: {:ok, any(), cons_pair} | {:error, :empty_list}
  def pop({nil}), do: @empty
  def pop({head, tail}), do: {:ok, head, tail}

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: cons_pair
  def from_list([]), do: {nil}
  def from_list([head | tail]), do: push(head, from_list(tail))

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(cons_pair) :: list()
  def to_list({nil}), do: []
  def to_list({head, tail}), do: [head | to_list(tail)]

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(cons_pair) :: cons_pair
  def reverse(list), do: do_reverse(list, {nil})
  defp do_reverse({nil}, acc), do: acc
  defp do_reverse({head, tail}, acc), do: do_reverse(tail, push(head, acc))
end
