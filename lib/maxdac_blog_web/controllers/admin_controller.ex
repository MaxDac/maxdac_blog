defmodule MaxdacBlogWeb.AdminController do
  use MaxdacBlogWeb, :controller

  alias MaxdacBlog.Articles
  alias MaxdacBlog.Articles.Section

  def index(conn, _opts) do
    articles =
      Articles.list_articles()
      |> Enum.sort_by(fn x -> x.inserted_at end)

    render(conn, "index.html", articles: articles)
  end

  def edit_article(conn, %{"id" => article_id}) do
    with article <- Articles.get_article!(article_id) do
      render(conn, "edit_article.html", article: article)
    end
  end

  def new_section(conn, _params) do
    with section <- Articles.change_section(%Section{}) do
      render(conn, "new_section.html", changeset: section)
    end
  end

  def create_section(conn, %{
    "article_id" => article_id,
    "section" => section_params}) do
    params = section_params |> Map.put("article_id", article_id)
    case Articles.create_section(params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Section created successfully.")
        |> redirect(to: Routes.admin_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new_section.html", changeset: changeset)
    end
  end

  def edit_section(conn, %{"id" => id}) do
    section = Articles.get_section!(id)
    changeset = Articles.change_section(section)
    render(conn, "edit_section.html", section: section, changeset: changeset)
  end

  def update_section(conn, %{"id" => id, "section" => section_params}) do
    section = Articles.get_section!(id)

    case Articles.update_section(section, section_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Section updated successfully.")
        |> redirect(to: Routes.admin_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit_section.html", section: section, changeset: changeset)
    end
  end
end
