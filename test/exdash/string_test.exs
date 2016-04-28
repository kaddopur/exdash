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

  test "kebab_case empty string" do
    assert "" == String.kebab_case("")
  end

  test "kebab_case" do
    str = "kebab-case"
    assert str == String.kebab_case(str)
  end

  test "kebab-case spaces" do
    str = "kebab case"
    assert "kebab-case" == String.kebab_case(str)
  end

  test "kebab-case upper case" do
    str = "KEBAB-CASE"
    assert "kebab-case" == String.kebab_case(str)
  end

  test "downcase_first empty" do
    assert "" == String.downcase_first("")
  end

  test "downcase_first all downcase" do
    str = "downcase"
    assert str == String.downcase_first(str)
  end

  test "downcase_first all upcase" do
    str = "UPCASE"
    assert "uPCASE" == String.downcase_first(str)
  end

  test "snake_case with empty" do
    str = ""
    assert str == String.snake_case(str)
  end

  test "snake_case all upcase" do
    str = "UPCASE"
    assert "upcase" == String.snake_case(str)
  end

  test "snake_case all downcase" do
    str = "downcase"
    assert str == String.snake_case(str)
  end

  test "snake_case" do
    str = "snake case fOo-baR baZ"
    assert "snake_case_foo_bar_baz" == String.snake_case(str)
  end

  test "words empty" do
    assert [] == String.words("")
  end

  test "words" do
    sentence = "foo bar baz"
    assert ["foo", "bar", "baz"] == String.words(sentence)
  end

  test "words ignore special chars" do
    sentence = "foo_bar-baz*"
    assert [sentence] == String.words(sentence)
  end

  test "words with custom pattern" do
    sentence = "foo_bar_baz"
    assert ["foo", "bar", "baz"] == String.words(sentence, ~r"\_")
  end

  test "words trim" do
    sentence = "foo  bar"
    assert ["foo", "bar"] == String.words(sentence)
  end
end
