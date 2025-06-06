# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  @notfound {:not_found, "plot is unregistered"}
  def start(opts \\ []) do
    Agent.start(fn -> {[], 1} end)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn {plots, next} -> plots end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn {plots, next} ->
      to_register = %Plot{plot_id: next, registered_to: register_to}
      {to_register, {[to_register | plots], next + 1}}
    end)
  end

  def release(pid, released) do
    Agent.get_and_update(pid, fn {plots, next} ->
      {:ok, {Enum.reject(plots, fn p -> p.plot_id == released end), next}}
    end)
  end

  def get_registration(pid, id) do
    Agent.get(pid, fn {plots, _} -> 
      Enum.find(plots, @notfound, fn p -> p.plot_id == id end) end)
  end
end