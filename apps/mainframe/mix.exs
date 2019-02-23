defmodule Mainframe.MixProject do
  use Mix.Project

  def project do
    [
      app: :mainframe,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Mainframe.Application, []}
    ]
  end

  defp deps do
    [
      {:distillery, "~> 2.0"},
      {:libcluster, "~> 3.0"},
      {:conduit, in_umbrella: true}
    ]
  end
end
