defmodule Kumkum.Commands.Command do
  use Ecto.Schema
  import Ecto.Changeset
  alias Kumkum.Accounts.User

  schema "commands" do
    field :command, :string
    field :description, :string
    belongs_to :user, User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(command, attrs) do
    command
    |> cast(attrs, [:command, :description, :user_id])
    |> validate_required([:command, :description, :user_id])
  end
end
