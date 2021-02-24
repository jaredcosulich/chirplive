defmodule Chirplive.Repo do
  use Ecto.Repo,
    otp_app: :chirplive,
    adapter: Ecto.Adapters.Postgres
end
