defmodule Archive.Repo.Migrations.CreateHighlights do
  use Ecto.Migration

  def change do
    create table(:highlights) do
      add :content, :text
      add :note, :text
      add :reference, :string
      add :date, :date
      add :book_id, references(:books, on_delete: :nothing)
      add :author_id, references(:authors, on_delete: :nothing)

      timestamps()
    end

    create index(:highlights, [:book_id])
    create index(:highlights, [:author_id])
  end
end
