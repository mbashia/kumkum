defmodule Kumkum.LinksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Kumkum.Links` context.
  """

  @doc """
  Generate a link.
  """
  def link_fixture(attrs \\ %{}) do
    {:ok, link} =
      attrs
      |> Enum.into(%{
        description: "some description",
        link: "some link"
      })
      |> Kumkum.Links.create_link()

    link
  end
end
