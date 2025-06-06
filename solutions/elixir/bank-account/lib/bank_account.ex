defmodule BankAccount do
  use Agent

  defstruct balance: 0

  @moduledoc """
  A bank account that supports access from multiple processes.
  """
  @type closed :: {:error, :account_closed}

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, pid} = Agent.start(fn -> %BankAccount{} end)
    pid
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: :ok
  def close_bank(account) do
    Agent.stop(account)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer | closed
  def balance(account) do
    if account_closed?(account) do
      {:error, :account_closed}
    else
      Agent.get(account, & &1.balance)
    end
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: :ok | closed
  def update(account, amount) do
    if account_closed?(account) do
      {:error, :account_closed}
    else
      Agent.update(account, fn b -> %{b | balance: b.balance + amount} end)
    end
  end

  defp account_closed?(account) do
    not Process.alive?(account)
  end
end
