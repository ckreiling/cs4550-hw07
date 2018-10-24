defmodule TodoApp.Managers.Manager do
  use Ecto.Schema
  import Ecto.Changeset


  schema "managers" do
    belongs_to :manager, TodoApp.Users.User, foreign_key: :user_id
    belongs_to :underling, TodoApp.Users.User, foreign_key: :managed_id

    timestamps()
  end

  @doc false
  def changeset(manager, attrs) do
    manager
    |> cast(attrs, [:user_id, :managed_id])
    |> validate_required([:user_id, :managed_id])
  end
end
