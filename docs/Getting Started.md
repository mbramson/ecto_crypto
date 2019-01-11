# Getting Started

## Description

`EctoCrypto` provides `Ecto` types and utilities for saving data in encrypted
or hashed formats.

The goal is to provide easy to use, sane, and secure cryptographic
functionality that can be dropped directly into `Ecto` schemas.

## Installation

The package can be installed by adding `ecto_crypto` to your list of
dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ecto_crypto, "~> 0.1.0"}
  ]
end
```

## How does it work?

The following assumes that you have a database table generated with the following migration:

```elixir
defmodule Repo.Migrations.CreateTestSchema do
  use Ecto.Migration

  def change do
    create table(:test_schema) do
      add :encrypted_string, :binary
    end
  end
end
```

To create an ecto schema with a field that automatically encrypted at the field
level upon being inserted to the database, use the
`EctoCrypto.EctoTypes.EncryptedBinary` `Ecto` type in the schema.

```elixir
defmodule TestSchema do
  use Ecto.Schema
  import Ecto.Changeset

  schema "test_schema" do
    field(:encrypted_string, EctoCrypto.EctoTypes.EncryptedBinary)
  end

  @fields ~w(encrypted_string)a

  def changeset(attrs) do
    changeset(%TestSchema{}, attrs)
  end

  def changeset(%TestSchema{} = schema, attrs) do
    cast(schema, attrs, @fields)
  end
end
```

When interacting with this schema in elixir, the field should behave like a
regular string or binary field. At the database level, the field will be
encrypted.
