defmodule MaxdacBlog.Articles.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :title, :string

    field :sections, :any, virtual: true

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
