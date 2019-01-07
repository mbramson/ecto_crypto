use Mix.Config

config :ecto_crypto,
  ecto_repos: [Repo]

config :ecto_crypto, Repo,
  username: System.get_env("PG_USER"),
  password: System.get_env("PG_PASSWORD"),
  database: "ecto_crypto_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

import_config "#{Mix.env}.exs"
