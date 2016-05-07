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
  def in_range?(n, range) when is_integer(range) do
    in_range?(n, 0..range)
  end
end
