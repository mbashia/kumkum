defmodule Kumkum.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :link, :string
      add :description, :string
      add :user_id, :integer

      timestamps()
    end
  end
end
