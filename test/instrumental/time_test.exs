defmodule Instrumental.TimeTest do
  alias Instrumental.Time

  use ExUnit.Case

  test "unix_monotonic/0" do
    assert is_integer Time.unix_monotonic
  end
end
