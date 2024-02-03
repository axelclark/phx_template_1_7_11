defmodule PhxTemplate1711Web.UserConfirmationInstructionsLiveTest do
  use PhxTemplate1711Web.ConnCase, async: true

  import Phoenix.LiveViewTest
  import PhxTemplate1711.AccountsFixtures

  alias PhxTemplate1711.Accounts
  alias PhxTemplate1711.Repo

  setup do
    %{user: user_fixture()}
  end

  describe "Resend confirmation" do
    test "renders the resend confirmation page", %{conn: conn} do
      {:ok, _lv, html} = live(conn, ~p"/users/confirm")
      assert html =~ "Resend confirmation instructions"
    end

    test "sends a new confirmation token", %{conn: conn, user: user} do
      {:ok, lv, _html} = live(conn, ~p"/users/confirm")

      {:ok, conn} =
        lv
        |> form("#resend_confirmation_form", user: %{email: user.email})
        |> render_submit()
        |> follow_redirect(conn, ~p"/")

      assert Phoenix.Flash.get(conn.assigns.flash, :info) =~
               "If your email is in our system"

      assert Repo.get_by!(Accounts.UserToken, user_id: user.id).context == "confirm"
    end

    test "does not send confirmation token if user is confirmed", %{conn: conn, user: user} do
      Repo.update!(Accounts.User.confirm_changeset(user))

      {:ok, lv, _html} = live(conn, ~p"/users/confirm")

      {:ok, conn} =
        lv
        |> form("#resend_confirmation_form", user: %{email: user.email})
        |> render_submit()
        |> follow_redirect(conn, ~p"/")

      assert Phoenix.Flash.get(conn.assigns.flash, :info) =~
               "If your email is in our system"

      refute Repo.get_by(Accounts.UserToken, user_id: user.id)
    end

    test "does not send confirmation token if email is invalid", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/users/confirm")

      {:ok, conn} =
        lv
        |> form("#resend_confirmation_form", user: %{email: "unknown@example.com"})
        |> render_submit()
        |> follow_redirect(conn, ~p"/")

      assert Phoenix.Flash.get(conn.assigns.flash, :info) =~
               "If your email is in our system"

      assert Repo.all(Accounts.UserToken) == []
    end
  end
end
