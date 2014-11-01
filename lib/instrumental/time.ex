defmodule Instrumental.Time do
  def unix_monotonic do
    {mega, sec, _} = :erlang.now
    mega * 1_000_000 + sec
  end
end
