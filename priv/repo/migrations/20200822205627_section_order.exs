defmodule MaxdacBlog.Repo.Migrations.SectionOrder do
  use Ecto.Migration

  def change do
    alter table(:sections) do
      add :order, :integer
    end
  end
end
