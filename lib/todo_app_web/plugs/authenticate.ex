defmodule TodoAppWeb.Plugs.Authenticate do
  use TodoAppWeb, :controller

  def init(args), do: args

  def call(conn, _params) do
    if conn.assigns[:current_user] do
      conn
    else
      conn
      |> put_flash(:error, "Please sign in to access that page.")
      |> redirect(to: Routes.session_path(conn, :login))
      |> halt
    end
  end
end