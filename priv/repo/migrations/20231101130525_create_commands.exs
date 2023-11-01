defmodule Kumkum.Repo.Migrations.CreateCommands do
  use Ecto.Migration

  def change do
    create table(:commands) do
      add :command, :string
      add :description, :string
      add :user_id, :integer

      timestamps()
    end
  end
end
