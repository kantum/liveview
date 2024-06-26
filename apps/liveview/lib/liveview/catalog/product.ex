defmodule Liveview.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset
  alias Liveview.Catalog.Category

  schema "products" do
    field :description, :string
    field :price, :decimal
    field :title, :string
    field :views, :integer

    timestamps(type: :utc_datetime)

    many_to_many :categories, Category, join_through: "product_categories", on_replace: :delete
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:title, :description, :price, :views])
    |> validate_required([:title, :description, :price, :views])
  end
end
