defmodule ServiceATest do
  use ExUnit.Case
  doctest ServiceA

  test "greets the world" do
    assert ServiceA.hello() == :world
  end
end
