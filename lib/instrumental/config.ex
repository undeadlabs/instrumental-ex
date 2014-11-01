defmodule Instrumental.Config do
  def app do
    {:ok, app} = :application.get_application(__MODULE__)
    app
  end

  def host do
    Application.get_env(app, :host, "collector.instrumentalapp.com")
      |> String.to_char_list
  end

  def port do
    Application.get_env(app, :port, 8000)
  end

  def token do
    Application.get_env(app, :token, "")
  end
end
