defmodule MaxdacBlog.Articles.Section do
  use Ecto.Schema
  import Ecto.Changeset

  alias MaxdacBlog.Articles.Article

  schema "sections" do
    field :content, :string
    field :title, :string
    field :order, :integer

    belongs_to :article, Article

    timestamps()
  end

  @doc false
  def changeset(section, attrs) do
    section
    |> cast(attrs, [:article_id, :title, :content])
    |> validate_required([:article_id, :title, :content])
    |> assoc_constraint(:article)
  end
end
