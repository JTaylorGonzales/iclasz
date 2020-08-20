defmodule IclaszWeb.RegistrationController do
  use IclaszWeb, :controller

  alias Iclasz.Accounts

  def new(conn, _params) do
    changeset = render(conn, "new.html", changeset: Accounts.registration_changeset())
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Registration Successful")
        |> redirect(to: Routes.dashboard_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
