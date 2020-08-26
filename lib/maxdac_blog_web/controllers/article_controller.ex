defmodule MaxdacBlogWeb.ArticleController do
  use MaxdacBlogWeb, :controller

  alias MaxdacBlog.Articles

  def index(conn, _params) do
    articles =
      Articles.list_articles()
      |> Enum.sort_by(fn x -> x.inserted_at end)

    render(conn, "index.html", articles: articles)
  end

  def show(conn, %{"id" => id}) do
    with article <- Articles.get_article!(id) do
      render(conn, "show.html", article: article)
    end
  end
end
