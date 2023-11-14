defmodule Kumkum.Repo do
  use Ecto.Repo,
    otp_app: :kumkum,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 1
end
