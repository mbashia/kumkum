defmodule Kumkum.CommandsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Kumkum.Commands` context.
  """

  @doc """
  Generate a command.
  """
  def command_fixture(attrs \\ %{}) do
    {:ok, command} =
      attrs
      |> Enum.into(%{
        command: "some command",
        description: "some description"
      })
      |> Kumkum.Commands.create_command()

    command
  end
end
