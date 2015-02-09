defmodule Instrumental.Mixfile do
  use Mix.Project

  def project do
    [
      app: :instrumental,
      version: "0.1.1",
      elixir: "~> 1.0",
      deps: deps,
      package: package,
      description: description,
    ]
  end

  def application do
    [
      mod: {Instrumental, []},
      applications: [
        :logger
      ],
      registered: [
        Instrumental.Supervisor,
        Instrumental.Connection,
      ],
      env: [
        host: "collector.instrumentalapp.com",
        port: 8000,
        token: "",
      ],
    ]
  end

  defp deps do
    []
  end

  defp description do
    """
    An Elixir client for Instrumental (http://instrumentalapp.com).
    """
  end

  defp package do
    %{licenses: ["MIT"],
      contributors: ["Jamie Winsor"],
      links: %{"Github" => "https://github.com/undeadlabs/instrumental-ex"}}
  end
end
