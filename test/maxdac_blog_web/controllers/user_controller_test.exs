defmodule MaxdacBlogWeb.UserControllerTest do
  use MaxdacBlogWeb.ConnCase

  alias MaxdacBlog.Users

  @create_attrs %{avatar: "some avatar", description: "some description", email: "some email", password: "some password_hash", username: "some username"}
  @update_attrs %{avatar: "some updated avatar", description: "some updated description", email: "some updated email", password: "some updated password_hash", username: "some updated username"}
  @invalid_attrs %{avatar: nil, description: nil, email: nil, password: nil, username: nil}

  @other_attrs %{avatar: "some other avatar", description: "some other description", email: "some.other@email.com", password: "some_other_pass", username: "some_other_user"}

  def fixture(:user) do
    {:ok, user} = Users.create_user(@create_attrs)
    user
  end

  def authenticate_for_test(conn) do
    {:ok, _} = Users.create_user(@other_attrs)
    post(conn, Routes.session_path(conn, :create, %{"session" => %{
      "email" => "some.other@email.com",
      "password" => "some_other_pass"
    }}))
  end

  # TODO: find a way to test authorization-required pages
  # describe "index" do
  #   test "lists all users", %{conn: conn} do
  #     # Login
  #     conn = authenticate_for_test(conn)
  #     conn = get(conn, Routes.user_path(conn, :index))
  #     assert html_response(conn, 200) =~ "Listing Users"
  #   end
  # end

  describe "new user" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :new))
      assert html_response(conn, 200) =~ "New User"
    end
  end

  describe "create user" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)

      assert redirected_to(conn) == Routes.page_path(conn, :index)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert html_response(conn, 200) =~ "New User"
    end
  end

  describe "edit user" do
    setup [:create_user]

    test "renders form for editing chosen user", %{conn: conn, user: user} do
      conn = get(conn, Routes.user_path(conn, :edit, user))
      assert html_response(conn, 200) =~ "Edit User"
    end
  end

  describe "update user" do
    setup [:create_user]

    # TODO - it doesn't work
    # test "redirects when data is valid", %{conn: conn, user: user} do
    #   conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
    #   assert redirected_to(conn) == Routes.user_path(conn, :show, user)

    #   conn = get(conn, Routes.user_path(conn, :show, user))
    #   assert html_response(conn, 200) =~ "some updated avatar"
    # end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit User"
    end
  end

  # TODO find a way to test authorization pages
  # describe "delete user" do
  #   setup [:create_user]

  #   test "deletes chosen user", %{conn: conn, user: user} do
  #     conn = delete(conn, Routes.user_path(conn, :delete, user))
  #     assert redirected_to(conn) == Routes.user_path(conn, :index)

  #     # Login
  #     conn = authenticate_for_test(conn)

  #     assert_error_sent 404, fn ->
  #       get(conn, Routes.user_path(conn, :show, user))
  #     end
  #   end
  # end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
