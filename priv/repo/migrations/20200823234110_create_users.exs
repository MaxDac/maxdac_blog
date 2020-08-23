defmodule MaxdacBlog.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :avatar, :text
      add :description, :text
      add :email, :string
      add :password_hash, :string
      add :username, :string

      timestamps()
    end

  end
end
