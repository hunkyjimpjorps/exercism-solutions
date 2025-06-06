defmodule ComplexNumbers do
  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}` and
  the complex number `4+3i` is `{4, 3}'.
  """
  @type complex :: {number, number}

  @doc """
  Return the real part of a complex number
  """
  @spec real(complex) :: float
  def real({re, _}), do: re

  @doc """
  Return the imaginary part of a complex number
  """
  @spec imaginary(complex) :: float
  def imaginary({_, im}), do: im

  @doc """
  Multiply two complex numbers, or a real and a complex number
  """
  @spec mul(complex | float, complex | float) :: complex
  def mul({a, b}, {c, d}), do: {a * c - b * d, b * c + a * d}
  def mul({a, b}, c), do: mul({a, b}, {c, 0})
  def mul(a, {c, d}), do: mul({a, 0}, {c, d})

  @doc """
  Add two complex numbers, or a real and a complex number
  """
  @spec add(complex | float, complex | float) :: complex
  def add({a, b}, {c, d}), do: {a + c, b + d}
  def add({a, b}, c), do: add({a, b}, {c, 0})
  def add(a, {c, d}), do: add({a, 0}, {c, d})

  @doc """
  Subtract two complex numbers, or a real and a complex number
  """
  @spec sub(complex | float, complex | float) :: complex
  def sub(a, {c, d}), do: add(a, {-c, -d})
  def sub(a, c), do: add(a, -c)

  @doc """
  Divide two complex numbers, or a real and a complex number
  """
  @spec div(complex | float, complex | float) :: complex
  def div({a, b}, {c, d}) do
    (:math.pow(c, 2) + :math.pow(d, 2))
    |> (&{(a * c + b * d) / &1, (b * c - a * d) / &1}).()
  end

  def div({a, b}, c), do: ComplexNumbers.div({a, b}, {c, 0})
  def div(a, {c, d}), do: ComplexNumbers.div({a, 0}, {c, d})

  @doc """
  Absolute value of a complex number
  """
  @spec abs(complex) :: float
  def abs({a, b}) do
    :math.pow(:math.pow(a, 2) + :math.pow(b, 2), 0.5)
  end

  @doc """
  Conjugate of a complex number
  """
  @spec conjugate(complex) :: complex
  def conjugate({a, b}) do
    {a, -b}
  end

  @doc """
  Exponential of a complex number
  """
  @spec exp(complex) :: complex
  def exp({a, b}) do
    {:math.exp(a) * :math.cos(b), :math.exp(a) * :math.sin(b)}
  end
end
