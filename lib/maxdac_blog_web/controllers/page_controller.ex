defmodule MaxdacBlogWeb.PageController do
  use MaxdacBlogWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
