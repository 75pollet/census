defmodule Census.Repo do
  use Ecto.Repo,
    otp_app: :census,
    adapter: Ecto.Adapters.Postgres
end
