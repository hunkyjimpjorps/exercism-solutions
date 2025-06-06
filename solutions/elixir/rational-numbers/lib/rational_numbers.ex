defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({an, ad}, {bn, bd}) do
    reduce({an * bd + bn * ad, ad * bd})
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract(a, {bn, bd}) do
    add(a, {-bn, bd})
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({an, ad}, {bn, bd}) do
    reduce({an * bn, ad * bd})
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(a :: rational, b :: rational) :: rational
  def divide_by({an, ad}, {bn, bd}) do
    multiply({an, ad}, {bd, bn})
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs({n, d}) do
    reduce({Kernel.abs(n), Kernel.abs(d)})
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, p :: integer) :: rational
  def pow_rational({n, d}, p) when p < 0 do
    reduce({Integer.pow(d, -p), Integer.pow(n, -p)})
  end

  def pow_rational({n, d}, p) do
    reduce({Integer.pow(n, p), Integer.pow(d, p)})
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {n, d}) do
    Float.pow(x / 1, n / d)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce({n, d}) do
    f = Integer.gcd(n, d)

    cond do
      d < 0 -> {div(-n, f), div(-d, f)}
      true -> {div(n, f), div(d, f)}
    end
  end
end
