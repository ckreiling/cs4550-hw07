defmodule TodoApp.TodoItems.TodoItem do
  use Ecto.Schema
  import Ecto.Changeset


  schema "todo_items" do
    field :description, :string
    field :title, :string

    belongs_to :user, TodoApp.Users.User, foreign_key: :assigned_to

    timestamps()
  end

  @doc false
  def changeset(todo_item, attrs) do
    todo_item
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
