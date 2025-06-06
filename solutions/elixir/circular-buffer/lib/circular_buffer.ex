defmodule CircularBuffer do
  @moduledoc """
  An API to a stateful process that fills and empties a circular buffer
  """

  @doc """
  Create a new buffer of a given capacity
  """
  @spec new(capacity :: integer) :: {:ok, pid}
  def new(capacity) do
    Agent.start_link(fn -> %{capacity: capacity, contents: []} end)
  end

  @doc """
  Read the oldest entry in the buffer, fail if it is empty
  """
  @spec read(buffer :: pid) :: {:ok, any} | {:error, atom}
  def read(buffer) do
    Agent.get_and_update(buffer, fn state ->
      if state.contents == [] do
        {{:error, :empty}, state}
      else
        {rest, [take]} = Enum.split(state.contents, -1)
        {{:ok, take}, %{state | contents: rest}}
      end
    end)
  end

  @doc """
  Write a new item in the buffer, fail if is full
  """
  @spec write(buffer :: pid, item :: any) :: :ok | {:error, atom}
  def write(buffer, item) do
    Agent.get_and_update(buffer, fn state ->
      if length(state.contents) == state.capacity do
        {{:error, :full}, state}
      else
        {:ok, %{state | contents: [item | state.contents]}}
      end
    end)
  end

  @doc """
  Write an item in the buffer, overwrite the oldest entry if it is full
  """
  @spec overwrite(buffer :: pid, item :: any) :: :ok
  def overwrite(buffer, item) do
    Agent.update(buffer, fn state ->
      if length(state.contents) < state.capacity do
        %{state | contents: [item | state.contents]}
      else
        %{state | contents: Enum.drop([item | state.contents], -1)}
      end
    end)
  end

  @doc """
  Clear the buffer
  """
  @spec clear(buffer :: pid) :: :ok
  def clear(buffer) do
    Agent.update(buffer, fn state -> %{state | contents: []} end)
  end
end
