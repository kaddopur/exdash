defmodule Exdash.Collection do
  @moduledoc """
  """

  @type t :: Enumerable.t
  @type element :: any
  @type default :: any

  @doc ~S"""
  Returns a `list` where each item is the result of invoking `fun`
  on each element in the `collection`.

  ## Examples
      iex> Exdash.Collection.map([1, 2, 3], &(&1 + 1))
      [2, 3, 4]
  """
  @spec map(t, (element -> any)) :: list
  def map(collection, fun) do
    Enum.map(collection, fun)
  end

  @doc ~S"""
  Same as *Exdash.Collection.map* but executed in parallel.

  ## Examples
      iex> Exdash.Collection.pmap([], &(&1))
      []

      iex> Exdash.Collection.pmap([1, 2, 3], &(&1 + 1))
      [2, 3, 4]
  """
  @spec pmap(t, (element -> any)) :: list
  def pmap(collection, fun) do
    me = self
    collection
    |> Enum.map(fn item ->
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


  @doc ~S"""
  Filters the enumerable, i.e. returns only those elements for which `fun`
  returns a truthy value.

  ## Examples
      iex> Enum.filter([1, 2, 3], &(&1 > 1))
      [2, 3]

  """
  @spec filter(t, (element -> any)) :: list
  def filter(collection, fun) do
    Enum.filter(collection, fun)
  end

  @doc ~S"""
    Same as *Exdash.Collection.filter* but executed in parallel.

    ## Examples
        iex> Exdash.Collection.pfilter([1, 2, 3], &(&1 <= 2))
        [1, 2]
  """
  @spec pfilter(t, (element -> any)) :: list
  def pfilter(collection, fun) do
    for {value, bool} <- pmap_invoke(collection, fun), bool, do: value
  end

  @doc ~S"""
  Check if `fun` returns thruthy for all elements of `collection`.
  Iteration is stopped once the invocation of `fun` returns a falsy value.

  ## Examples
      iex> Exdash.Collection.every([1, 2, 3], &(&1 > 0))
      true

      iex> Exdash.Collection.every([-1, 2, 3], &(&1 > 0))
      false
  """
  @spec every(t, (element -> any)) :: boolean
  def every(collection, fun) do
    do_every(collection, fun, true)
  end

  defp do_every([], _, true), do: true
  defp do_every(_, _, false), do: false
  defp do_every([head|tail], fun, _) do
    do_every(tail, fun, fun.(head))
  end

  @doc ~S"""
  Same as *Exdash.Collection.every* but executed in parallel.

  ## Examples
      iex> Exdash.Collection.pevery([1, 2, 3], &(&1 > 0))
      true

      iex> Exdash.Collection.pevery([1, 2, 3], &(&1 < 2))
      false
  """
  @spec pevery(t, (any -> any)) :: boolean
  def pevery(collection, fun) do
    collection
    |> pmap_invoke(fun)
    |> every(&second/1)
  end


  @doc ~S"""
  Returns the first value of which invoking `fun` equals true.
  Otherwise return `default`.

  ## Examples
      iex> Exdash.Collection.find([1, 2, 3], &(&1 > 2))
      3
  """
  @spec find(t, default, (element -> any)) :: element | default
  def find(collection, default, fun) do
    Enum.find(collection, default, fun)
  end
  @spec find(t, (element -> any)) :: element | default
  def find(collection, fun), do: find(collection, nil, fun)


  @doc ~S"""
  Same as *Exdash.Collection.find* but executed in parallel.

  ## Examples
    iex> Exdash.Collection.pfind([1, 2, 3], nil, fn n ->
    ...>  rem(n, 2) == 0
    ...> end)
    2

    iex> Exdash.Collection.pfind([], 1, &(&1))
    1
  """
  @spec pfind(t, default, (element -> any)) :: element | default
  def pfind(collection, default, fun) do
    result =
      collection
      |> pmap_invoke(fun)
      |> find(&second/1)

    case result do
      {item, _} -> item
      _ -> default
    end
  end
  @spec pfind(t, (element -> any)) :: element | default
  @doc ~S"""
  ## Examples
      iex> Exdash.Collection.pfind([1, 2, 3], fn n ->
      ...>  rem(n, 2) == 0
      ...> end)
      2

      iex> Exdash.Collection.pfind([], &(&1))
      nil
  """
  def pfind(collection, fun), do: pfind(collection, nil, fun)

  @doc ~S"""
  Same as *Exdash.Collection.find* but searches
  through the `collection` from right to left.

  ## Examples
      iex> Exdash.Collection.find_last([{:a, 1}, {:a, 2}], nil, fn {n, _} ->
      ...> n == :a
      ...> end)
      {:a, 2}
  """
  @spec find_last(t, default, (element -> any)) :: element | default
  def find_last(collection, default, fun) do
    collection |> Enum.reverse |> find(default, fun)
  end

  @doc ~S"""
  Same as *Exdash.Collection.find_last* but executed in parallel.
  """
  @spec pfind_last(t, default, (element -> any)) :: element | default
  def pfind_last(collection, default, fun) do
    collection |> Enum.reverse |> pfind(default, fun)
  end

  defp pmap_invoke(collection, fun) do
    pmap(collection, fn item ->
      {item, fun.(item)}
    end)
  end

  defp second({_, second}), do: second
end
