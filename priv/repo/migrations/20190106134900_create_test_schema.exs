defmodule Repo.Migrations.CreateTestSchema do
  use Ecto.Migration

  def change do
    create table(:test_schema) do
      add :encrypted_string, :binary
    end
  end
end
