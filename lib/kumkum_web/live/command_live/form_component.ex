defmodule KumkumWeb.CommandLive.FormComponent do
  use KumkumWeb, :live_component

  alias Kumkum.Commands

  @impl true
  def update(%{command: command} = assigns, socket) do
    changeset = Commands.change_command(command)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"command" => command_params}, socket) do
    changeset =
      socket.assigns.command
      |> Commands.change_command(command_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"command" => command_params}, socket) do
    save_command(socket, socket.assigns.action, command_params)
  end

  defp save_command(socket, :edit, command_params) do
    case Commands.update_command(socket.assigns.command, command_params) do
      {:ok, _command} ->
        {:noreply,
         socket
         |> put_flash(:info, "Command updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_command(socket, :new, command_params) do
    new_params =
      command_params
      |> Map.put("user_id", socket.assigns.user.id)

    case Commands.create_command(new_params) do
      {:ok, _command} ->
        {:noreply,
         socket
         |> put_flash(:info, "Command created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
