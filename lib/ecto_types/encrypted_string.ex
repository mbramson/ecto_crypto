defmodule EctoCrypto.EctoTypes.EncryptedString do
  @moduledoc """
  Ecto Type for an encrypted string.

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

  def load(value) do
    Aes.decrypt(value)
  end
end
