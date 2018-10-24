defmodule TodoApp.Repo.Migrations.MakeUserEmailUnique do
  use Ecto.Migration

  def change do
    create unique_index(:users, [:email])      
  end
end
