defmodule KumkumWeb.CommandLive.Index do
  use KumkumWeb, :live_view

  alias Kumkum.Commands
  alias Kumkum.Commands.Command
  alias Kumkum.Accounts

  @impl true
  def mount(_params, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"])
    IO.inspect(user)
    changeset = Commands.change_command(%Command{})

    {:ok,
     socket
     |> assign(:user, user)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    IO.inspect(params )
    commands = Commands.paginate_commands(params, socket.assigns.user.id)

    changeset = Commands.change_command(%Command{})

    {:noreply,
     socket
     |> apply_action(socket.assigns.live_action, params)
     |> assign(:commands, commands.entries)
     |> assign(:search_changeset, changeset)
     |> assign(:total_pages, commands.total_pages)
     |> assign(:page_number, commands.page_number)
     |> assign(:total_entries, commands.total_entries)}
  end

  @spec handle_event(<<_::48, _::_*72>>, any(), %{
          :assigns =>
            atom()
            | %{
                :user => atom() | %{:id => any(), optional(any()) => any()},
                optional(any()) => any()
              },
          optional(any()) => any()
        }) :: {:noreply, map()}
  def handle_event("validate_search", %{"command" => %{"command" => search}}, socket) do
    IO.inspect(search)
    commands = Commands.search(search, socket.assigns.user.id)

    {:noreply,
     socket
     |> assign(:commands, commands)}
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

    {:noreply, assign(socket, :commands, list_commands(socket.assigns.user.id))}
  end

  defp list_commands(user_id) do
    Commands.list_commands(user_id)
  end
end
