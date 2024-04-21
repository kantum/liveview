defmodule Ines.Repo do
  use Ecto.Repo,
    otp_app: :ines,
    adapter: Ecto.Adapters.Postgres
end
