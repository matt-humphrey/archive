defmodule ArchiveWeb.HighlightLive.FormComponent do
  use ArchiveWeb, :live_component

  alias Archive.Highlights

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage highlight records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="highlight-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:content]} type="text" label="Content" />
        <.input field={@form[:note]} type="text" label="Note" />
        <.input field={@form[:reference]} type="text" label="Reference" />
        <.input field={@form[:date]} type="date" label="Date Highlighted" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Highlight</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{highlight: highlight} = assigns, socket) do
    changeset = Highlights.change_highlight(highlight)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"highlight" => highlight_params}, socket) do
    changeset =
      socket.assigns.highlight
      |> Highlights.change_highlight(highlight_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"highlight" => highlight_params}, socket) do
    save_highlight(socket, socket.assigns.action, highlight_params)
  end

  defp save_highlight(socket, :edit, highlight_params) do
    case Highlights.update_highlight(socket.assigns.highlight, highlight_params) do
      {:ok, highlight} ->
        notify_parent({:saved, highlight})

        {:noreply,
         socket
         |> put_flash(:info, "Highlight updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_highlight(socket, :new, highlight_params) do
    case Highlights.create_highlight(highlight_params) do
      {:ok, highlight} ->
        notify_parent({:saved, highlight})

        {:noreply,
         socket
         |> put_flash(:info, "Highlight created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
