defmodule Archive.HighlightsTest do
  use Archive.DataCase

  alias Archive.Highlights

  describe "highlights" do
    alias Archive.Highlights.Highlight

    import Archive.HighlightsFixtures

    @invalid_attrs %{reference: nil, content: nil, note: nil}

    test "list_highlights/0 returns all highlights" do
      highlight = highlight_fixture()
      assert Highlights.list_highlights() == [highlight]
    end

    test "get_highlight!/1 returns the highlight with given id" do
      highlight = highlight_fixture()
      assert Highlights.get_highlight!(highlight.id) == highlight
    end

    test "create_highlight/1 with valid data creates a highlight" do
      valid_attrs = %{reference: "some reference", content: "some content", note: "some note"}

      assert {:ok, %Highlight{} = highlight} = Highlights.create_highlight(valid_attrs)
      assert highlight.reference == "some reference"
      assert highlight.content == "some content"
      assert highlight.note == "some note"
    end

    test "create_highlight/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Highlights.create_highlight(@invalid_attrs)
    end

    test "update_highlight/2 with valid data updates the highlight" do
      highlight = highlight_fixture()
      update_attrs = %{reference: "some updated reference", content: "some updated content", note: "some updated note"}

      assert {:ok, %Highlight{} = highlight} = Highlights.update_highlight(highlight, update_attrs)
      assert highlight.reference == "some updated reference"
      assert highlight.content == "some updated content"
      assert highlight.note == "some updated note"
    end

    test "update_highlight/2 with invalid data returns error changeset" do
      highlight = highlight_fixture()
      assert {:error, %Ecto.Changeset{}} = Highlights.update_highlight(highlight, @invalid_attrs)
      assert highlight == Highlights.get_highlight!(highlight.id)
    end

    test "delete_highlight/1 deletes the highlight" do
      highlight = highlight_fixture()
      assert {:ok, %Highlight{}} = Highlights.delete_highlight(highlight)
      assert_raise Ecto.NoResultsError, fn -> Highlights.get_highlight!(highlight.id) end
    end

    test "change_highlight/1 returns a highlight changeset" do
      highlight = highlight_fixture()
      assert %Ecto.Changeset{} = Highlights.change_highlight(highlight)
    end
  end
end
