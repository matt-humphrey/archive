defmodule Archive.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string
      add :author, :string
      add :rating, :integer
      add :date_read, :naive_datetime

      timestamps()
    end
  end
end
