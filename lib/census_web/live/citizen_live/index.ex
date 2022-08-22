defmodule CensusWeb.CitizenLive.Index do
  use CensusWeb, :live_view

  alias Census.Citizens
  alias Census.Citizens.Citizen

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :citizens, list_citizens())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Citizen")
    |> assign(:citizen, Citizens.get_citizen!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Citizen")
    |> assign(:citizen, %Citizen{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Citizens")
    |> assign(:citizen, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    citizen = Citizens.get_citizen!(id)
    {:ok, _} = Citizens.delete_citizen(citizen)

    {:noreply, assign(socket, :citizens, list_citizens())}
  end

  defp list_citizens do
    Citizens.list_citizens()
  end
end
