defmodule ArchiveWeb.HighlightLive.Index do
  use ArchiveWeb, :live_view

  alias Archive.Highlights
  alias Archive.Highlights.Highlight

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :highlights, Highlights.list_highlights())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Highlight")
    |> assign(:highlight, Highlights.get_highlight!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Highlight")
    |> assign(:highlight, %Highlight{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Highlights")
    |> assign(:highlight, nil)
  end

  @impl true
  def handle_info({ArchiveWeb.HighlightLive.FormComponent, {:saved, highlight}}, socket) do
    {:noreply, stream_insert(socket, :highlights, highlight)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    highlight = Highlights.get_highlight!(id)
    {:ok, _} = Highlights.delete_highlight(highlight)

    {:noreply, stream_delete(socket, :highlights, highlight)}
  end
end
