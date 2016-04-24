defmodule Exdash.Collection do
  def map(collection, func) do
    collection
    |> Enum.map(func)
  end
end
