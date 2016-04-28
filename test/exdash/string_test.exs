defmodule Exdash.StringTest do
  use ExUnit.Case
  use ExCheck
  alias Exdash.String
  doctest Exdash.String

  test "camel_case empty string" do
    assert "" == String.camel_case("")
  end

  test "camel_case lower case string" do
    str = "foobar"
    assert str == String.camel_case(str)
  end

  test "camel_case spaces" do
    str = "foo bar baz"
    assert "fooBarBaz" == String.camel_case(str)
  end

  test "camel_case underscore" do
    str = "foo_bar_baz"
    assert "fooBarBaz" == String.camel_case(str)
  end

  test "camel_case hyphens" do
    str = "foo-bar-baz"
    assert "fooBarBaz" == String.camel_case(str)
  end

  test "camel_case mixed" do
    str = "foo_bar-baz bam"
    assert "fooBarBazBam" == String.camel_case(str)
  end

  test "camel_case upper case" do
    str = "FooBarBaz"
    assert str == String.camel_case(str)
  end
end
