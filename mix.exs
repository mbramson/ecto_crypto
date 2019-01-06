defmodule EctoCrypto.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_crypto,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      name: "EctoCrypto",
      source_url: "https://github.com/mbramson/ecto_crypto",
      package: package(),
      deps: deps()
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
      {:ecto_sql, "~> 3.0"},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:mix_test_watch, "~> 0.6", only: :dev, runtime: false},
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
end
