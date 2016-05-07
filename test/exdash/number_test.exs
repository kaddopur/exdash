defmodule Exdash.NumberTest do
  use ExUnit.Case
  use ExCheck
  import Exdash, only: [in_range?: 2]
  doctest Exdash.Number

  test "in_range? falsy" do
    refute in_range?(0, 1..10)
  end

  test "in_range? truthy" do
    assert in_range?(5, 1..10)
  end

  test "in_range? n equals start of range" do
    assert in_range?(1, 1..10)
  end

  test "in_range? n equals last of range" do
    refute in_range?(10, 1..10)
  end

  test "in_range? truthy with negative range" do
    assert in_range?(-10, -1..-100)
  end

  test "in_range? flasy with negative range" do
    refute in_range?(-10, -1..-8)
  end

  test "in_range? should start at 0" do
    assert {false, false, true} ==
      {in_range?(-1, 1), in_range?(0, 0), in_range?(1, 2)}
  end

  property :in_range_with_number do
    for_all {n, range} in {int(0, 10), int(0, 10)} do
      in_range?(n, 0..range) == in_range?(n, range)
    end
  end
end
