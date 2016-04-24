defmodule Exdash.CollectionTest do
  use ExUnit.Case

  test "map on empty list" do
    list = []
    assert list == Exdash.Collection.map([], &(&1))
  end

  test "map on list" do
    list = [1, 2, 3]
    assert [2, 3, 4] == Exdash.Collection.map(list, &(&1 + 1))
  end

  test "map on empty map" do
    map = %{}
    assert [] = Exdash.Collection.map(map, &(&1))
  end

  test "map on map" do
    map = %{"a" => 1, "b" => 2}
    assert [{"a", 2}, {"b", 3}] == Exdash.Collection.map(map, (fn {k, v} ->
      {k, v + 1}
    end))
  end
end
