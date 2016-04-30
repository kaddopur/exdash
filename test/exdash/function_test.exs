defmodule Exdash.FunctionTest do
  use ExUnit.Case
  use ExCheck
  alias Exdash.Function
  doctest Exdash.Function

  defmodule Server do
    use GenServer

    def start_link() do
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
    Function.after_nth(1, fn ->
      Server.inc(server)
    end)
    assert 0 == Server.get(server)
  end

  test "after not enough executions", %{"server" => server} do
    Function.after_nth(2, fn ->
      Server.inc(server)
    end).()

    assert 0 == Server.get(server)
  end

  test "after enough executions", %{"server" => server} do
    Function.after_nth(1, fn ->
      Server.inc(server)
    end).()

    assert 1 == Server.get(server)
  end

  test "after too many executions", %{"server" => server} do
    fun = Function.after_nth(1, fn ->
      Server.inc(server)
    end)

    fun.()
    fun.()

    assert 2 == Server.get(server)
  end
end
