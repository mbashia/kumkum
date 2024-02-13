defmodule Kumkum.Repo do
  use Ecto.Repo,
    otp_app: :kumkum,
    adapter: Ecto.Adapters.MyXQL

  use Scrivener, page_size: 5
end
