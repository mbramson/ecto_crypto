defmodule EctoCrypto.Aes do
  @aad "AES256GCM"

  def encrypt(plaintext) do
    initialization_vector = :crypto.strong_rand_bytes(16) # create random Initialisation Vector
    key = get_key()    # get the *latest* key in the list of encryption keys
    {ciphertext, tag} =
      :crypto.block_encrypt(:aes_gcm, key, initialization_vector, {@aad, to_string(plaintext), 16})
    data = initialization_vector <> tag <> ciphertext # "return" iv with the cipher tag & ciphertext
    {:ok, data}
  end

  def decrypt(ciphertext) do
    <<iv::binary-16, tag::binary-16, ciphertext::binary>> = ciphertext
    decrypted = :crypto.block_decrypt(:aes_gcm, get_key(), iv, {@aad, ciphertext, tag})
    {:ok, decrypted}
  end

  def generate_key() do
    :crypto.strong_rand_bytes(32) |> :base64.encode
  end

  defp get_key() do
    case Application.get_env(:ecto_crypto, EctoCrypto.Aes)[:key] do
      nil ->
        raise """
        Could not find EctoCrypto AES key in application configuration.

        Please supply a Base64 encoded encryption key in your application config
        like so:

        config :ecto_crypto, EctoCrypto.Aes
          key: "0KvHAbM+8Fb8x/IDx0sj5OtRxvTTAM3nSjDfz7UX44M=" |> :base64.decode

        NOTE: Please store keys in environment variables at the least! Do not
        commit them to a git repository or otherwise store them in code.

        To generate a key open a console with `iex -S mix` and run:

        EctoCrypto.Aes.generate_key()
        """

      key -> key
    end
  end
end
