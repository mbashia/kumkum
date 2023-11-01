defmodule KumkumWeb.CommandLiveTest do
  use KumkumWeb.ConnCase

  import Phoenix.LiveViewTest
  import Kumkum.CommandsFixtures

  @create_attrs %{command: "some command", description: "some description"}
  @update_attrs %{command: "some updated command", description: "some updated description"}
  @invalid_attrs %{command: nil, description: nil}

  defp create_command(_) do
    command = command_fixture()
    %{command: command}
  end

  describe "Index" do
    setup [:create_command]

    test "lists all commands", %{conn: conn, command: command} do
      {:ok, _index_live, html} = live(conn, Routes.command_index_path(conn, :index))

      assert html =~ "Listing Commands"
      assert html =~ command.command
    end

    test "saves new command", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.command_index_path(conn, :index))

      assert index_live |> element("a", "New Command") |> render_click() =~
               "New Command"

      assert_patch(index_live, Routes.command_index_path(conn, :new))

      assert index_live
             |> form("#command-form", command: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#command-form", command: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.command_index_path(conn, :index))

      assert html =~ "Command created successfully"
      assert html =~ "some command"
    end

    test "updates command in listing", %{conn: conn, command: command} do
      {:ok, index_live, _html} = live(conn, Routes.command_index_path(conn, :index))

      assert index_live |> element("#command-#{command.id} a", "Edit") |> render_click() =~
               "Edit Command"

      assert_patch(index_live, Routes.command_index_path(conn, :edit, command))

      assert index_live
             |> form("#command-form", command: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#command-form", command: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.command_index_path(conn, :index))

      assert html =~ "Command updated successfully"
      assert html =~ "some updated command"
    end

    test "deletes command in listing", %{conn: conn, command: command} do
      {:ok, index_live, _html} = live(conn, Routes.command_index_path(conn, :index))

      assert index_live |> element("#command-#{command.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#command-#{command.id}")
    end
  end

  describe "Show" do
    setup [:create_command]

    test "displays command", %{conn: conn, command: command} do
      {:ok, _show_live, html} = live(conn, Routes.command_show_path(conn, :show, command))

      assert html =~ "Show Command"
      assert html =~ command.command
    end

    test "updates command within modal", %{conn: conn, command: command} do
      {:ok, show_live, _html} = live(conn, Routes.command_show_path(conn, :show, command))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Command"

      assert_patch(show_live, Routes.command_show_path(conn, :edit, command))

      assert show_live
             |> form("#command-form", command: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#command-form", command: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.command_show_path(conn, :show, command))

      assert html =~ "Command updated successfully"
      assert html =~ "some updated command"
    end
  end
end
