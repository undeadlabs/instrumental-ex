#
# The MIT License (MIT)
#
# Copyright (c) 2014 Undead Labs, LLC
#

defmodule Instrumental.Time do
  @doc """
  Unix timestamp in seconds since epoch 1970-01-01.
  """
  @spec unix_monotonic :: integer
  def unix_monotonic do
    :erlang.system_time(:seconds)
  end
end
