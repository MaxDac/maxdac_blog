defmodule MaxdacBlogWeb.AdminPlug do
  import Plug.Conn
  import Phoenix.Controller

  alias MaxdacBlog.Users.User

  alias MaxdacBlogWeb.Router.Helpers, as: Routes

  def init(opts), do: opts

  @doc """
  This function redirects the user to the index page if it's not admin.
  """
  @spec redirect(%Plug.Conn{}) :: %Plug.Conn{}
  defp redirect(conn) do
    conn
    |> put_flash(:error, "You must be admin to access this page.")
    |> redirect(to: Routes.page_path(conn, :index))
    |> halt()
  end

  def call(conn = %Plug.Conn {
     assigns: %{
       current_user: %User{admin: true}
     }
  }, _opts), do: conn

  def call(conn, _opts), do: conn |> redirect()
end
