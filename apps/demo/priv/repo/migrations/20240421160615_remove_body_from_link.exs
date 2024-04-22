defmodule Demo.Repo.Migrations.RemoveBodyFromLink do
  use Ecto.Migration

  def change do
    alter table(:links) do
      remove :body
    end
  end
end
