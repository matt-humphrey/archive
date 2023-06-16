defmodule Archive.BooksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Archive.Books` context.
  """

  @doc """
  Generate a book.
  """
  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(%{
        title: "some title",
        author: "some author",
        rating: 42,
        date_read: ~N[2023-06-15 04:29:00]
      })
      |> Archive.Books.create_book()

    book
  end
end
