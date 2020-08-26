defmodule MaxdacBlog.AuthenticationTest do
  use MaxdacBlog.DataCase

  alias MaxdacBlog.Users

  @user_attrs %{avatar: "some avatar", description: "some description", email: "some@email.com", password: "some_pass", username: "some username"}

  def fixture(:user) do
    {:ok, user} = Users.create_user(@user_attrs)
    user
  end

  describe "authentication" do
    setup [:create_user]

    test "authentication succeed with the correct password", %{user: user} do
      result = Users.authenticate("some@email.com", "some_pass")
      assert {:ok, %{user | password: nil}} == result
    end

    test "authentication fails with the incorrect password", %{user: user} do
      result = Users.authenticate("some@email.com", "some_other_pass")
      assert {:error, :unauthorized} == result
    end

    test "authentication fails with the incorrect email", %{user: user} do
      result = Users.authenticate("some.other@email.com", "some_pass")
      assert {:error, :not_found} == result
    end

    test "authentication fails with the incorrect email and password", %{user: user} do
      result = Users.authenticate("some.other@email.com", "some_other_pass")
      assert {:error, :not_found} == result
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end

end
