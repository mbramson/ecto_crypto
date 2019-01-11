use Mix.Config

defp aes_key() do
  case System.get_env("ECTO_CRYPTO_AES_KEY") do
    nil ->
      "0KvHAbM+8Fb8x/IDx0sj5OtRxvTTAM3nSjDfz7UX44M=" |> :base64.decode
    base_64_encoded_key ->
      :base64.decode(base_64_encoded_key)
  end
end

config :ecto_crypto, EctoCrypto.Aes,
  key: aes_key()
