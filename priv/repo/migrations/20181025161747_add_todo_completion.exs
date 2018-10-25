defmodule TodoApp.Repo.Migrations.AddTodoCompletion do
  use Ecto.Migration

  def change do
    alter table(:todo_items) do
      # add a completed flag to all todo items in the todo_items table
      add :completed, :boolean, default: false, null: false
    end
  end
end
