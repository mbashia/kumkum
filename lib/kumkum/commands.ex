defmodule Kumkum.Commands do
  @moduledoc """
  The Commands context.
  """

  import Ecto.Query, warn: false
  alias Kumkum.Repo

  alias Kumkum.Commands.Command

  @doc """
  Returns the list of commands.

  ## Examples

      iex> list_commands()
      [%Command{}, ...]

  """
  def list_commands(user_id) do
    Repo.all(from c in Command, where: c.user_id == ^user_id)
  end

  def search(search, user_id) do
    if search == "" do
      list_commands(user_id)
    else
      query =
        from c in Command,
          where:
            fragment("? LIKE ?", c.command, ^"%#{search}%") or
              fragment("? LIKE ?", c.description, ^"%#{search}%"),
          where: c.user_id == ^user_id

      Repo.all(query)
      |> Repo.preload(:user)
    end
  end

  # def search(search) do
  #   #   if search == "" do
  #   #     search_results =
  #   #       Repo.all(Trip)
  #   #       |> Repo.preload(:user)
  #   #   else
  #   #     new_search = String.downcase(search)

  #   #     search_results =
  #   #       Repo.all(Trip)
  #   #       |> Enum.filter(fn trip ->
  #   #         String.contains?(String.downcase(trip.from), new_search) or
  #   #           String.contains?(String.downcase(trip.to), new_search)
  #   #       end)
  #   #       |> Repo.preload(:user)
  #   #   end
  #   # end

  @doc """
  Gets a single command.

  Raises `Ecto.NoResultsError` if the Command does not exist.

  ## Examples

      iex> get_command!(123)
      %Command{}

      iex> get_command!(456)
      ** (Ecto.NoResultsError)

  """
  def get_command!(id), do: Repo.get!(Command, id)

  @doc """
  Creates a command.

  ## Examples

      iex> create_command(%{field: value})
      {:ok, %Command{}}

      iex> create_command(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_command(attrs \\ %{}) do
    %Command{}
    |> Command.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a command.

  ## Examples

      iex> update_command(command, %{field: new_value})
      {:ok, %Command{}}

      iex> update_command(command, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_command(%Command{} = command, attrs) do
    command
    |> Command.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a command.

  ## Examples

      iex> delete_command(command)
      {:ok, %Command{}}

      iex> delete_command(command)
      {:error, %Ecto.Changeset{}}

  """
  def delete_command(%Command{} = command) do
    Repo.delete(command)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking command changes.

  ## Examples

      iex> change_command(command)
      %Ecto.Changeset{data: %Command{}}

  """
  def change_command(%Command{} = command, attrs \\ %{}) do
    Command.changeset(command, attrs)
  end
end
