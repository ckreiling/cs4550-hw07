defmodule TodoAppWeb.ManagerController do
  use TodoAppWeb, :controller

  alias TodoApp.Managers
  alias TodoApp.Managers.Manager
  alias TodoApp.Users

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def new(conn, _params) do
    changeset = Managers.change_manager(%Manager{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"manager" => %{"email" => email}}) do
    manager = conn.assigns[:current_user]
    underling = Users.get_user_by_email(email)
    unless underling do
      conn
      |> put_flash(:error, "That email does not have a user. Register them, then enter them in the form below.")
      |> redirect(to: Routes.manager_path(conn, :new))
      |> halt
    end
    case Managers.create_manager(%{"user_id" => manager.id, "managed_id" => underling.id}) do
      {:ok, manager} ->
        conn
        |> put_flash(:info, "Manager created successfully.")
        |> redirect(to: Routes.manager_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    manager = Managers.get_manager!(id)
    render(conn, "show.html", manager: manager)
  end

  def edit(conn, %{"id" => id}) do
    manager = Managers.get_manager!(id)
    changeset = Managers.change_manager(manager)
    render(conn, "edit.html", manager: manager, changeset: changeset)
  end

  def update(conn, %{"id" => id, "manager" => manager_params}) do
    manager = Managers.get_manager!(id)

    case Managers.update_manager(manager, manager_params) do
      {:ok, manager} ->
        conn
        |> put_flash(:info, "Manager updated successfully.")
        |> redirect(to: Routes.manager_path(conn, :show, manager))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", manager: manager, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    manager = Managers.get_manager!(id)
    {:ok, _manager} = Managers.delete_manager(manager)

    conn
    |> put_flash(:info, "Manager deleted successfully.")
    |> redirect(to: Routes.manager_path(conn, :index))
  end
end
