defmodule EctoCryptoTest do
  use ExUnit.Case
  doctest EctoCrypto

  test "can insert and retrieve and encrypted string" do
    attrs = %{encrypted_string: "cats"}
    changeset = TestSchema.changeset(%TestSchema{}, attrs)
    assert {:ok, struct} = Repo.insert(changeset)
    IO.inspect struct, label: "struct"
    
    assert [returned_schema] = Repo.all(TestSchema)
    assert returned_schema.encrypted_string == "cats"
  end
end
