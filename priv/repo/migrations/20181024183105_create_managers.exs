defmodule TodoApp.Repo.Migrations.CreateManagers do
  use Ecto.Migration

  def change do
    create table(:managers) do
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :managed_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:managers, [:user_id])
    create index(:managers, [:managed_id])
  end
end
