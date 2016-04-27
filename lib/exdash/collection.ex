defmodule Exdash.Collection do
  @doc """
    Returns a list where each item is the result of invoking __fun__ on each element in the collection.

    ## Examples
      iex> Exdash.Collection.map([1, 2, 3], &(&1 + 1))
      [2, 3, 4]
  """
  def map(collection, fun) do
    Enum.map(collection, fun)
  end

  @doc """
    Same as __Exdash.Collection.map__ but executed in parallel
  """
  def pmap(collection, fun) do
    me = self
    Enum.map(collection, fn item ->
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


  @doc """
    Filters the enumerable, i.e. returns only those elements for which **fun** returns
    a truthy value.

    ## Examples
      iex> Enum.filter([1, 2, 3], (fn i -> rem(i, 2) == 0 end))
      [2]
  """
  def filter(collection, fun) do
    Enum.filter(collection, fun)
  end

  @doc """
    Same as __Exdash.Collection.filter__ but executed in parallel
  """
  def pfilter(collection, fun) do
    results = pmap(collection, fn item ->
        {item, fun.(item)}
    end)

    for {value, bool} <- results, bool, do: value
  end

  @doc """
    Check if `fun` returns thruthy for all elements of `collection`.
    Iteration is stopped once the invocation of `fun` returns a falsy value.

    ## Examples
      iex> Exdash.Collection.every([1, 2, 3], &(&1 > 0))
      true

      iex> Exdash.Collection.every([-1, 2, 3], &(&1 > 0))
      false
  """
  def every(collection, fun) do
    do_every(collection, fun, true)
  end

  defp do_every([], _, true), do: true
  defp do_every(_, _, false), do: false
  defp do_every([head|tail], fun, _) do
    do_every(tail, fun, fun.(head))
  end

  @doc """
    Same as `every` but run in parallel
  """
  def pevery(collection, fun) do
    pmap(collection, fn item ->
      {item, fun.(item)}
    end)
    |> every(fn {_, bool} ->
      bool
    end)
  end
end
