defmodule RPNCalculator do
  def calculate!(stack, operation) do
    operation.(stack)
  end

  def calculate(stack, operation) do
    try do
      {:ok, operation.(stack)}
    rescue
      err in _ -> :error
    end
  end

  def calculate_verbose(stack, operation) do
    try do
      {:ok, operation.(stack)}
    rescue
      err in _ -> {:error, err.message}
    end
  end
end
