defmodule Kumkum.Links do
  @moduledoc """
  The Links context.
  """

  import Ecto.Query, warn: false
  alias Kumkum.Repo

  alias Kumkum.Links.Link

  @doc """
  Returns the list of links.

  ## Examples

      iex> list_links()
      [%Link{}, ...]

  """

  def paginate_links(params, user_id) do
    Repo.paginate(paginate_query(user_id), params)
  end

  def paginate_query(user_id) do
    query = from(l in Link, where: l.user_id == ^user_id)
    query
  end

  def list_links(user_id) do
    Repo.all(from l in Link, where: l.user_id == ^user_id)
  end

  def search(search, user_id) do
    if search == "" do
      list_links(user_id)
    else
      query =
        from l in Link,
          where:
            fragment("? LIKE ?", l.link, ^"%#{search}%") or
              fragment("? LIKE ?", l.description, ^"%#{search}%"),
          where: l.user_id == ^user_id

      Repo.all(query)
      |> Repo.preload(:user)
    end
  end

  @doc """
  Gets a single link.

  Raises `Ecto.NoResultsError` if the Link does not exist.

  ## Examples

      iex> get_link!(123)
      %Link{}

      iex> get_link!(456)
      ** (Ecto.NoResultsError)

  """
  def get_link!(id), do: Repo.get!(Link, id)

  @doc """
  Creates a link.

  ## Examples

      iex> create_link(%{field: value})
      {:ok, %Link{}}

      iex> create_link(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_link(attrs \\ %{}) do
    %Link{}
    |> Link.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a link.

  ## Examples

      iex> update_link(link, %{field: new_value})
      {:ok, %Link{}}

      iex> update_link(link, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_link(%Link{} = link, attrs) do
    link
    |> Link.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a link.

  ## Examples

      iex> delete_link(link)
      {:ok, %Link{}}

      iex> delete_link(link)
      {:error, %Ecto.Changeset{}}

  """
  def delete_link(%Link{} = link) do
    Repo.delete(link)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking link changes.

  ## Examples

      iex> change_link(link)
      %Ecto.Changeset{data: %Link{}}

  """
  def change_link(%Link{} = link, attrs \\ %{}) do
    Link.changeset(link, attrs)
  end
end
