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
    split(str) |> do_camel_case
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
    split(str) |> Enum.join("-") |> String.downcase
  end

  @doc """
  Converts the first character of string to down case.

  ## Examples
      iex> Exdash.String.downcase_first("HELLO WORLD")
      "hELLO WORLD"
  """
  def downcase_first(str) do
    String.graphemes(str) |> do_downcase_first
  end

  defp do_downcase_first([]), do: ""
  defp do_downcase_first([head|tail]) do
    [String.downcase(head)|tail] |> Enum.join("")
  end

  @doc """
  Converts `str` to [snake case](https://en.wikipedia.org/wiki/Snake_case)

  ## Examples
      iex> Exdash.String.snake_case("foo bar")
      "foo_bar"

      iex> Exdash.String.snake_case("__FOO__BAR__")
      "foo_bar"
  """
  def snake_case(str) do
    split(str) |> Enum.join("_") |> String.downcase
  end

  defp split(str) do
    String.split(str, ~r"[^a-zA-Z]", trim: true)
  end

  @doc """
  Split `str` into words using `pattern`.

  ## Examples
      iex> Exdash.String.words("foo bar baz")
      ["foo", "bar", "baz"]

      iex> Exdash.String.words("foo_bar_baz", ~r"\_")
      ["foo", "bar", "baz"]
  """
  def words(str, pattern \\ ~r"\s") do
    case String.split(str, pattern, trim: true) do
      [""] -> []
      result -> result
    end
  end
end
