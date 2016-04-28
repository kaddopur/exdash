defmodule Exdash.String do
  def camel_case(str) do
    str
    |> String.split(~r"[^a-zA-Z]", trim: true)
    |> do_camel_case
  end

  defp do_camel_case([]), do: ""
  defp do_camel_case(words) do
    Enum.reduce(words, fn word, acc ->
        acc <> String.capitalize(word)
    end)
  end
end
