defmodule Exdash.Mixfile do
  use Mix.Project

  def project do
    [app: :exdash,
     version: "0.2.0",
     name: "ExDash",
     source_url: "https://github.com/TFarla/exdash",
     homepage_url: "https://github.com/TFarla/exdash",
     description: description,
     package: package,
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: [coveralls: :test]]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  defp description do
    """
    Lodash implementation for Elixir
    """
  end

  defp package do
    [# These are the default files included in the package
     files: ["lib", "priv", "mix.exs", "README*", "CHANGELOG*", "readme*", "LICENSE*", "license*"],
     maintainers: ["Thomas Farla"],
     licenses: ["MIT License"],
     links: %{"GitHub" => "https://github.com/TFarla/exdash",
              "Docs" => ""}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:ex_doc, "~> 0.11", only: :dev},
     {:excoveralls, "~> 0.4", only: :test},
     {:excheck, "~> 0.3", only: :test},
     {:triq, github: "krestenkrab/triq", only: :test}]
  end
end
