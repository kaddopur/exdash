defmodule Exdash.NumberTest do
  use ExUnit.Case
  use ExCheck
  import Exdash, only: [in_range?: 2, random: 2, random: 1]
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

  property :in_range_with_float do
    for_all n in such_that(x in real when x > 0) do
      in_range?(0.01, n)
    end
  end

  property :in_range_with_number do
    for_all {n, range} in {int(0, 10), int(0, 10)} do
      in_range?(n, 0..range) == in_range?(n, range)
    end
  end

  property :random_integer do
    for_all n in int(0, 100) do
      {lower, upper} = {n, n + 10}
      random(lower, upper)
      |> in_range?(lower..upper+1)
    end
  end

  property :random_negative_integer do
    for_all n in int(2, 10) do
      {lower, upper} = {n * -1, n * -1 + 10}
      random = random(lower, upper)
      in_range?(random, lower..upper + 1) and is_integer(random)
    end
  end

  test "random with 0" do
    assert 0 == random(0, 0)
  end

  property :random_float do
    for_all n in such_that(x in real when x > 0) do
      {lower, upper} = {n, n + 10}
      random = random(lower, upper)
      in_range?(random, upper + 1) and is_float(random)
    end
  end

  property :random_upper_integer do
    for_all n in such_that(x in int when x > 0) do
      random = random(n)
      in_range?(random, n + 1) and is_integer(random)
    end
  end

  property :random_upper_float do
    for_all n in such_that(x in real when x > 0) do
      random = random(n)
      in_range?(random, n + 1) and is_float(random)
    end
  end

  test "random float with 0" do
    assert 0 == random(0.0, 0.0)
  end

  test "random 0" do
    assert 0 == random(0)
  end
end
