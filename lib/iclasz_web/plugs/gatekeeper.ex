defmodule Iclasz.Plugs.Gatekeeper do
  @moduledoc """
  Gatekeeper Plug that handles all the authorization for Pages
  """

  import Plug.Conn

  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  alias Iclasz.Accounts
  alias IclaszWeb.Router.Helpers
  alias Iclasz.Schema.User
  @error_message "Invalid Session, Please Login First"

  def init(opts), do: opts

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)

    case not is_nil(user_id) do
      true ->
        authorize(conn, user_id)

      _ ->
        conn
        |> put_flash(:error, @error_message)
        |> redirect(to: Helpers.auth_path(conn, :new))
        |> halt()
    end
  end

  def authorize(conn, user_id) do
    case Accounts.get_user_by_id(user_id) do
      %User{} = user ->
        assign(conn, :current_user, user)

      nil ->
        conn
        |> put_flash(:error, @error_message)
        |> redirect(to: Helpers.session_path(conn, :new))
        |> halt()
    end
  end
end
