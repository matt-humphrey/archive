defmodule Archive.HighlightsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Archive.Highlights` context.
  """

  @doc """
  Generate a highlight.
  """
  def highlight_fixture(attrs \\ %{}) do
    {:ok, highlight} =
      attrs
      |> Enum.into(%{
        reference: "some reference",
        content: "some content",
        note: "some note"
      })
      |> Archive.Highlights.create_highlight()

    highlight
  end
end
