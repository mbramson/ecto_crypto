defmodule TestEctoSchema do
  @moduledoc """
  Ecto Schema to be used for testing EctoCrypto Ecto Types.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "fake_table" do
  end

  @fields ~w()a

  def changeset(attrs) do
    changeset(%TestEctoSchema{}, attrs)
  end

  def changeset(%TestEctoSchema{} = schema, attrs) do
    cast(schema, attrs, @fields)
  end
end
