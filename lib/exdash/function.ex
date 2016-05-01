defmodule Exdash.Function do
  @doc """
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
  def after_nth(times, fun) do
    do_call_nth(times, fun, start_called_server, &Kernel.>=/2)
  end

  @doc """
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
  def before_nth(times, fun) do
    do_call_nth(times, fun, start_called_server, &Kernel.</2)
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
