defmodule Exdash.String do
  @moduledoc """
  """

  @doc ~S"""
  Converts `str` to [camel case](https://en.wikipedia.org/wiki/CamelCase)

  ## Examples
      iex> Exdash.String.camel_case("camel case")
      "camelCase"

      iex> Exdash.String.camel_case("CAMEL CASE")
      "CAMELCase"

      iex> Exdash.String.camel_case("__camel__case__")
      "camelCase"
  """
  @spec camel_case(String.t) :: String.t
  def camel_case(str) do
    str |> split |> do_camel_case
  end

  defp do_camel_case([]), do: ""
  defp do_camel_case(words) do
    Enum.reduce(words, fn word, acc ->
        acc <> String.capitalize(word)
    end)
  end

  @doc ~S"""
  Converts `str` to
  [kebab case](https://en.wikipedia.org/wiki/Letter_case#Special_case_styles)

  ## Examples
      iex> Exdash.String.kebab_case("kebab case")
      "kebab-case"

      iex> Exdash.String.kebab_case("kebab_case")
      "kebab-case"

      iex> Exdash.String.kebab_case("Kebab-Case")
      "kebab-case"
  """
  @spec kebab_case(String.t) :: String.t
  def kebab_case(str) do
    str |> split |> Enum.join("-") |> String.downcase
  end

  @doc ~S"""
  Converts the first character of string to down case.

  ## Examples
      iex> Exdash.String.downcase_first("HELLO WORLD")
      "hELLO WORLD"
  """
  @spec downcase_first(String.t) :: String.t
  def downcase_first(str) do
    str |> String.graphemes |> do_transform_first(&String.downcase/1)
  end

  @doc ~S"""
  Convers the first charachter of string to upper case.

  ## Examples
      iex> Exdash.String.upcase_first("hello world")
      "Hello world"
  """
  @spec upcase_first(String.t) :: String.t
  def upcase_first(str) do
    str |> String.graphemes |> do_transform_first(&String.upcase/1)
  end

  defp do_transform_first([], _), do: ""
  defp do_transform_first([head|tail], fun) do
    [fun.(head)|tail] |> Enum.join("")
  end

  @doc ~S"""
  Converts `str` to [snake case](https://en.wikipedia.org/wiki/Snake_case)

  ## Examples
      iex> Exdash.String.snake_case("foo bar")
      "foo_bar"

      iex> Exdash.String.snake_case("__FOO__BAR__")
      "foo_bar"
  """
  @spec snake_case(String.t) :: String.t
  def snake_case(str) do
    str |> split |> Enum.join("_") |> String.downcase
  end

  defp split(str) do
    String.split(str, ~r"[^a-zA-Z]", trim: true)
  end

  @doc ~S"""
  Split `str` into words using `pattern`.

  ## Examples
      iex> Exdash.String.words("foo bar baz")
      ["foo", "bar", "baz"]

      iex> Exdash.String.words("foo,bar,baz", ~r{,})
      ["foo", "bar", "baz"]
  """
  @spec words(String.t, Regex.t) :: list
  def words(str, pattern \\ ~r{\s}) do
    String.split(str, pattern, trim: true)
  end
end
