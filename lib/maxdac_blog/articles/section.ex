defmodule MaxdacBlog.Articles.Section do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sections" do
    field :content, :string
    field :title, :string
    field :order, :integer
    field :article_id, :id

    timestamps()
  end

  @doc false
  def changeset(section, attrs) do
    section
    |> cast(attrs, [:title, :content])
    |> validate_required([:title, :content])
  end
end
