defmodule ArchiveWeb.HighlightLiveTest do
  use ArchiveWeb.ConnCase

  import Phoenix.LiveViewTest
  import Archive.HighlightsFixtures

  @create_attrs %{reference: "some reference", content: "some content", note: "some note"}
  @update_attrs %{reference: "some updated reference", content: "some updated content", note: "some updated note"}
  @invalid_attrs %{reference: nil, content: nil, note: nil}

  defp create_highlight(_) do
    highlight = highlight_fixture()
    %{highlight: highlight}
  end

  describe "Index" do
    setup [:create_highlight]

    test "lists all highlights", %{conn: conn, highlight: highlight} do
      {:ok, _index_live, html} = live(conn, ~p"/highlights")

      assert html =~ "Listing Highlights"
      assert html =~ highlight.reference
    end

    test "saves new highlight", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/highlights")

      assert index_live |> element("a", "New Highlight") |> render_click() =~
               "New Highlight"

      assert_patch(index_live, ~p"/highlights/new")

      assert index_live
             |> form("#highlight-form", highlight: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#highlight-form", highlight: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/highlights")

      html = render(index_live)
      assert html =~ "Highlight created successfully"
      assert html =~ "some reference"
    end

    test "updates highlight in listing", %{conn: conn, highlight: highlight} do
      {:ok, index_live, _html} = live(conn, ~p"/highlights")

      assert index_live |> element("#highlights-#{highlight.id} a", "Edit") |> render_click() =~
               "Edit Highlight"

      assert_patch(index_live, ~p"/highlights/#{highlight}/edit")

      assert index_live
             |> form("#highlight-form", highlight: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#highlight-form", highlight: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/highlights")

      html = render(index_live)
      assert html =~ "Highlight updated successfully"
      assert html =~ "some updated reference"
    end

    test "deletes highlight in listing", %{conn: conn, highlight: highlight} do
      {:ok, index_live, _html} = live(conn, ~p"/highlights")

      assert index_live |> element("#highlights-#{highlight.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#highlights-#{highlight.id}")
    end
  end

  describe "Show" do
    setup [:create_highlight]

    test "displays highlight", %{conn: conn, highlight: highlight} do
      {:ok, _show_live, html} = live(conn, ~p"/highlights/#{highlight}")

      assert html =~ "Show Highlight"
      assert html =~ highlight.reference
    end

    test "updates highlight within modal", %{conn: conn, highlight: highlight} do
      {:ok, show_live, _html} = live(conn, ~p"/highlights/#{highlight}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Highlight"

      assert_patch(show_live, ~p"/highlights/#{highlight}/show/edit")

      assert show_live
             |> form("#highlight-form", highlight: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#highlight-form", highlight: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/highlights/#{highlight}")

      html = render(show_live)
      assert html =~ "Highlight updated successfully"
      assert html =~ "some updated reference"
    end
  end
end
