defmodule Archive.Highlights.Highlight do
  use Ecto.Schema
  import Ecto.Changeset

  schema "highlights" do
    field :reference, :string
    field :content, :string
    field :note, :string
    field :date, :date
    belongs_to :book, Archive.Books.Book
    belongs_to :author, Archive.Authors.Author

    timestamps()
  end

  @doc false
  def changeset(highlight, attrs) do
    highlight
    |> cast(attrs, [:content, :note, :reference, :date, :book_id, :author_id])
    # |> validate_required([:content])
    |> foreign_key_constraint(:book_id)
    |> foreign_key_constraint(:author_id)
  end
end
