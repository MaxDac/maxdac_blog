defmodule MaxdacBlogWeb.AuthPlug do
  import Plug.Conn

  alias MaxdacBlog.Users

  def init(opts), do: opts

  @doc """
  The call function checks whether the session has a user_id, and if it has, search for it
  and attach it to the connection.
  """
  @spec call(Plug.Conn.t(), any) :: Plug.Conn.t()
  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    IO.puts "The session user id: #{user_id}"
    user = user_id && Users.get_user!(user_id)
    assign(conn, :current_user, user)
  end

  @doc """
  This function creates the session with the current user attached to it.
  """
  @spec login(Plug.Conn.t(), atom | %{id: any}) :: Plug.Conn.t()
  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  @doc """
  This function performs the logout, deleting the session from the current connection.
  """
  @spec logout(%Plug.Conn{}) :: %Plug.Conn{}
  def logout(conn) do
    conn
    |> configure_session(drop: true)
  end
end
