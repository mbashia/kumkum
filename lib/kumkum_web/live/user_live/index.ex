defmodule KumkumWeb.UserLive.Index do
  use KumkumWeb, :live_view

  alias Kumkum.Accounts

  @impl true
  def mount(_params, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"])
    users = Accounts.get_users()

    {:ok,
     socket
     |> assign(:user, user)
     |> assign(:users, users)}
  end

  @impl true

  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Links")
    |> assign(:link, nil)
  end
end
