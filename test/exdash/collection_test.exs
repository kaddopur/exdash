defmodule Exdash.CollectionTest do
  use ExUnit.Case, async: false
  use ExCheck
  alias Exdash.Collection
  doctest Exdash.Collection

  test "map on empty list" do
    assert [] == Collection.map([], &(&1))
  end

  property :map_list do
    addOne = fn n -> n + 1 end
    for_all n in list(int) do
      Enum.map(n, addOne) == Collection.map(n, addOne)
    end
  end

  test "map on empty map" do
    map = %{}
    assert [] = Collection.map(map, &(&1))
  end

  test "pmap on empty list" do
    assert [] == Collection.pmap([], &(&1))
  end

  property :pmap_list do
    addOne = fn n -> n + 1 end
    for_all n in list(int) do
      assert Collection.map(n, addOne) == Collection.pmap(n, addOne)
    end
  end
end
