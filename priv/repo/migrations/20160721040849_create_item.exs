defmodule KezanMarketScreener.Repo.Migrations.CreateItem do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string
      add :description, :string
      add :icon, :string
      add :buy_price, :integer
      add :sell_price, :integer
      add :is_auctionable, :boolean
    end
  end
end
