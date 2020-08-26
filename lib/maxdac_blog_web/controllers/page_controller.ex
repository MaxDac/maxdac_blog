defmodule MaxdacBlogWeb.PageController do
  use MaxdacBlogWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def biography(conn, _params) do
    render(conn, "biography.html")
  end

  def portfolio(conn, _params) do
    render(conn, "portfolio.html")
  end
end
