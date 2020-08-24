defmodule MaxdacBlog.AuthenticationTest do
  use MaxdacBlog.DataCase

  alias MaxdacBlog.Users
  @user_attrs %{avatar: "some avatar", description: "some description", email: "some email", password: "some password_hash", username: "some username"}

  def fixture(:user) do
    {:ok, user} = Users.create_user(@user_attrs)
    user
  end

  describe "authentication" do
    setup [:create_user]

    test "authentication succeed with the correct password" do
      
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end

end
