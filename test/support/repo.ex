defmodule Repo do
  use Ecto.Repo,
    otp_app: :ecto_crypto,
    adapter: Ecto.Adapters.Postgres

  def init(_, opts) do
    {:ok, opts}
  end
end
