defmodule Exdash.Collection do
  @doc """
  Returns a `list` where each item is the result of invoking `fun` on each element in the `collection`.

  ## Examples
      iex> Exdash.Collection.map([1, 2, 3], &(&1 + 1))
      [2, 3, 4]

  """
  def map(collection, fun) do
    Enum.map(collection, fun)
  end

  @doc """
  Same as *Exdash.Collection.map* but executed in parallel.
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
  Filters the enumerable, i.e. returns only those elements for which `fun`
  returns a truthy value.

  ## Examples
      iex> Enum.filter([1, 2, 3], &(&1 > 1))
      [2, 3]

  """
  def filter(collection, fun) do
    Enum.filter(collection, fun)
  end

  @doc """
    Same as *Exdash.Collection.filter* but executed in parallel.
  """
  def pfilter(collection, fun) do
    for {value, bool} <- pmap_invoke(collection, fun), bool, do: value
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
  Same as *Exdash.Collection.every* but executed in parallel.
  """
  def pevery(collection, fun) do
    pmap_invoke(collection, fun)
    |> every(&second/1)
  end


  @doc """
  Returns the first value of which invoking `fun` equals true.
  Otherwise return `default`.

  ## Examples
      iex> Exdash.Collection.find([1, 2, 3], &(&1 > 2))
      3

  """
  def find(collection, default, fun) do
    Enum.find(collection, default, fun)
  end
  def find(collection, fun), do: find(collection, nil, fun)


  @doc """
  Same as *Exdash.Collection.find* but executed in parallel.
  """
  def pfind(collection, default, fun) do
    case pmap_invoke(collection, fun) |> find(&second/1) do
      {item, _} -> item
      _ -> default
    end
  end

  @doc """
  Same as *Exdash.Collection.find* but searches through the `collection` from right to left.
  """
  def find_last(collection, default, fun) do
    Enum.reverse(collection) |> find(default, fun)
  end


  @doc """
  Same as *Exdash.Collection.find_last* but executed in parallel.
  """
  def pfind_last(collection, default, fun) do
    Enum.reverse(collection) |> pfind(default, fun)
  end

  defp pmap_invoke(collection, fun) do
    pmap(collection, fn item ->
      {item, fun.(item)}
    end)
  end

  defp second({_, second}), do: second
end
