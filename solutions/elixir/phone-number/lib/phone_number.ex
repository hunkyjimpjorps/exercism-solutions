defmodule PhoneNumber do
  @doc """
  Remove formatting from a phone number if the given number is valid. Return an error otherwise.
  """
  @spec clean(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def clean(raw) do
    with {:ok, phone} <- check_digits_only(raw),
         {:ok, phone} <- check_length_and_prefix(phone),
         {:ok, phone} <- check_area_code(phone),
         {:ok, phone} <- check_exchange_code(phone) do
      {:ok, phone}
    end
  end

  defp check_digits_only(phone) do
    if String.match?(phone, ~r/[^[:digit:]-+().\s]/) do
      {:error, "must contain digits only"}
    else
      phone
      |> String.replace(~r/[^[:digit:]]/, "")
      |> then(&{:ok, &1})
    end
  end

  defp check_length_and_prefix(phone) do
    case phone do
      <<"1", n::binary-size(10)>> -> {:ok, n}
      <<n::binary-size(10)>> -> {:ok, n}
      <<_::binary-size(11)>> -> {:error, "11 digits must start with 1"}
      _ -> {:error, "incorrect number of digits"}
    end
  end

  defp check_area_code(phone) do
    case String.at(phone, 0) do
      "0" -> {:error, "area code cannot start with zero"}
      "1" -> {:error, "area code cannot start with one"}
      _ -> {:ok, phone}
    end
  end

  defp check_exchange_code(phone) do
    case String.at(phone, 3) do
      "0" -> {:error, "exchange code cannot start with zero"}
      "1" -> {:error, "exchange code cannot start with one"}
      _ -> {:ok, phone}
    end
  end
end
