defmodule CensusWeb.CitizenLive.Show do
  use CensusWeb, :live_view

  alias Census.Citizens

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:citizen, Citizens.get_citizen!(id))}
  end

  defp page_title(:show), do: "Show Citizen"
  defp page_title(:edit), do: "Edit Citizen"
end
