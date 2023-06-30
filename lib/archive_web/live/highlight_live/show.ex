defmodule ArchiveWeb.HighlightLive.Show do
  use ArchiveWeb, :live_view

  alias Archive.Highlights

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:highlight, Highlights.get_highlight!(id))}
  end

  defp page_title(:show), do: "Show Highlight"
  defp page_title(:edit), do: "Edit Highlight"
end
