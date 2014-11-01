defmodule Instrumental do
  alias Instrumental.Connection
  alias Instrumental.Protocol
  alias Instrumental.Time

  use Application

  def start(_type, _args) do
    Instrumental.Supervisor.start_link
  end

  def gauge(metric, value, time \\ Time.unix_monotonic) do
    case Protocol.format(:gauge, metric, value, time) do
      {:ok, cmd} ->
        Connection.send_cmd(cmd)
      error -> error
    end
  end

  def increment(metric, value \\ 1, time \\ Time.unix_monotonic) do
    case Protocol.format(:increment, metric, value, time) do
      {:ok, cmd} ->
        Connection.send_cmd(cmd)
      error -> error
    end
  end

  def notice(time \\ Time.unix_monotonic, duration \\ 0, message) do
    case Protocol.format(:notice, time, duration, message) do
      {:ok, cmd} ->
        Connection.send_cmd(cmd)
      error -> error
    end
  end

  def time(metric, multiplier \\ 1, timeout \\ :infinity, fun) when is_binary(metric) and is_function(fun) do
    start  = Time.unix_monotonic
    result = nil
    try do
      task     = Task.async fn -> fun.() end
      result   = Task.await(task, timeout)
    after
      duration = Time.unix_monotonic - start
      gauge(metric, (duration * multiplier), start)
    end
    result
  end

  def version do
    version(:application.loaded_applications)
  end
  defp version([{app, _, vsn}|t]) do
    case :application.get_application(__MODULE__) do
      {:ok, ^app} -> List.to_string(vsn)
      _ -> version(t)
    end
  end
end
