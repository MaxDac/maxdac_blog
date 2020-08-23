defmodule MaxdacBlog.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :avatar, :string
    field :description, :string
    field :email, :string
    field :password_hash, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:avatar, :description, :email, :password_hash, :username])
    |> validate_required([:avatar, :description, :email, :password_hash, :username])
  end
end
