defmodule KumkumWeb.CommandLive.Show do
  use KumkumWeb, :live_view

  alias Kumkum.Commands

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:command, Commands.get_command!(id))}
  end

  defp page_title(:show), do: "Show Command"
  defp page_title(:edit), do: "Edit Command"
end
