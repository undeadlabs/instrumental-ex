#
# The MIT License (MIT)
#
# Copyright (c) 2014 Undead Labs, LLC
#

defmodule Instrumental.Protocol do
  alias Instrumental.Config
  alias Instrumental.OS

  @metric_match Regex.compile!("\s")
  @increment "increment"
  @gauge "gauge"
  @gauge_absolute "gauge_absolute"
  @notice "notice"

  @type metric_type :: :increment | :gauge | :gauge_absolute | :notice

  @doc """
  String to be sent to instrumental connection to perform authentication.
  """
  @spec authenticate :: binary
  def authenticate do
    "authenticate #{Config.token}\n"
  end

  @doc """
  Formats the given parameters into a well formed message for Instrumental.
  """
  @spec format(metric_type, binary | integer, integer | float, integer | binary) :: {:ok, binary} | {:error, :invalid_metric}
  def format(:increment, metric, value, time) do
    case metric_valid?(metric) do
      true  -> {:ok, build_command([@increment, metric, value, time])}
      false -> {:error, :invalid_metric}
    end
  end
  def format(:gauge, metric, value, time) do
    case metric_valid?(metric) do
      true  -> {:ok, build_command([@gauge, metric, value, time])}
      false -> {:error, :invalid_metric}
    end
  end
  def format(:gauge_absolute, metric, value, time) do
    case metric_valid?(metric) do
      true  -> {:ok, build_command([@gauge_absolute, metric, value, time])}
      false -> {:error, :invalid_metric}
    end
  end
  def format(:notice, time, duration, message) do
    {:ok, build_command([@notice, time, duration, message])}
  end

  @doc """
  String to be sent to Instrumental to initiate a connection.
  """
  @spec hello :: binary
  def hello do
    "hello version #{version} hostname #{OS.hostname} pid #{OS.pid} runtime #{runtime} platform #{OS.platform}\n"
  end

  @doc """
  Runtime field for the hello message to Instrumental.
  """
  @spec runtime :: binary
  def runtime do
    "BEAM/#{:erlang.system_info(:otp_release)}"
  end

  @doc """
  Version field for the hello message to Instrumental.
  """
  @spec version :: binary
  def version do
    "BEAM/instrumental-ex/#{Instrumental.version}"
  end

  #
  # Private
  #

  defp build_command(args) do
    msg = Enum.map(args, &(to_string(&1)))
      |> Enum.join(" ")
    msg <> "\n"
  end

  defp metric_valid?(metric) do
    case Regex.run(@metric_match, metric) do
      nil -> true
      _   -> false
    end
  end
end
