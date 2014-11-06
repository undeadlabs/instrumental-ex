# Instrumental

An Elixir client for [Instrumental](http://instrumentalapp.com)

## Requirements

* Elixir ~> 1.0

## Installation

Add Instrumental as a dependency in your `mix.exs` file

```elixir
def application do
  [applications: [:instrumental]]
end

defp deps do
  [
    {:instrumental, "~> 0.1.0"}
  ]
end
```

Then run `mix deps.get` in your shell to fetch the dependencies.

## Configuration

Add an instrumental config option and a value for token in your `config.exs`

```elixir
config :instrumental,
  token: "mytoken"
```

### Options

  * token (required) - api key for authenticating with instrumental
  * host (optional) - host of instrumental collector
  * port (optional) - port of instrumental collector

## Authors

* Jamie Winsor (<jamie@undeadlabs.com>)
