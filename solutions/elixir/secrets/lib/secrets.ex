defmodule Secrets do
  @spec secret_add(any) :: (number -> number)
  def secret_add(secret) do
    &(&1 + secret)
  end

  @spec secret_subtract(any) :: (number -> number)
  def secret_subtract(secret) do
    &(&1 - secret)
  end

  @spec secret_multiply(any) :: (number -> number)
  def secret_multiply(secret) do
    &(&1 * secret)
  end

  @spec secret_divide(any) :: (integer -> integer)
  def secret_divide(secret) do
    &(Integer.floor_div(&1, secret))
  end

  @spec secret_and(any) :: (integer -> integer)
  def secret_and(secret) do
    &(Bitwise.&&&(&1, secret))
  end

  @spec secret_xor(any) :: (integer -> integer)
  def secret_xor(secret) do
    &(Bitwise.^^^(&1, secret))
  end

  @spec secret_combine(any, any) :: (any -> any)
  def secret_combine(secret_function1, secret_function2) do
    fn n -> secret_function2.(secret_function1.(n)) end
  end
end
