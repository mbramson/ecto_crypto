defmodule EctoCrypto.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_crypto,
      version: "0.2.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      name: "EctoCrypto",
      source_url: "https://github.com/mbramson/ecto_crypto",
      package: package(),
      deps: deps(),
      docs: docs()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:ecto, "~> 3.0"},
      {:ecto_sql, "~> 3.0", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:mix_test_watch, "~> 0.6", only: :dev, runtime: false},
      {:postgrex,   ">= 0.0.0", only: :test},
      {:stream_data, "~> 0.4", only: :test},
    ]
  end

  defp description() do
    """
    EctoCrypto provides Ecto Types relating to Cryptographic concerns such as
    encrypted or hashed data.
    """
  end

  defp package() do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE.md"],
      maintainers: ["Mathew Bramson"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/mbramson/ecto_crypto"}
    ]
  end

  defp docs() do
    [
      main: "getting-started",
      formatter_opts: [gfm: true],
      source_url: "https://github.com/mbramson/ecto_crypto",
      extras: [
        "docs/Getting Started.md"
      ]
    ]
  end
end
