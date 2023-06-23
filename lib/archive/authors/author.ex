defmodule Archive.Authors.Author do
  use Ecto.Schema
  import Ecto.Changeset

  schema "authors" do
    field :name, :string
    has_many :books, Archive.Books.Book

    timestamps()
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
