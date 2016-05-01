defmodule Exdash.CollectionTest do
  use ExUnit.Case
  use ExCheck
  alias Exdash.Collection
  require Integer
  doctest Exdash.Collection

  test "map on empty list" do
    assert [] == Collection.map([], &add_one/1)
  end

  property :map_list do
    for_all n in list(int) do
      Enum.map(n, &add_one/1) == Collection.map(n, &add_one/1)
    end
  end

  test "map on empty map" do
    map = %{}
    assert [] = Collection.map(map, &add_one/1)
  end

  test "pmap on empty list" do
    assert [] == Collection.pmap([], &add_one/1)
  end

  property :pmap_list do
    for_all n in list(int) do
      assert Collection.map(n, &add_one/1) == Collection.pmap(n, &add_one/1)
    end
  end

  test "filter on empty list" do
    assert [] == Collection.filter([], &add_one/1)
  end

  property :filter_list do
    for_all integers in list(int) do
      integers
      |> Enum.filter(&is_even/1)
      |> Kernel.==(Collection.filter(integers, &is_even/1))
    end
  end

  test "filter with empty map" do
    assert [] == Collection.filter(%{}, &is_even/1)
  end

  test "pfilter with empty list" do
    assert [] == Collection.pfilter([], &is_even/1)
  end

  test "pfilter with map" do
    map = %{"a" => 1, "b" => 2, "c" => 3}
    assert [{"b", 2}] == Collection.pfilter(map, &is_even/1)
  end

  property :pfilter_list do
    for_all integers in list(int) do
      integers
      |> Enum.filter(&is_even/1)
      |> Kernel.==(Collection.pfilter(integers, &is_even/1))
    end
  end

  test "every with empty list" do
    assert Collection.every([], fn -> true end)
  end

  property :every_with_truthy do
    for_all numbers in positive_integers do
      Collection.every(numbers, &(&1 > 0))
    end
  end

  property :every_with_falsy do
    for_all numbers in positive_integers do
      !Collection.every(numbers, &(&1 < 0))
    end
  end

  test "pevery with empty list" do
    assert Collection.pevery([], fn -> true end)
  end

  property :pevery_with_truthy do
    for_all numbers in positive_integers do
      Collection.pevery(numbers, &(&1 > 0))
    end
  end

  property :pevery_with_falsy do
    for_all numbers in positive_integers do
      !Collection.pevery(numbers, &(&1 < 0))
    end
  end

  test "find with empty list" do
    default = nil
    assert default == Collection.find([], default, &(&1))
  end

  property :find_default do
    for_all number in int do
      number == Collection.find([], number, &(&1))
    end
  end

  property :find_convenience do
    for_all numbers in positive_integers do
      find = (fn _ -> true end)
      Collection.find(numbers, nil, find) == Collection.find(numbers, find)
    end
  end

  property :find do
    for_all numbers in positive_integers do
      default = nil
      Collection.find(numbers, default, &(&1 > 0)) != default
    end
  end

  test "pfind empty list" do
    default = nil
    assert default == Collection.pfind([], default, fn -> true end)
  end

  property :pfind_defaults do
    for_all numbers in positive_integers do
      Collection.pfind(numbers, 1, &(&1 < -10)) == 1
    end
  end

  property :pfind do
    for_all numbers in positive_integers do
      find = fn number -> number > 0 end
      numbers
      |> Collection.find(nil, find)
      |> Kernel.==(Collection.pfind(numbers, nil, find))
    end
  end

  test "find_last with empty list" do
    default = nil
    assert default == Collection.find_last([], default, &is_even/1)
  end

  property :find_last_defaults do
    for_all numbers in positive_integers do
      [default|_] = Enum.reverse(numbers)
      default == Collection.find_last(numbers, default, fn _ -> false end)
    end
  end

  test "find_last multiple occurences" do
    numbers = [{"a", 1}, {"b", 2}, {"c", 1}]
    result =
      numbers
      |> Collection.find_last(nil, fn {_, value} -> value == 1 end)
    assert {"c", 1} == result
  end

  test "pfind_last empty list" do
    default = nil
    assert default == Collection.pfind_last([], default, &is_even/1)
  end

  property :pfind_last_defaults do
    for_all numbers in positive_integers do
      [default|_] = Enum.reverse(numbers)
      default == Collection.pfind_last(numbers, default, fn _ -> false end)
    end
  end

  test "pfind_last multiple occurences" do
    numbers = [{"a", 1}, {"b", 2}, {"c", 1}]
    result =
      numbers
      |> Collection.pfind_last(nil, fn {_, value} -> value == 1 end)
    assert {"c", 1} == result
  end

  def add_one(n), do: n + 1

  def is_even({_key, number}), do: is_even(number)
  def is_even(number), do: Integer.is_even(number)

  defp positive_integers(max \\ 10) do
    such_that(x in list(int(0, max)) when length(x) > 0)
  end
end
