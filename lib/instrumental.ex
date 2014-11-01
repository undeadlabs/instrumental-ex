defmodule Instrumental do
  alias Instrumental.Connection
  alias Instrumental.Protocol
  alias Instrumental.Time

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    opts = [strategy: :one_for_one, name: Instrumental.Supervisor]
    Supervisor.start_link([], opts)
  end

  def gauge(conn, metric, value, time \\ Time.unix_monotonic) do
    case Protocol.format(:gauge, metric, value, time) do
      {:ok, cmd} ->
        Connection.send_cmd(cmd, conn)
      error -> error
    end
  end

  def increment(conn, metric, value \\ 1, time \\ Time.unix_monotonic) do
    case Protocol.format(:increment, metric, value, time) do
      {:ok, cmd} ->
        Connection.send_cmd(cmd, conn)
      error -> error
    end
  end

  def notice(conn, time \\ Time.unix_monotonic, duration \\ 0, message) do
    case Protocol.format(:notice, time, duration, message) do
      {:ok, cmd} ->
        Connection.send_cmd(cmd, conn)
      error -> error
    end
  end

  def time(conn, metric, multiplier \\ 1, timeout \\ :infinity, fun) when is_binary(metric) and is_function(fun) do
    start  = Time.unix_monotonic
    result = nil
    try do
      task     = Task.async fn -> fun.() end
      result   = Task.await(task, timeout)
    after
      duration = Time.unix_monotonic - start
      gauge(conn, metric, (duration * multiplier), start)
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
