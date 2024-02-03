defmodule PhxTemplate1711Web.PageControllerTest do
  use PhxTemplate1711Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Peace of mind from prototype to production"
  end
end
