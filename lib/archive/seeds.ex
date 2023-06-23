defmodule Archive.Seeds do
  alias Archive.Authors
  alias Archive.Authors.Author
  alias Archive.Books
  alias Archive.Books.Book
  # alias Archive.Genres
  # alias Archive.Genres.Genre
  alias Archive.Repo

  def seed do
    seed_author()
    seed_book()
    seed_author_with_book()
    # seed_genres()
  end

  def seed_author do
    case Repo.get_by(Author, name: "Andrew Rowe") do
      %Author{} = author ->
        IO.inspect(author.name, label: "Author Already Created")

      nil ->
        Authors.create_author(%{name: "Andrew Rowe"})
    end
  end

  def seed_book() do
    case Repo.get_by(Book, title: "Beowulf") do
      %Book{} = book ->
        IO.inspect(book.title, label: "Book Already Created")

      nil ->
        Books.create_book(%{title: "Beowulf"})
    end
  end

  # Create an author with a book.
  def seed_author_with_book do
    {:ok, author} =
      case Repo.get_by(Author, name: "Patrick Rothfuss") do
        %Author{} = author ->
          IO.inspect(author.name, label: "Author Already Created")
          {:ok, author}

        nil ->
          Authors.create_author(%{name: "Patrick Rothfuss"})
      end

    case Repo.get_by(Book, title: "Name of the Wind") do
      %Book{} = book ->
        IO.inspect(book.title, label: "Book Already Created")

      nil ->
        %Book{}
        |> Book.changeset(%{title: "Name of the Wind"})
        |> Ecto.Changeset.put_assoc(:author, author)
        |> Repo.insert!()
    end

    case Repo.get_by(Book, title: "The Wise Man's Fear") do
      %Book{} = book ->
        IO.inspect(book.title, label: "Book Already Created")

      nil ->
        %Book{}
        |> Book.changeset(%{title: "The Wise Man's Fear"})
        |> Ecto.Changeset.put_assoc(:author, author)
        |> Repo.insert!()
    end
  end

  # def seed_genres do
  #   # Create genres
  #   ["fiction", "fantasy", "history", "sci-fi"]
  #   |> Enum.each(fn genre_name ->
  #     case Repo.get_by(Genre, name: genre_name) do
  #       %Genre{} = _genre ->
  #         IO.inspect(genre_name, label: "Genre Already Created")

  #       nil ->
  #         Genres.create_genre(%{name: genre_name})
  #     end
  #   end)
  # end
end
