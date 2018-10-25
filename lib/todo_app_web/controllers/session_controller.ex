defmodule TodoAppWeb.SessionController do
  use TodoAppWeb, :controller

  def login(conn, _params) do
    render(conn, "index.html")
  end

  def logout(conn, _params), do: delete(conn, _params)

  def create(conn, %{"email" => email}) do
    user = TodoApp.Users.get_user_by_email(email)
    if user do
      conn
      |> put_session(:user_id, user.id)
      |> put_flash(:info, "Welcome back #{user.email}")
      |> redirect(to: Routes.user_path(conn, :me))
    else
      conn
      |> put_flash(:error, "There is no Email with this account.")
      |> redirect(to: Routes.session_path(conn, :login))
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:user_id)
    |> put_flash(:info, "Logged out.")
    |> redirect(to: Routes.session_path(conn, :login))
  end
end
