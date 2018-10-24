defmodule TodoApp.Users.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    has_many :todo_items, TodoApp.TodoItems.TodoItem, foreign_key: :assigned_to
    many_to_many :managers, __MODULE__, join_through: "managers", join_keys: [managed_id: :id, user_id: :id]
    many_to_many :underlings, __MODULE__, join_through: "managers", join_keys: [user_id: :id, managed_id: :id]

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email])
    |> unique_constraint(:email)
    |> validate_required([:email])
    |> validate_format(:email, ~r/^.+@.+\..+$/)
  end
end
