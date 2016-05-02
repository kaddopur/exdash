defmodule Exdash.StringTest do
  use ExUnit.Case
  use ExCheck
  doctest Exdash.String

  test "camel_case empty string" do
    assert "" == Exdash.camel_case("")
  end

  test "camel_case lower case string" do
    str = "foobar"
    assert str == Exdash.camel_case(str)
  end

  test "camel_case spaces" do
    str = "foo bar baz"
    assert "fooBarBaz" == Exdash.camel_case(str)
  end

  test "camel_case underscore" do
    str = "foo_bar_baz"
    assert "fooBarBaz" == Exdash.camel_case(str)
  end

  test "camel_case hyphens" do
    str = "foo-bar-baz"
    assert "fooBarBaz" == Exdash.camel_case(str)
  end

  test "camel_case mixed" do
    str = "foo_bar-baz bam"
    assert "fooBarBazBam" == Exdash.camel_case(str)
  end

  test "camel_case upper case" do
    str = "FooBarBaz"
    assert str == Exdash.camel_case(str)
  end

  test "kebab_case empty string" do
    assert "" == Exdash.kebab_case("")
  end

  test "kebab_case" do
    str = "kebab-case"
    assert str == Exdash.kebab_case(str)
  end

  test "kebab-case spaces" do
    str = "kebab case"
    assert "kebab-case" == Exdash.kebab_case(str)
  end

  test "kebab-case upper case" do
    str = "KEBAB-CASE"
    assert "kebab-case" == Exdash.kebab_case(str)
  end

  test "downcase_first empty" do
    assert "" == Exdash.downcase_first("")
  end

  test "downcase_first all downcase" do
    str = "downcase"
    assert str == Exdash.downcase_first(str)
  end

  test "downcase_first all upcase" do
    str = "UPCASE"
    assert "uPCASE" == Exdash.downcase_first(str)
  end

  test "upcase_first empty" do
    str = ""
    assert str == Exdash.upcase_first(str)
  end

  test "upcase_first all upcase" do
    str = "FOO BAR BAZ"
    assert str == Exdash.upcase_first(str)
  end

  test "upcase_first all downcase" do
    str = "foo bar baz"
    assert "Foo bar baz" == Exdash.upcase_first(str)
  end

  test "snake_case with empty" do
    str = ""
    assert str == Exdash.snake_case(str)
  end

  test "snake_case all upcase" do
    str = "UPCASE"
    assert "upcase" == Exdash.snake_case(str)
  end

  test "snake_case all downcase" do
    str = "downcase"
    assert str == Exdash.snake_case(str)
  end

  test "snake_case" do
    str = "snake case fOo-baR baZ"
    assert "snake_case_foo_bar_baz" == Exdash.snake_case(str)
  end

  test "words empty" do
    assert [] == Exdash.words("")
  end

  test "words" do
    sentence = "foo bar baz"
    assert ["foo", "bar", "baz"] == Exdash.words(sentence)
  end

  test "words ignore special chars" do
    sentence = "foo_bar-baz*"
    assert [sentence] == Exdash.words(sentence)
  end

  test "words trim" do
    sentence = "foo  bar"
    assert ["foo", "bar"] == Exdash.words(sentence)
  end
end
