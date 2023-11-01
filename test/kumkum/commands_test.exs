defmodule Kumkum.CommandsTest do
  use Kumkum.DataCase

  alias Kumkum.Commands

  describe "commands" do
    alias Kumkum.Commands.Command

    import Kumkum.CommandsFixtures

    @invalid_attrs %{command: nil, description: nil}

    test "list_commands/0 returns all commands" do
      command = command_fixture()
      assert Commands.list_commands() == [command]
    end

    test "get_command!/1 returns the command with given id" do
      command = command_fixture()
      assert Commands.get_command!(command.id) == command
    end

    test "create_command/1 with valid data creates a command" do
      valid_attrs = %{command: "some command", description: "some description"}

      assert {:ok, %Command{} = command} = Commands.create_command(valid_attrs)
      assert command.command == "some command"
      assert command.description == "some description"
    end

    test "create_command/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Commands.create_command(@invalid_attrs)
    end

    test "update_command/2 with valid data updates the command" do
      command = command_fixture()
      update_attrs = %{command: "some updated command", description: "some updated description"}

      assert {:ok, %Command{} = command} = Commands.update_command(command, update_attrs)
      assert command.command == "some updated command"
      assert command.description == "some updated description"
    end

    test "update_command/2 with invalid data returns error changeset" do
      command = command_fixture()
      assert {:error, %Ecto.Changeset{}} = Commands.update_command(command, @invalid_attrs)
      assert command == Commands.get_command!(command.id)
    end

    test "delete_command/1 deletes the command" do
      command = command_fixture()
      assert {:ok, %Command{}} = Commands.delete_command(command)
      assert_raise Ecto.NoResultsError, fn -> Commands.get_command!(command.id) end
    end

    test "change_command/1 returns a command changeset" do
      command = command_fixture()
      assert %Ecto.Changeset{} = Commands.change_command(command)
    end
  end
end
