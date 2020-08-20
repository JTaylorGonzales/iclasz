defmodule Iclasz.Repo do
  use Ecto.Repo,
    otp_app: :iclasz,
    adapter: Ecto.Adapters.Postgres
end
