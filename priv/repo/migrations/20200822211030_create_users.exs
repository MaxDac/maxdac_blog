defmodule MaxdacBlog.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :password_hash, :string
      add :email, :string
      add :avatar, :text
      add :description, :text

      timestamps()
    end

  end
end
