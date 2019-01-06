use Mix.Config

config :ecto_crypto, TestRepo,
  username: System.get_env("PG_USER"),
  password: System.get_env("PG_PASSWORD"),
  database: "ecto_crypto_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

