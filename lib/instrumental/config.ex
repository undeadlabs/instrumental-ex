#
# The MIT License (MIT)
#
# Copyright (c) 2014 Undead Labs, LLC
#

defmodule Instrumental.Config do
  @spec app :: atom
  def app do
    {:ok, app} = :application.get_application(__MODULE__)
    app
  end

  @spec enabled? :: boolean
  def enabled? do
    case token do
      ""  -> false
      nil -> false
      _   -> true
    end
  end

  @spec host :: binary
  def host do
    Application.get_env(app, :host, "collector.instrumentalapp.com")
      |> String.to_char_list
  end

  @spec port :: integer
  def port do
    Application.get_env(app, :port, 8000)
  end

  @spec token :: binary
  def token do
    Application.get_env(app, :token, "")
  end
end
