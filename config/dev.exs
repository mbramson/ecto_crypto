use Mix.Config

config :ecto_crypto, EctoCrypto.Aes,
  key: System.get_env("ECTO_CRYPTO_AES_KEY") |> :base64.decode
