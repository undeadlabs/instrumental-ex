defmodule Instrumental.ProtocolTest do
  alias Instrumental.Protocol
  alias Instrumental.Time

  use ExUnit.Case

  test "format/5 formatting a valid increment message" do
    metric     = "test-metric"
    value      = 1
    time       = Time.unix_monotonic
    {:ok, msg} = Protocol.format(:increment, metric, value, time)

    assert msg == "increment #{metric} #{value} #{time}\n"
  end

  test "format/5 formatting a valid gauage message" do
    metric     = "test-metric"
    value      = 1
    time       = Time.unix_monotonic
    {:ok, msg} = Protocol.format(:gauge, metric, value, time)

    assert msg == "gauge #{metric} #{value} #{time}\n"
  end
end
