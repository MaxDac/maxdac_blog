defmodule MaxdacBlog.Repo.Migrations.CreateSections do
  use Ecto.Migration

  def change do
    create table(:sections) do
      add :title, :string
      add :content, :text
      add :article_id, references(:articles, on_delete: :nothing)

      timestamps()
    end

    create index(:sections, [:article_id])
  end
end
