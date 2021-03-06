defmodule TestSchema do
  @moduledoc """
  Ecto Schema to be used for testing EctoCrypto Ecto Types.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias EctoCrypto.EctoTypes.EncryptedBinary

  schema "test_schema" do
    field(:encrypted_string, EncryptedBinary)
  end

  @fields ~w(encrypted_string)a

  def changeset(attrs) do
    changeset(%TestSchema{}, attrs)
  end

  def changeset(%TestSchema{} = schema, attrs) do
    cast(schema, attrs, @fields)
  end
end
