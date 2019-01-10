defmodule EctoCrypto.Utility.AesTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias EctoCrypto.Utility.Aes

  property "encryption and then decryption yields the original binary" do
    check all string <- binary() do
      assert {:ok, encrypted_data} = Aes.encrypt(string)
      assert {:ok, ^string} = Aes.decrypt(encrypted_data)
    end
  end

  property "encryption and then decryption yields the original string" do
    check all string <- string(:printable) do
      assert {:ok, encrypted_data} = Aes.encrypt(string)
      assert {:ok, ^string} = Aes.decrypt(encrypted_data)
    end
  end
end
