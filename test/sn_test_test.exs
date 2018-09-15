defmodule SnTestTest do
  use ExUnit.Case
  doctest SnTest

  test "greets the world" do
    assert SnTest.hello() == :world
  end
end
