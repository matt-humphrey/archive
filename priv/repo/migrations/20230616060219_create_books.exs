defmodule Archive.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string
      add :rating, :integer
      add :date_read, :date
      add :author_id, references(:authors, on_delete: :nothing)

      timestamps()
    end

    create index(:books, [:author_id])
  end
end
