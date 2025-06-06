defmodule GuessingGame do
  def compare(secret_number, :no_guess), do: "Make a guess"
  def compare(secret_number, secret_number), do: "Correct"
  def compare(secret_number, guess) when abs(secret_number - guess) == 1, do: "So close"
  def compare(secret_number, guess) when secret_number > guess, do: "Too low"
  def compare(secret_number, guess) when secret_number < guess, do: "Too high"
  def compare(secret_number), do: "Make a guess"
end
