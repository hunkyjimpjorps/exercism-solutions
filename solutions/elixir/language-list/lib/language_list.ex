defmodule LanguageList do
  def new(), do: []

  def add(list, language), do: [language | list]

  def remove([_ | tail]), do: tail

  def first([head | _]), do: head

  def count([]), do: 0
  def count([_ | tail]), do: 1 + count(tail)

  def exciting_list?([]), do: false
  def exciting_list?([head | _]) when head == "Elixir", do: true
  def exciting_list?([_ | tail]), do: exciting_list?(tail)
end
