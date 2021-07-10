defmodule EctoCrypto.Utility.Aes do
  @moduledoc """
  Utility module for encrypting and decrypting with AES-256 GCM.
  """

  @aad "AES256GCM"

  @doc """
  Encrypts plaintext to ciphertext using AES-256 GCM.

  Uses the key stored in application configuration.
  """
  def encrypt(plaintext) do
    initialization_vector = :crypto.strong_rand_bytes(16) # create random Initialisation Vector
    {ciphertext, tag} = block_encrypt(plaintext, get_key(), initialization_vector)
    data = initialization_vector <> tag <> ciphertext # "return" iv with the cipher tag & ciphertext
    {:ok, data}
  end

  @doc """
  Decrypts ciphertext encrypted with AES-256 GCM into plaintext.

  Uses they key stored in application configuration.
  """
  def decrypt(ciphertext) do
    <<iv::binary-16, tag::binary-16, ciphertext::binary>> = ciphertext
    decrypted = block_decrypt(ciphertext, get_key(), iv, tag)
    {:ok, decrypted}
  end

  if System.otp_release() |> String.to_integer() >= 23 do
    defp block_encrypt(plaintext, key, initialization_vector) do
      :crypto.crypto_one_time_aead(:aes_256_gcm, key, initialization_vector, plaintext, @aad, true)
    end

    defp block_decrypt(ciphertext, key, initialization_vector, tag) do
      :crypto.crypto_one_time_aead(:aes_256_gcm, key, initialization_vector, ciphertext, @aad, tag, false) 
    end
  else
    defp block_encrypt(plaintext, key, initialization_vector) do
      :crypto.block_encrypt(:aes_gcm, key, initialization_vector, {@aad, to_string(plaintext), 16})
    end

    defp block_decrypt(ciphertext, key, initialization_vector, tag) do
      :crypto.block_decrypt(:aes_gcm, key, initialization_vector, {@aad, ciphertext, tag})
    end
  end

  @doc """
  Generates a key suitable for encrypting/decrypting with AES-256 GCM.
  """
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

        config :ecto_crypto, EctoCrypto.Aes,
          key: "0KvHAbM+8Fb8x/IDx0sj5OtRxvTTAM3nSjDfz7UX44M=" |> :base64.decode

        NOTE: Please store keys in environment variables at the least! Do not
        commit them to a git repository or otherwise store them in code.

        To generate a key open a console with `iex -S mix` and run:

        EctoCrypto.Utility.Aes.generate_key()
        """

      key -> key
    end
  end
end
