defmodule KumkumWeb.CommandLive.Index do
  use KumkumWeb, :live_view

  alias Kumkum.Commands
  alias Kumkum.Commands.Command
  alias Kumkum.Accounts

  @impl true
  def mount(_params, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"])
    IO.inspect(user)

    {:ok,
     socket
     |> assign(:commands, list_commands())
     |> assign(:user, user)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Command")
    |> assign(:command, Commands.get_command!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Command")
    |> assign(:command, %Command{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Commands")
    |> assign(:command, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    command = Commands.get_command!(id)
    {:ok, _} = Commands.delete_command(command)

    {:noreply, assign(socket, :commands, list_commands())}
  end

  defp list_commands do
    Commands.list_commands()
  end
end
