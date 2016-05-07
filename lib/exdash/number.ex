defmodule Exdash.Number do
  @moduledoc """
  """

  @spec in_range?(number, Range.t) :: boolean
  @spec in_range?(number, number)  :: boolean
  @doc """
  Checks if `n` is between start and up to, but not including,
  the end of a given `range`. Where `range` can be of type `Range` or `integer`.

  ## Examples
      iex> Exdash.Number.in_range?(1, 1..10)
      true

      iex> Exdash.Number.in_range?(1, 10..10)
      false

      iex> Exdash.Number.in_range?(10, 1..10)
      false

      iex> Exdash.Number.in_range?(-5, -10..0)
      true

      iex> Exdash.Number.in_range?(1, 10)
      true
  """
  def in_range?(n, %Range{first: first, last: last}) when first > last do
    in_range?(n, last..first)
  end
  def in_range?(n, %Range{first: first, last: last}) do
    first <= n and n < last
  end
  def in_range?(n, range) when is_number(range) do
    in_range?(n, %Range{first: 0, last: range})
  end

  @spec random(integer, integer) :: integer
  @spec random(integer, float)   :: float
  @spec random(float, integer)   :: float
  @spec random(float, float)     :: float
  @spec random(number)           :: number
  @doc ~S"""
  Produces a random number between the `lower` and `upper` bounds.
  If only one argument is provided, A number between 0 and the given
  argument is returned.

  ## Examples
  iex> random = Exdash.Number.random(0, 10)
  ...> Exdash.Number.in_range?(random, 10 + 1)
  true

  iex> random = Exdash.Number.random(0, 10.0)
  ...> Exdash.Number.in_range?(random, 10 + 1) and is_float(random)
  true

  iex> upper = 10
  ...> Exdash.Number.random(upper)
  ...> |> Exdash.Number.in_range?(upper + 1)
  true
  """
  def random(lower, upper) when is_float(lower) or is_float(upper) do
    seed = :rand.uniform
    (seed * (upper-lower)) + lower
  end
  def random(lower, upper) do
    seed = :rand.uniform
    round(seed * (upper-lower)) + lower
  end
  def random(upper), do: random(0, upper)
end
