defmodule KumkumWeb.LinkLive.Index do
  use KumkumWeb, :live_view

  alias Kumkum.Links
  alias Kumkum.Links.Link
  alias Kumkum.Accounts

  @impl true
  def mount(_params, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"])
    IO.inspect(user)
    changeset = Links.change_link(%Link{})

    {:ok,
     socket
     |> assign(:links, list_links(user.id))
     |> assign(:user, user)
     |> assign(:search_changeset, changeset)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Link")
    |> assign(:link, Links.get_link!(id))
  end

  def handle_event("validate_search", %{"link" => %{"link" => search}}, socket) do
    links = Links.search(search, socket.assigns.user.id)
    IO.inspect(links)

    {:noreply,
     socket
     |> assign(:links, links)}
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Link")
    |> assign(:link, %Link{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Links")
    |> assign(:link, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    link = Links.get_link!(id)
    {:ok, _} = Links.delete_link(link)

    {:noreply, assign(socket, :links, list_links(socket.assigns.user.id))}
  end

  defp list_links(user_id) do
    Links.list_links(user_id)
  end
end
