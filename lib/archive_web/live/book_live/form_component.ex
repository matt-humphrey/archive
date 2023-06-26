defmodule ArchiveWeb.BookLive.FormComponent do
  use ArchiveWeb, :live_component

  alias Archive.Authors
  alias Archive.Authors.Author
  alias Archive.Books
  alias Archive.Repo

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage book records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="book-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:author_name]} type="text" label="Author" />
        <.input field={@form[:rating]} type="number" label="Rating" />
        <.input field={@form[:date_read]} type="date" label="Date Read" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Book</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{book: book} = assigns, socket) do
    changeset = Books.change_book(book)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"book" => book_params}, socket) do
    # {_author_name, book_params} = Map.pop(book_params, "author_name")

    changeset =
      socket.assigns.book
      |> Books.change_book(book_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"book" => book_params}, socket) do
    {author_name, book_params} = Map.pop(book_params, "author_name")

    save_book(socket, socket.assigns.action, book_params, author_name)
  end

  defp save_book(socket, :edit, book_params, author_name) do
    {:ok, author} =
      case Repo.get_by(Author, name: author_name) do
        %Author{} = author ->
          IO.inspect(author.name, label: "Author Already Created")
          {:ok, author}

        nil ->
          Authors.create_author(%{name: author_name})
      end

    book_params = Map.put(book_params, "author_id", author.id)

    case Books.update_book(socket.assigns.book, book_params) do
      {:ok, book} ->
        notify_parent({:saved, book})

        {:noreply,
         socket
         |> put_flash(:info, "Book updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_book(socket, :new, book_params, author_name) do
    {:ok, author} =
      case Repo.get_by(Author, name: author_name) do
        %Author{} = author ->
          IO.inspect(author.name, label: "Author Already Created")
          {:ok, author}

        nil ->
          Authors.create_author(%{name: author_name})
      end

    book_params = Map.put(book_params, "author_id", author.id)

    case Books.create_book(book_params) do
      {:ok, book} ->
        notify_parent({:saved, book})

        {:noreply,
         socket
         |> put_flash(:info, "Book created successfully")
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
