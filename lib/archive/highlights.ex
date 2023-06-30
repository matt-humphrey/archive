defmodule Archive.Highlights do
  @moduledoc """
  The Highlights context.
  """

  import Ecto.Query, warn: false
  alias Archive.Repo

  alias Archive.Highlights.Highlight

  @doc """
  Returns the list of highlights.

  ## Examples

      iex> list_highlights()
      [%Highlight{}, ...]

  """
  def list_highlights do
    Repo.all(Highlight)
  end

  @doc """
  Gets a single highlight.

  Raises `Ecto.NoResultsError` if the Highlight does not exist.

  ## Examples

      iex> get_highlight!(123)
      %Highlight{}

      iex> get_highlight!(456)
      ** (Ecto.NoResultsError)

  """
  def get_highlight!(id), do: Repo.get!(Highlight, id)

  @doc """
  Creates a highlight.

  ## Examples

      iex> create_highlight(%{field: value})
      {:ok, %Highlight{}}

      iex> create_highlight(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_highlight(attrs \\ %{}) do
    %Highlight{}
    |> Highlight.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a highlight.

  ## Examples

      iex> update_highlight(highlight, %{field: new_value})
      {:ok, %Highlight{}}

      iex> update_highlight(highlight, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_highlight(%Highlight{} = highlight, attrs) do
    highlight
    |> Highlight.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a highlight.

  ## Examples

      iex> delete_highlight(highlight)
      {:ok, %Highlight{}}

      iex> delete_highlight(highlight)
      {:error, %Ecto.Changeset{}}

  """
  def delete_highlight(%Highlight{} = highlight) do
    Repo.delete(highlight)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking highlight changes.

  ## Examples

      iex> change_highlight(highlight)
      %Ecto.Changeset{data: %Highlight{}}

  """
  def change_highlight(%Highlight{} = highlight, attrs \\ %{}) do
    Highlight.changeset(highlight, attrs)
  end
end
