defmodule TakeANumber do
  def receive_loop(num) do
    receive do
      {:report_state, caller} ->
        send(caller, num)
        receive_loop(num)

      {:take_a_number, caller} ->
        send(caller, num + 1)
        receive_loop(num + 1)

      :stop ->
        nil

      _ ->
        receive_loop(num)
    end
  end

  def start() do
    spawn(fn -> receive_loop(0) end)
  end
end
