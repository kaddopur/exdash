defmodule Exdash.Function do
  @doc """
  Executes `fun` after it is invoked `times` or more times.

  ## Examples
      iex> fun = Exdash.Function.after_nth(1, fn -> :ok end)
      ...> fun.()
      ...> fun.()
      :ok
  """
  def after_nth(times, fun) when times > 0 do
    fn ->
      after_nth(times - 1, fun)
    end
  end
  def after_nth(0, fun), do: fun.()
end
