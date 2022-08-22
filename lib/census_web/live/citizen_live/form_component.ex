defmodule CensusWeb.CitizenLive.FormComponent do
  use CensusWeb, :live_component

  alias Census.Citizens

  @impl true
  def update(%{citizen: citizen} = assigns, socket) do
    changeset = Citizens.change_citizen(citizen)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"citizen" => citizen_params}, socket) do
    changeset =
      socket.assigns.citizen
      |> Citizens.change_citizen(citizen_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"citizen" => citizen_params}, socket) do
    save_citizen(socket, socket.assigns.action, citizen_params)
  end

  defp save_citizen(socket, :edit, citizen_params) do
    case Citizens.update_citizen(socket.assigns.citizen, citizen_params) do
      {:ok, _citizen} ->
        {:noreply,
         socket
         |> put_flash(:info, "Citizen updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_citizen(socket, :new, citizen_params) do
    case Citizens.create_citizen(citizen_params) do
      {:ok, _citizen} ->
        {:noreply,
         socket
         |> put_flash(:info, "Citizen created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
