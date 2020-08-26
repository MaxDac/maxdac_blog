defmodule MaxdacBlogWeb.SessionController do
  use MaxdacBlogWeb, :controller

  import MaxdacBlog.Users
  import MaxdacBlogWeb.AuthPlug

  @spec new(Plug.Conn.t(), any) :: Plug.Conn.t()
  def new(conn, _) do
    render(conn, "new.html")
  end

  @spec create(Plug.Conn.t(), map) :: Plug.Conn.t()
  def create(
    conn,
    %{
      "session" => %{
        "email" => email,
        "password" => password
      }
    }
  ) do
    case authenticate(email, password) do
      {:ok, user} ->
        conn
        |> login(user)
        |> put_flash(:info, "Welcome back, #{user.username}!")
        |> redirect(to: Routes.page_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid username/password combination.")
        |> render("new.html")
    end
  end

  @spec delete(Plug.Conn.t(), any) :: Plug.Conn.t()
  def delete(conn, _) do
    conn
    |> logout()
    |> put_flash(:info, "You successfully logout. Thank you for sharing your time.")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
