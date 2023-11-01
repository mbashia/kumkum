defmodule Kumkum.Links.Link do
  use Ecto.Schema
  import Ecto.Changeset
  alias Kumkum.Accounts.User

  schema "links" do
    field :description, :string
    field :link, :string
    belongs_to :user, User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:link, :description, :user_id])
    |> validate_required([:link, :description, :user_id])
  end
end
