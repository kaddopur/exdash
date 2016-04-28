defmodule Exdash.String do
  @doc """
  Converts `str` to [camel case](https://en.wikipedia.org/wiki/CamelCase)

  ## Examples
    iex> Exdash.String.camel_case("camel case")
    "camelCase"

    iex> Exdash.String.camel_case("CAMEL CASE")
    "CAMELCase"

    iex> Exdash.String.camel_case("__camel__case__")
    "camelCase"
  """
  def camel_case(str) do
    str
    |> String.split(~r"[^a-zA-Z]", trim: true)
    |> do_camel_case
  end

  defp do_camel_case([]), do: ""
  defp do_camel_case(words) do
    Enum.reduce(words, fn word, acc ->
        acc <> String.capitalize(word)
    end)
  end

  @doc """
  Converts `str` to [kebab case](https://en.wikipedia.org/wiki/Letter_case#Special_case_styles)

  ## Examples
      iex> Exdash.String.kebab_case("kebab case")
      "kebab-case"

      iex> Exdash.String.kebab_case("kebab_case")
      "kebab-case"

      iex> Exdash.String.kebab_case("Kebab-Case")
      "kebab-case"
  """
  def kebab_case(str) do
    str
    |> String.split(~r"[^a-zA-Z]", trim: true)
    |> Enum.join("-")
    |> String.downcase
  end
end
