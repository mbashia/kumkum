defmodule KumkumWeb.LinkLive.Index do
  use KumkumWeb, :live_view

  alias Kumkum.Links
  alias Kumkum.Links.Link
  alias Kumkum.Accounts

  @impl true
  def mount(params, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"])

    changeset = Links.change_link(%Link{})

    {:ok,
     socket
     |> assign(:user, user)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    links = Links.paginate_links(params, socket.assigns.user.id)
    changeset = Links.change_link(%Link{})

    IO.inspect(links)

    {:noreply,
     socket
     |> apply_action(socket.assigns.live_action, params)
     |> assign(:links, links.entries)
     |> assign(:search_changeset, changeset)
     |> assign(:total_pages, links.total_pages)
     |> assign(:page_number, links.page_number)
     |> assign(:total_entries, links.total_entries)}
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
