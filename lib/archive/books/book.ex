defmodule Archive.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :title, :string
    field :author, :string
    field :rating, :integer
    field :date_read, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :author, :rating, :date_read])
    |> validate_required([:title, :author])
  end
end
