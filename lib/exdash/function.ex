defmodule Exdash.Function do
  @moduledoc """
  """

  @type f :: (... -> any)

  @doc ~S"""
  Executes `fun` after it's invoked `times` or more times.

  ## Examples
      iex> {:ok, pid} = Agent.start_link(fn -> 0 end)
      ...> fun = Exdash.Function.after_nth(2, fn ->
      ...>    Agent.update(pid, fn n -> n + 1 end)
      ...> end)
      ...> Enum.each(1..3, fn _ -> fun.() end)
      ...> Agent.get(pid, &(&1))
      2
  """
  @spec after_nth(integer, f) :: f
  def after_nth(times, fun) do
    do_call_nth(times, fun, start_called_server, &Kernel.>=/2)
  end

  @doc ~S"""
  Creates a function that invokes `fun` while it’s called less than `times`.

  ## Examples
      iex> {:ok, pid} = Agent.start_link(fn -> 0 end)
      ...> fun = Exdash.Function.before_nth(2, fn ->
      ...>    Agent.update(pid, fn n -> n + 1 end)
      ...> end)
      ...> Enum.each(1..3, fn _ -> fun.() end)
      ...> Agent.get(pid, &(&1))
      1
  """
  @spec before_nth(integer, f) :: f
  def before_nth(times, fun) do
    do_call_nth(times, fun, start_called_server, &Kernel.</2)
  end

  @doc ~S"""
  Invoke the `fun` a set amount of `times`,
  returning a **list** of the result of each invocation.

  ## Examples
      iex> Exdash.Function.call_times(3, &(&1))
      [1, 2, 3]

      iex> Exdash.Function.call_times(0, &(&1))
      []
  """
  @spec call_times(integer, f) :: list
  def call_times(times, fun) when times > 0 do
    Enum.map(1..times, fn index -> fun.(index) end)
  end
  def call_times(_, _), do: []

  @doc ~S"""
  Creates a function that is restricted to invoking `fun` once.
  Repeat calls to the function return the value of the first invocation.

  ## Examples
      iex> {:ok, pid} = Agent.start_link(fn -> 0 end)
      ...> fun = Exdash.Function.once(fn ->
      ...>   Agent.get_and_update(pid, fn n -> {n, n + 1} end)
      ...> end)
      ...> {fun.(), fun.(), Agent.get(pid, &(&1))}
      {0, 0, 1}
  """
  @spec once(f) :: f
  def once(fun) do
    {:ok, pid} = Agent.start_link(fn ->
      %{"called?" => false, "value" => nil}
    end)

    fn ->
      pid
      |> Agent.get(&(&1))
      |> do_once(pid, fun)
    end
  end

  @doc ~S"""
  Creates a function that accepts arguments of `fun`
  and either invokes `fun` returning its result,
  if at least arity number of `arguments` have been provided,
  or returns a function that accepts the remaining `fun` arguments, and so on.

  ## Examples
      iex> add = Exdash.Function.curry(&Kernel.+/2)
      ...> add_one = add.(1)
      ...> add_one.(2)
      3
  """
  @spec curry(f) :: ((any) -> ((any) -> any))
  def curry(func) do
    {_, arity} = :erlang.fun_info(func, :arity)
    curry(func, arity, [])
  end
  def curry(func, 0, args), do: apply(func, args)
  def curry(func, arity, args) do
    fn arg ->
      curry(func, arity - 1, [arg | args])
    end
  end

  @doc ~S"""
    Creates a function that invokes `fun`
    with partials prepended to the arguments it receives.

    ## Examples
        iex> add_one = Exdash.Function.partial(&Kernel.+/2, [1])
        ...> add_one.(2)
        3

        iex> greet = fn greeting, name ->
        ...>  "#{greeting}, #{name}"
        ...> end
        ...> pgreet = Exdash.Function.partial(greet, [Exdash.Placeholder, "Ad"])
        ...> pgreet.("Hi")
        "Hi, Ad"
  """
  @spec partial(f, nonempty_list) :: ((any) -> any)
  def partial(fun, args) do
    fn arg ->
      case Enum.find_index(args, &(&1 == Exdash.Placeholder)) do
        nil -> apply(fun, args ++ [arg])
        index ->
          apply(fun, List.replace_at(args, index, arg))
      end
    end
  end

  defp do_once(%{"called?" => false}, pid, fun) do
    result = fun.()
    pid
    |> Agent.update(fn _ ->
      %{"called?" => true, "value" => result}
    end)
    result
  end
  defp do_once(%{"called?" => true, "value" => value}, _, _) do
    value
  end

  defp do_call_nth(times, fun, agent, predicate) do
    fn ->
      called_times = get_and_inc_called_server(agent)
      if predicate.(called_times, times), do: fun.()
    end
  end

  defp start_called_server do
    {:ok, pid} = Agent.start_link(fn -> 1 end)
    pid
  end
  defp get_and_inc_called_server(server) do
    server
    |> Agent.get_and_update(fn n ->
      {n, n + 1}
    end)
  end
end
