defmodule TodoAppWeb.Plugs.FetchUserFromSession do
  import Plug.Conn

  def init(args), do: args

  def call(conn, _args) do
    user_id = get_session(conn, :user_id)
    unless is_nil(user_id) do
      user = TodoApp.Users.get_user!(user_id)
      assign(conn, :current_user, user)
    else
      assign(conn, :current_user, nil)
    end
  end
end