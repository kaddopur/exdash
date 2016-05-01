defmodule Exdash do
  @moduledoc """
  """

  alias Exdash.Function
  alias Exdash.Collection, as: Enum
  alias Exdash.String

  # Function
  defdelegate after_nth(times, fun), to: Function, as: :after_nth
  defdelegate before_nth(times, fun), to: Function, as: :before_nth
  defdelegate call_times(times, fun), to: Function, as: :call_times
  defdelegate once(fun), to: Function, as: :once

  # Collection
  defdelegate map(collection, fun), to: Enum, as: :map
  defdelegate pmap(collection, fun), to: Enum, as: :pmap

  defdelegate filter(collection, fun), to: Enum, as: :filter
  defdelegate pfilter(collection, fun), to: Enum, as: :pfilter

  defdelegate every(collection, fun), to: Enum, as: :every
  defdelegate pevery(collection, fun), to: Enum, as: :pevery

  defdelegate find(collection, fun), to: Enum, as: :find
  defdelegate pfind(collection, fun), to: Enum, as: :pfind
  defdelegate find(collection, default, fun), to: Enum, as: :find
  defdelegate pfind(collection, default, fun), to: Enum, as: :pfind

  defdelegate find_last(collection, default, fun), to: Enum, as: :find_last
  defdelegate pfind_last(collection, default, fun), to: Enum, as: :pfind_last

  # String
  defdelegate camel_case(str), to: String, as: :camel_case
  defdelegate kebab_case(str), to: String, as: :kebab_case
  defdelegate downcase_first(str), to: String, as: :downcase_first
  defdelegate upcase_first(str), to: String, as: :upcase_first
  defdelegate snake_case(str), to: String, as: :snake_case
  defdelegate words(str), to: String, as: :words
  defdelegate words(str, pattern), to: String, as: :words
end
