defmodule BintaTest do
  use ExUnit.Case
  doctest Binta

  test "greets the world" do
    assert Binta.hello() == :world
  end
end
