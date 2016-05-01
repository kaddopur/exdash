defmodule Exdash.FunctionTest do
  use ExUnit.Case
  use ExCheck
  alias Exdash.Function
  doctest Exdash.Function

  defmodule Server do
    use GenServer

    def start_link do
      GenServer.start_link(__MODULE__, 0, [])
    end

    def inc(pid) do
      GenServer.cast(pid, :inc)
    end

    def get(pid) do
      GenServer.call(pid, :get)
    end

    def handle_cast(:inc, state) do
      {:noreply, state + 1}
    end

    def handle_call(:get, _from, state) do
      {:reply, state, state}
    end
  end

  setup do
    {:ok, pid} = Server.start_link
    {:ok, %{"server" => pid}}
  end

  test "after no execution", %{"server" => server} do
    after_nth(1, server)
    assert 0 == Server.get(server)
  end

  test "after not enough executions", %{"server" => server} do
    fun = after_nth(2, server)
    Enum.each(1..1, fn _ -> fun.() end)
    assert 0 == Server.get(server)
  end

  test "after enough executions", %{"server" => server} do
    fun = after_nth(1, server)
    Enum.each(1..1, fn _ -> fun.() end)
    assert 1 == Server.get(server)
  end

  test "after too many executions", %{"server" => server} do
    fun = after_nth(1, server)
    Enum.each(1..2, fn _ -> fun.() end)
    assert 2 == Server.get(server)
  end

  test "before 0 times", %{"server" => server} do
    before_nth(0, server)
    assert 0 == Server.get(server)
  end

  test "before 1 time", %{"server" => server} do
    fun = before_nth(1, server)
    Enum.each(1..1, fn _ -> fun.() end)
    assert 0 == Server.get(server)
  end

  test "before no executions", %{"server" => server} do
    before_nth(2, server)
    assert 0 == Server.get(server)
  end

  test "before 2 times", %{"server" => server} do
    fun = before_nth(2, server)
    Enum.each(1..2, fn _ -> fun.() end)
    assert 1 == Server.get(server)
  end

  test "before too many times", %{"server" => server} do
    fun = before_nth(2, server)
    Enum.each(1..5, fn _ -> fun.() end)
    assert 1 == Server.get(server)
  end

  test "call_times 0 times", %{"server" => server} do
    Function.call_times(0, fn _ -> Server.inc(server) end)
    assert 0 == Server.get(server)
  end

  test "call_times 1 time", %{"server" => server} do
    Function.call_times(1, fn _ -> Server.inc(server) end)
    assert 1 == Server.get(server)
  end

  property :call_times_return do
    for_all n in int(1, 100) do
      assert Enum.into(1..n, []) == Function.call_times(n, &(&1))
    end
  end

  test "once with no execution", %{"server" => server} do
    Function.once(fn -> Server.inc(server) end)
    assert 0 == Server.get(server)
  end

  test "once with a single execution", %{"server" => server} do
    fun = Function.once(fn ->
      Server.inc(server)
      Server.get(server)
    end)

    result = Function.call_times(1, fn _ -> fun.() end)
    assert [1] == result
  end

  test "once called multiple times", %{"server" => server} do
    fun = Function.once(fn ->
      Server.inc(server)
      Server.get(server)
    end)

    result = Function.call_times(3, fn _ -> fun.() end)
    assert [1, 1, 1] == result && 1 == Server.get(server)
  end

  defp after_nth(times, server) do
    Function.after_nth(times, fn ->
      Server.inc(server)
    end)
  end

  defp before_nth(times, server) do
    Function.before_nth(times, fn ->
      Server.inc(server)
    end)
  end
end
