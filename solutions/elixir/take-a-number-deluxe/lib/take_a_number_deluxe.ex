defmodule TakeANumberDeluxe do
  alias TakeANumberDeluxe.State, as: T
  use GenServer

  # Client API

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(options) do
    with {:ok, initial_config} <-
           T.new(
             options[:min_number],
             options[:max_number],
             Keyword.get(options, :auto_shutdown_timeout, :infinity)
           ) do
      GenServer.start_link(__MODULE__, initial_config)
    else
      error -> error
    end
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine) do
    GenServer.call(machine, :report_state)
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine) do
    GenServer.call(machine, :queue_new_number)
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    GenServer.call(machine, {:serve_next_queued_number, priority_number})
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    GenServer.cast(machine, :reset_state)
  end

  # Server callbacks

  @impl true
  def init(state), do: {:ok, state, state.auto_shutdown_timeout}

  @impl true
  def handle_call(:report_state, _, state) do
    {:reply, state, state, state.auto_shutdown_timeout}
  end

  @impl true
  def handle_call(:queue_new_number, _, state) do
    with {:ok, n, state} <- T.queue_new_number(state) do
      {:reply, {:ok, n}, state, state.auto_shutdown_timeout}
    else
      error -> {:reply, error, state, state.auto_shutdown_timeout}
    end
  end

  @impl true
  def handle_call({:serve_next_queued_number, priority}, _, state) do
    with {:ok, n, state} <- T.serve_next_queued_number(state, priority) do
      {:reply, {:ok, n}, state, state.auto_shutdown_timeout}
    else
      error -> {:reply, error, state, state.auto_shutdown_timeout}
    end
  end

  @impl true
  def handle_cast(:reset_state, state) do
    {:ok, state} = T.new(state.min_number, state.max_number, state.auto_shutdown_timeout)
    {:noreply, state, state.auto_shutdown_timeout}
  end

  @impl true
  def handle_info(:timeout, state), do: {:stop, :normal, state}

  def handle_info(_, state), do: {:noreply, state, state.auto_shutdown_timeout}
end