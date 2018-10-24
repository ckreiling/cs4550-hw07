defmodule TodoApp.Repo.Migrations.CreateTodoItems do
  use Ecto.Migration

  def change do
    create table(:todo_items) do
      add :title, :string, null: false
      add :description, :text
      add :assigned_to, references(:users, on_delete: :nilify_all)

      timestamps()
    end

    create index(:todo_items, [:assigned_to])
  end
end
