defmodule MaxdacBlogWeb.SessionController do
  use MaxdacBlogWeb, :controller

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(
    conn,
    %{
      "session" => %{
        "username" => username,
        "password" => password
      }
    }
  ) do
    case Max
  end
end
