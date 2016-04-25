defmodule Exdash.CollectionTest do
  use ExUnit.Case, async: false
  use ExCheck
  alias Exdash.Collection
  doctest Exdash.Collection

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

  def addOne(item) do
    item + 1
  end

  def isEven(number) do
    rem(number, 2) == 0
  end
end
