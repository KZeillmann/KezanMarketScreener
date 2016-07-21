defmodule KezanMarketScreener.Repo.Migrations.CreateAuctions do
  use Ecto.Migration

  def change do
    create table(:auctions) do
      add :item, :integer
      add :owner, :string
      add :owner_realm, :string
      add :bid, :integer
      add :buyout, :integer
      add :quantity, :integer
      add :time_left, :string
    end
  end
end
