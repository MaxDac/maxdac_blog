defmodule MaxdacBlog.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  # @email_regex ~r/^[a-zA-Z0-9.!#$%&'*+/=?^_'{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/

  schema "users" do
    field :avatar, :string
    field :description, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :username, :string

    timestamps()
  end

  @doc """
  Put the password hash on the Ecto changeset.
  """
  @spec put_pass_hash(%Ecto.Changeset{}) :: %Ecto.Changeset{}
  def put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(pass))
      _ ->
        changeset
    end
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password, :email, :avatar, :description])
    |> validate_required([:username, :password, :email, :avatar, :description])
    |> validate_length(:username, min: 5, max: 20)
    |> validate_length(:password, min: 5, max: 20)
    |> put_pass_hash()
  end
end
