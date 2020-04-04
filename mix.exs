defmodule SimpleWeather.MixProject do
  use Mix.Project

  def project do
    [
      app: :simple_weather,
      version: "0.1.0",
      elixir: "~> 1.10",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix] ++ Mix.compilers(),
      elixirc_options: [warnings_as_errors: true],
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      deps: deps(),
      releases: [
        prod: [
          steps: [:assemble, :tar]
        ]
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {SimpleWeather.Application, []},
      extra_applications: [:logger, :runtime_tools, :darkskyx, :timex]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.4.14"},
      {:phoenix_pubsub, "~> 1.1"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:darkskyx, "~> 1.0"},
      {:mox, "~> 0.5.2", only: :test},
      {:timex, "~> 3.5"},
      {:enum_type, "~> 1.0.1"},
      {:excoveralls, "~> 0.10", only: :test},
      {:dialyxir, "~> 0.4", only: [:dev]}
    ]
  end
end
