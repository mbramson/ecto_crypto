defmodule EctoCrypto.EctoTypes.EncryptedBinary do
  @moduledoc """
  Ecto Type for encrypting and decrypting binaries (including strings).

  Defines an Ecto Type which can be cast as a binary string which encrypts the
  string using AES-256 GCM before it is inserted into the database.

  When the value is retrieved from the database, it is decrypted before it is
  dumped to the Ecto schema struct.
  """

  alias EctoCrypto.Utility.Aes

  @behaviour Ecto.Type

  def type, do: :binary

  def cast(value) do
    {:ok, to_string(value)}
  end

  def dump(value) do
    value |> to_string |> Aes.encrypt
  end

  def embed_as(_), do: :dump

  def load(value) do
    Aes.decrypt(value)
  end

  def equal?(value, other_value) do
    value == other_value
  end
end
