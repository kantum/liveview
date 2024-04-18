defmodule Liveview.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :title, :text
      add :description, :text
      add :price, :decimal, precision: 15, scale: 6, null: false
      add :views, :integer, default: 0, null: false
      timestamps(type: :utc_datetime)
    end
  end
end
