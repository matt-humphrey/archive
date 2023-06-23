defmodule Archive.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :title, :string
    field :rating, :integer
    field :date_read, :date
    belongs_to :author, Archive.Authors.Author
    # many_to_many :tags, Archive.Tags.Tag, join_through: "book_tags", on_replace: :delete
    # has_one :cover_art, Archive.Books.CoverArt

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :rating, :date_read, :author_id])
    |> validate_required([:title])
    |> foreign_key_constraint(:author_id)
  end
end
