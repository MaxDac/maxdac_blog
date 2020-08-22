defmodule MaxdacBlogWeb.PageControllerTest do
  use MaxdacBlogWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "MaxDac Blog"
  end
end
