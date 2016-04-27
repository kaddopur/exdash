defmodule Exdash.CollectionTest do
  use ExUnit.Case, async: false
  use ExCheck
  alias Exdash.Collection
  require Integer
  doctest Exdash.Collection
  require Logger

  test "map on empty list" do
    assert [] == Collection.map([], &addOne/1)
  end

  property :map_list do
    for_all n in list(int) do
      Enum.map(n, &addOne/1) == Collection.map(n, &addOne/1)
    end
  end

  test "map on empty map" do
    map = %{}
    assert [] = Collection.map(map, &addOne/1)
  end

  test "pmap on empty list" do
    assert [] == Collection.pmap([], &addOne/1)
  end

  property :pmap_list do
    for_all n in list(int) do
      assert Collection.map(n, &addOne/1) == Collection.pmap(n, &addOne/1)
    end
  end

  test "filter on empty list" do
    assert [] == Collection.filter([], &addOne/1)
  end

  property :filter_list do
    for_all integers in list(int) do
      integers
      |> Enum.filter(&isEven/1)
      |> Kernel.==(Collection.filter(integers, &isEven/1))
    end
  end

  test "filter with empty map" do
    assert [] == Collection.filter(%{}, &isEven/1)
  end

  test "pfilter with empty list" do
    assert [] == Collection.pfilter([], &isEven/1)
  end

  test "pfilter with map" do
    map = %{"a" => 1, "b" => 2, "c" => 3}
    assert [{"b", 2}] == Collection.pfilter(map, &isEven/1)
  end

  property :pfilter_list do
    for_all integers in list(int) do
      integers
      |> Enum.filter(&isEven/1)
      |> Kernel.==(Collection.pfilter(integers, &isEven/1))
    end
  end

  test "every with empty list" do
    assert true == Collection.every([], fn -> true end)
  end

  property :every_with_truthy do
    for_all numbers in such_that(x in list(int(0, 10)) when length(x) > 0) do
      Collection.every(numbers, &(&1 > 0)) == true
    end
  end

  property :every_with_falsy do
    for_all numbers in such_that(x in list(int(0, 10)) when length(x) > 0) do
      Collection.every(numbers, &(&1 < 0)) == false
    end
  end

  test "pevery with empty list" do
    assert true == Collection.pevery([], fn -> true end)
  end

  property :pevery_with_truthy do
    for_all numbers in such_that(x in list(int(0, 10)) when length(x) > 0) do
      Collection.pevery(numbers, &(&1 > 0)) == true
    end
  end

  property :pevery_with_falsy do
    for_all numbers in such_that(x in list(int(0, 10)) when length(x) > 0) do
      Collection.pevery(numbers, &(&1 < 0)) == false
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
    for_all numbers in list(int(0, 10)) do
      find = (fn _ -> true end)
      Collection.find(numbers, nil, find) == Collection.find(numbers, find)
    end
  end

  property :find do
    for_all numbers in such_that(x in list(int(0, 10)) when length(x) > 0) do
      default = nil
      Collection.find(numbers, default, &(&1 > 0)) != default
    end
  end

  test "pfind empty list" do
    default = nil
    assert default == Collection.pfind([], default, fn -> true end)
  end

  property :pfind_defaults do
    for_all numbers in such_that(x in list(int(0, 10)) when length(x) > 0) do
      Collection.pfind(numbers, 1, &(&1 < -10)) == 1
    end
  end

  property :pfind do
    for_all numbers in such_that(x in list(int(0, 10)) when length(x) > 0) do
      find = fn number -> number > 0 end
      Collection.find(numbers, nil, find) == Collection.pfind(numbers, nil, find)
    end
  end

  def addOne(item) do
    item + 1
  end

  def isEven({_key, number}), do: isEven(number)
  def isEven(number) do
    Integer.is_even(number)
  end
end
