defmodule DirectEpmdModule.MixProject do
  use Mix.Project

  def project do
    [
      app: :direct_epmd_module,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    []
  end

  defp aliases do
    [
      rebuild: [&my_compile/1]
    ]
  end

  defp my_compile(_) do
    Mix.Task.run("clean", [])
    IEx.Helpers.recompile()
    :erlang.halt()
  end
end
