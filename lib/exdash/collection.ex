defmodule Exdash.Collection do
  @doc """
    Returns a list where each item is the result of invoking __fun__ on each element in the collection.

    ## Examples
      iex> Exdash.Collection.map([1, 2, 3], &(&1 + 1))
      [2, 3, 4]
  """
  def map(collection, fun) do
    collection
    |> Enum.map(fun)
  end

  @doc """
    Same as __Exdash.Collection.map__ but executed in parallel
  """
  def pmap(collection, fun) do
    me = self
    Enum.map(collection, fn (item) ->
      spawn_link(fn ->
        send(me, {self, fun.(item)})
      end)
    end)
    |> Enum.map(fn pid ->
      receive do
        {^pid, result} -> result
      end
    end)
  end
end
